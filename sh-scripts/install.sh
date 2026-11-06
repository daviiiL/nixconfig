#!/usr/bin/env bash
if [[ ! -f ${BASH_SOURCE[0]:-} ]]; then
  self=$(mktemp /tmp/nixinstall.XXXXXX.sh)
  cat >"$self"
  if [[ -r /dev/tty ]]; then exec bash "$self" "$@" </dev/tty; else exec bash "$self" "$@"; fi
fi

set -uo pipefail

SELF=$(readlink -f "${BASH_SOURCE[0]}")
REPO_URL=${REPO_URL:-https://github.com/daviiiL/nixconfig}
PWFILE=/tmp/disko-password
export SELF REPO_URL PWFILE
export NIX_CONFIG="experimental-features = nix-command flakes"
export SHELL=${BASH:-bash}

G=$'\e[32m' R=$'\e[31m' Y=$'\e[33m' C=$'\e[36m' B=$'\e[1m' D=$'\e[2m' N=$'\e[0m'
OK="${G}✓${N}" BAD="${R}✗${N}" WARN="${Y}!${N}"
STAGES=(disko install repo done)

usage() {
  cat <<EOF
usage: install.sh [-n|--dry-run] [host]

  curl -fsSL https://raw.githubusercontent.com/daviiiL/nixconfig/main/sh-scripts/install.sh | sudo bash
  curl -fsSL .../install.sh | sudo bash -s -- invictia

  -n, --dry-run   go through everything, fake the install, touch nothing
EOF
}

has() { command -v "$1" >/dev/null 2>&1; }
os() { (. /etc/os-release 2>/dev/null; echo "${!1:-}"); }
is_nixos() { [[ $(os ID) == nixos || -e /etc/NIXOS ]]; }
is_live() { [[ $(os VARIANT_ID) == installer ]]; }
dmi() { tr -d '\n' <"/sys/class/dmi/id/$1" 2>/dev/null; }
title() { printf '\n%s%s%s\n' "$B$C" "$1" "$N"; }
kv() { printf '  %-13s %s\n' "$1" "$2"; }
q() { jq -r --arg h "$HOST" ".[\$h] | $1" "$STATE/hosts.json"; }
dev() { q .device; }
st() { cat "$STATE/stage.$1" 2>/dev/null || echo wait; }
have_hosts() { [[ -s ${STATE:-}/hosts.json ]]; }

efivar() {
  local f=/sys/firmware/efi/efivars/$1-8be4df61-93ca-11d2-aa0d-00e098032b8c
  [[ -e $f ]] && od -An -t u1 -j4 -N1 "$f" | tr -d ' '
}

online() {
  local f=${STATE:-/tmp}/online
  if [[ ! -f $f ]] || (($(date +%s) - $(stat -c %Y "$f") > 30)); then
    curl -fsI --max-time 4 https://cache.nixos.org >/dev/null 2>&1 && echo 1 >"$f" || echo 0 >"$f"
  fi
  [[ $(<"$f") == 1 ]]
}

sysinfo() {
  title machine
  kv model "$(dmi sys_vendor) $(dmi product_name)"
  kv board "$(dmi board_vendor) $(dmi board_name)"
  kv bios "$(dmi bios_version) $(dmi bios_date)"
  kv kernel "$(uname -r) $(uname -m)"
  kv cpu "$(lscpu | sed -n 's/^Model name:[[:space:]]*//p')"
  kv threads "$(nproc)"
  kv memory "$(awk '/MemTotal/{printf "%.1f GiB", $2/1048576}' /proc/meminfo)"

  title firmware
  if [[ -d /sys/firmware/efi ]]; then
    kv mode "uefi"
    kv secureboot "$([[ $(efivar SecureBoot) == 1 ]] && echo on || echo off)"
    kv setupmode "$([[ $(efivar SetupMode) == 1 ]] && echo yes || echo no)"
  else
    kv mode "${R}bios${N}"
  fi

  title system
  kv os "$(os PRETTY_NAME)"
  kv live "$(is_live && echo yes || echo no)"
  kv nix "$(has nix && nix --version || echo none)"
  kv user "$(id -un)"

  title network
  kv internet "$(online && echo ok || echo "${R}offline${N}")"
  kv ipv4 "$(ip -o -4 addr show scope global 2>/dev/null | awk '{print $2" "$4}' | paste -sd, -)"

  title disks
  lsblk -dpno NAME,SIZE,TRAN,MODEL -e 1,7,11 | sed 's/^/  /'
  have_hosts || return 0
  local h d
  while IFS=$'\t' read -r h d; do
    [[ -e $d ]] && printf '  %s %s is the disk of %s\n' "$OK" "$(readlink -f "$d")" "$h"
  done < <(jq -r 'to_entries[] | select(.value.disko) | [.key, .value.device] | @tsv' "$STATE/hosts.json")
}

compat() {
  local rc=0 nixos=0 nix=0 mem
  ok() { printf '  %s %s\n' "$OK" "$1"; }
  warn() { printf '  %s %s\n' "$WARN" "$1"; ((rc)) || rc=1; }
  no() { printf '  %s %s\n' "$BAD" "$1"; rc=2; }

  is_nixos && nixos=1
  has nix && nix=1
  title compatibility
  if ((nixos)); then
    is_live && ok "nixos installer $(os VERSION_ID)" || warn "nixos, but not the installer"
  elif ((nix)); then
    warn "$(os PRETTY_NAME), not nixos"
  else
    no "$(os PRETTY_NAME), not nixos"
  fi
  ((nix)) && ok "$(nix --version)" || no "no nix"
  has nixos-install && ok "nixos-install" || { ((nix)) && warn "nixos-install comes from nixpkgs"; }
  ((EUID == 0)) && ok "root" || no "not root"
  [[ -d /sys/firmware/efi ]] && ok "uefi" || no "no uefi"
  [[ $(uname -m) == x86_64 ]] && ok "x86_64" || warn "$(uname -m), hosts are x86_64"
  online && ok "internet" || no "no internet"
  mem=$(awk '/MemTotal/{print int($2/1048576)}' /proc/meminfo)
  ((mem >= 4)) && ok "${mem}G ram" || warn "${mem}G ram, builds may oom"
  if have_hosts; then
    local n
    n=$(jq '[.[] | select(.disko)] | length' "$STATE/hosts.json")
    ((n)) && ok "$n disko host(s)" || no "no host with disko"
  fi

  echo
  case $rc in
    0) echo "  ${B}${G}YES${N}" ;;
    1) echo "  ${B}${Y}YES${N} with warnings" ;;
    2) echo "  ${B}${R}NO${N}" ;;
  esac
  return $rc
}

install_info() {
  title install
  echo "  pick a host, check the layout, say yes, give a passphrase."
  echo "  disko wipes the disk, nixos-install builds, output shows here."
  echo
  compat | tail -1
  [[ -n ${DRY:-} ]] && echo "  ${Y}dry run, nothing blocks and nothing runs${N}"
  return 0
}

hostlist() {
  jq -r 'to_entries[] | [.key, .value.user, (if .value.disko then "disko" else "-" end),
    (if .value.secureBoot then "sb" else "-" end), (.value.device // "-")] | @tsv' "$STATE/hosts.json" |
    while IFS=$'\t' read -r h u d s v; do
      line=$(printf '%-10s %-9s %-6s %-3s %s' "$h" "$u" "$d" "$s" "$v")
      [[ $d == disko ]] || line="$D$line$N"
      printf '%s\t%s\n' "$h" "$line"
    done
}

diskline() {
  local d=$1
  if [[ -e $d ]]; then
    printf '  %s %s %s\n' "$OK" "$(readlink -f "$d")" "$(lsblk -dno SIZE,MODEL "$(readlink -f "$d")" | xargs)"
  else
    printf '  %s not on this machine\n' "$BAD"
  fi
}

summary() {
  local d
  d=$(dev)
  title "host $HOST"
  kv system "$(q .system)"
  kv channel "$(q .channel)"
  kv state "$(q .stateVersion)"

  title storage
  echo "  ${B}${R}whole disk gets wiped${N}"
  kv disk "$d"
  diskline "$d"
  echo "  gpt"
  q '
    def o: (.opts // []) | if length > 0 then "  " + join(",") else "" end;
    .layout // {} | to_entries | sort_by(.value.priority // 9999, .key)[] |
    "  ├ \(.key)  \(.value.size)  " + (
      if .value.type == "luks" then
        "luks \(.value.luksName)" + (if .value.allowDiscards then " discard" else "" end) +
        "\n  │   └ \(.value.inner)" +
        ([.value.subvols | to_entries[] |
          "\n  │       \(.key)  \(.value.mountpoint // "-")" +
          (if .value.swap then "  swap \(.value.swap)" else "" end) + (.value | o)] | join(""))
      else
        "\(.value.format // .value.type)  \(.value.mountpoint // "")" + (.value | o)
      end)'

  title user
  kv name "$(q .user)"
  kv gecos "$(q .description)"
  kv home "$(q .home)"
  kv groups "$(q '.groups | join(" ")')"
  kv password "$(q 'if .hasPassword then "from config" else "none, passwd after boot" end')"
  kv admin "$(q '[(if .doas then "doas" else empty end), (if .sudo then "sudo" else empty end)] | join(" ")')"
  kv root "no password"

  title boot
  if [[ $(q .secureBoot) == true ]]; then
    kv loader "lanzaboote"
    kv oemkeys "$(q 'if .firmwareKeys then "kept" else "dropped" end')"
  else
    kv loader "systemd-boot"
  fi
}

hostinfo() {
  HOST=$1
  if [[ $(q .disko) == true ]]; then
    summary
  else
    title "$HOST"
    echo "  $BAD no disko layout, install by hand"
  fi
}

label() {
  case $1 in
    install) echo "nixos-install" ;;
    repo) echo "copy repo" ;;
    *) echo "$1" ;;
  esac
}

stages() {
  local s m
  for s in "${STAGES[@]}"; do
    case $(st "$s") in
      run) m="$Y▶$N" ;;
      ok) m="$G✓$N" ;;
      fail) m="$R✗$N" ;;
      *) m="$D·$N" ;;
    esac
    printf '%s\t%s %s\n' "$s" "$m" "$(label "$s")"
  done
}

showlog() {
  local s=$1
  [[ $s == done ]] && { finished; return; }
  case $(st "$s") in
    wait) echo "${D}waiting${N}" ;;
    run) tail -n +1 -F --pid="$(<"$STATE/runner.pid")" "$STATE/log/$s.log" 2>/dev/null ;;
    *) cat "$STATE/log/$s.log" ;;
  esac
}

finished() {
  [[ -f $STATE/result ]] || { echo "${D}running${N}"; return; }
  if [[ $(<"$STATE/result") == 0 ]]; then
    echo "$OK $HOST installed${DRY:+ (dry run)}"
    echo
    sbnote
    echo "enter to exit"
  else
    echo "$BAD $(<"$STATE/failed")"
    echo "log: /tmp/nixinstall-$HOST.log"
  fi
}

sbnote() {
  [[ $(q .secureBoot) == true ]] || return 0
  cat <<'EOF'
secure boot: keys get generated on first boot. go into the firmware,
turn secure boot on, reset to setup mode, reboot. lanzaboote enrolls
the keys on that boot. check with sbctl status.

EOF
}

pane() {
  case $1 in
    sysinfo) sysinfo ;;
    compat) compat ;;
    install) install_info ;;
    quit) title quit ;;
    summary) summary ;;
    yes) local d; d=$(dev); title "wipe $d and install $HOST"; diskline "$d" ;;
    no) title "back out, nothing changes" ;;
    stages) stages ;;
    log) showlog "$2" ;;
    hostlist) hostlist ;;
    host) hostinfo "$2" ;;
  esac
}

post() {
  local port
  port=$(cat "$STATE/port" 2>/dev/null) || return 0
  curl -s --max-time 2 -XPOST "localhost:$port" -d "$1" >/dev/null 2>&1
}

mark() {
  echo "$2" >"$STATE/stage.$1.tmp" && mv "$STATE/stage.$1.tmp" "$STATE/stage.$1"
  local i
  for i in "${!STAGES[@]}"; do [[ ${STAGES[i]} == "$1" ]] && break; done
  post "reload-sync(bash \"\$SELF\" --pane stages)+pos($((i + 1)))+refresh-preview"
}

step() {
  local s=$1 rc
  shift
  mark "$s" run
  printf '\n$ %s\n\n' "$*" | tee -a "$LOG" >>"$STATE/log/$s.log"
  "$@" 2>&1 | tee -a "$LOG" >>"$STATE/log/$s.log"
  rc=${PIPESTATUS[0]}
  if ((rc == 0)); then
    mark "$s" ok
    return
  fi
  echo "$(label "$s") failed ($rc)" >"$STATE/failed"
  echo "$rc" >"$STATE/result"
  mark "$s" fail
  post "change-header:$(label "$s") failed ($rc), enter to exit"
  exit "$rc"
}

fake() {
  local i
  echo "would run: $*"
  for ((i = 1; i <= 12; i++)); do
    echo "fake output $i"
    sleep 0.4
  done
}

copy_repo() {
  local home=/mnt$(q .home)
  mkdir -p "$home/.config"
  rm -rf "$home/.config/nixconfig"
  git clone "$REPO" "$home/.config/nixconfig"
  git -C "$home/.config/nixconfig" remote set-url origin git@github.com:daviiiL/nixconfig.git
  nixos-enter --root /mnt -c "chown -R $(q .user): $(q .home)"
}

run() {
  echo $$ >"$STATE/runner.pid"
  cd "$REPO" || exit 1
  local x=()
  [[ -n ${DRY:-} ]] && x=(fake)
  step disko "${x[@]}" nix run -L github:nix-community/disko/latest -- \
    --mode destroy,format,mount --yes-wipe-all-disks --flake ".#$HOST"
  [[ -n ${DRY:-} ]] || shred -u "$PWFILE" 2>/dev/null || rm -f "$PWFILE"
  step install "${x[@]}" nixos-install -v --flake ".#$HOST" --no-root-passwd
  step repo "${x[@]}" copy_repo
  mark done ok
  echo 0 >"$STATE/result"
  post "change-header:$HOST done${DRY:+ (dry run)}, enter to exit"
}

case ${1:-} in
  --pane) shift; pane "$@"; exit 0 ;;
  --compat) compat >/dev/null; exit $? ;;
  --run) run; exit 0 ;;
esac

DRY=${DRY:-} ARG=""
for a in "$@"; do
  case $a in
    -n | --dry-run) DRY=1 ;;
    -h | --help) usage; exit 0 ;;
    -*) usage >&2; exit 1 ;;
    *) ARG=$a ;;
  esac
done
export DRY
TAG=${DRY:+ (dry run)}

if has nix && [[ -z ${IN_SHELL:-} ]]; then
  tools=()
  has fzf || tools+=(nixpkgs#fzf)
  has git || tools+=(nixpkgs#git)
  has jq || tools+=(nixpkgs#jq)
  has curl || tools+=(nixpkgs#curl)
  has nixos-install || tools+=(nixpkgs#nixos-install-tools)
  if ((${#tools[@]})); then
    echo "getting ${tools[*]#nixpkgs#}"
    IN_SHELL=1 exec nix shell "${tools[@]}" --command bash "$SELF" "$@"
  fi
fi

STATE=$(mktemp -d /tmp/nixinstall.XXXXXX)
LOG=$STATE/install.log
mkdir -p "$STATE/log"
export STATE LOG HOST="" REPO=""

cleanup() {
  [[ -f $PWFILE ]] && { shred -u "$PWFILE" 2>/dev/null || rm -f "$PWFILE"; }
  [[ -f $STATE/runner.pid ]] || rm -rf "$STATE"
}
trap cleanup EXIT
trap 'exit 130' INT TERM

if ! has fzf || ! has jq; then
  sysinfo
  compat
  echo "  need fzf and jq for the menu"
  exit 2
fi

FZF=(
  --ansi --layout=reverse --border=rounded --no-multi --cycle --info=hidden
  --with-shell 'bash -c' --delimiter $'\t' --with-nth '2..' --accept-nth 1
  --header-first --pointer '▶'
  --preview-window 'right,65%,wrap,border-left,<100(down,60%,wrap,border-top)'
)

demo_hosts() {
  local disk
  disk=$(lsblk -dpno NAME,TYPE -e 1,7,11 | awk '$2 == "disk" {print $1; exit}')
  echo "no nix, using a demo host on ${disk:-nothing}"
  jq -n --arg dev "${disk:-/dev/null}" --arg user "${SUDO_USER:-$(id -un)}" '
    def sv(m): {mountpoint: m, opts: ["compress=zstd", "noatime"]};
    {demo: {user: $user, channel: "stable", system: "x86_64-linux", stateVersion: "25.11",
      disko: true, device: $dev, swap: 32, secureBoot: false, firmwareKeys: true,
      description: "demo", home: "/home/\($user)", hasPassword: false,
      groups: ["networkmanager", "wheel", "video", "input"], doas: false, sudo: true,
      layout: {
        ESP: {size: "1G", priority: 1000, format: "vfat", mountpoint: "/boot", opts: ["fmask=0077", "dmask=0077"]},
        luks: {size: "100%", priority: 9001, type: "luks", luksName: "cryptroot", allowDiscards: true, inner: "btrfs",
          subvols: {"@": sv("/"), "@home": sv("/home"), "@nix": sv("/nix"), "@swap": {mountpoint: "/.swap", swap: "32G"}}}}}}' \
    >"$STATE/hosts.json"
}

load_hosts() {
  have_hosts && return
  REPO=$(dirname "$(dirname "$SELF")")
  export REPO
  if [[ -n $DRY ]] && ! has nix; then
    demo_hosts
    return
  fi
  if [[ ! -f $REPO/flake.nix ]]; then
    REPO=/tmp/nixconfig
    [[ -d $REPO/.git ]] || git clone "$REPO_URL" "$REPO" || return 1
  fi
  echo "evaluating $REPO, first time pulls the inputs"
  nix eval --json "$REPO#nixosConfigurations" --apply "$(cat <<'NIX'
cs: builtins.mapAttrs (_: s: let
  c = s.config;
  h = s._module.specialArgs.host;
  u = c.users.users.${h.user} or {};
  dk = c.localSystem.disko;
  part = p: {
    size = p.size;
    priority = p.priority or null;
    type = p.content.type or null;
    format = p.content.format or null;
    mountpoint = p.content.mountpoint or null;
    opts = p.content.mountOptions or [];
    luksName = p.content.name or null;
    allowDiscards = p.content.settings.allowDiscards or false;
    inner = p.content.content.type or null;
    subvols = builtins.mapAttrs (_: v: {
      mountpoint = v.mountpoint or null;
      opts = v.mountOptions or [];
      swap = v.swap.swapfile.size or null;
    }) (p.content.content.subvolumes or {});
  };
in {
  inherit (h) user channel system;
  stateVersion = c.system.stateVersion;
  disko = dk.enable;
  device = if dk.enable then dk.device else null;
  swap = if dk.enable then dk.swapSizeGiB else null;
  layout = if dk.enable then builtins.mapAttrs (_: part) c.disko.devices.disk.main.content.partitions else null;
  secureBoot = c.boot.lanzaboote.enable or false;
  firmwareKeys = c.localSystem.core.boot.firmwareBuiltinKeys or true;
  description = u.description or "";
  home = u.home or "/home/${h.user}";
  hasPassword = (u.hashedPassword or null) != null;
  groups = u.extraGroups or [];
  doas = c.security.doas.enable or false;
  sudo = c.security.sudo.enable or false;
}) cs
NIX
)" >"$STATE/hosts.tmp" && mv "$STATE/hosts.tmp" "$STATE/hosts.json"
}

MSG=""

menu() {
  printf '%s\t%s\n' sysinfo "system info" compat "compatibility" install "install" quit "quit" |
    fzf "${FZF[@]}" --disabled --prompt '> ' \
      --header "${MSG:-enter to pick, esc to quit}" \
      --border-label " nixconfig$TAG " \
      --preview 'bash "$SELF" --pane {1}' \
      --bind 'enter:transform:[[ {1} == install || {1} == quit ]] && echo accept || echo refresh-preview'
}

pick() {
  bash "$SELF" --pane hostlist |
    fzf "${FZF[@]}" --prompt 'host > ' \
      --header "${MSG:-host       user      disko  sb  disk}" \
      --border-label " hosts$TAG " \
      --preview 'bash "$SELF" --pane host {1}'
}

confirm() {
  printf '%s\t%s\n' summary "layout" sysinfo "system info" compat "compatibility" yes "yes, wipe and install" no "no" |
    fzf "${FZF[@]}" --disabled --prompt '> ' \
      --header "${MSG:-install $HOST on $(dev)?${DRY:+ (dry run, nothing gets wiped)}}" \
      --border-label " $HOST$TAG " \
      --preview 'bash "$SELF" --pane {1}' \
      --bind 'enter:transform:[[ {1} == yes || {1} == no ]] && echo accept || echo refresh-preview'
}

progress() {
  local start='execute-silent:echo "$FZF_PORT" >"$STATE/port"'
  [[ -f $STATE/runner.pid ]] || start+='; setsid -f bash "$SELF" --run </dev/null >/dev/null 2>&1; sleep 0.3'
  bash "$SELF" --pane stages |
    fzf "${FZF[@]}" --disabled --listen --prompt '> ' \
      --header "installing $HOST, don't power off, esc to abort" \
      --border-label " $HOST$TAG " \
      --preview 'bash "$SELF" --pane log {1}' \
      --preview-window 'right,72%,follow,nowrap,border-left,<100(down,70%,follow,nowrap,border-top)' \
      --bind "start:$start" \
      --bind 'enter:transform:[[ -f $STATE/result ]] && echo accept || echo ignore'
}

passphrase() {
  local a b
  umask 077
  echo
  while :; do
    read -rsp "luks passphrase: " a </dev/tty || return 1
    echo
    read -rsp "again: " b </dev/tty || return 1
    echo
    [[ -n $a && $a == "$b" ]] && break
    echo "no match"
  done
  [[ -n $DRY ]] || printf '%s' "$a" >"$PWFILE"
}

choose_host() {
  local h
  load_hosts || { MSG="$BAD flake eval failed"; return 1; }
  if [[ -n $ARG ]]; then
    h=$ARG
    ARG=""
  else
    MSG=""
    h=$(pick) || return 1
  fi
  case $(jq -r --arg h "$h" 'if has($h) then .[$h].disko else "none" end' "$STATE/hosts.json") in
    none) MSG="$BAD no host $h"; return 1 ;;
    false) MSG="$BAD $h has no disko layout"; return 1 ;;
  esac
  HOST=$h
  export HOST
}

wait_install() {
  local rc a
  while :; do
    progress
    if [[ -f $STATE/result ]]; then
      rc=$(<"$STATE/result")
      cp "$LOG" "/tmp/nixinstall-$HOST.log"
      echo
      if ((rc)); then
        cat "$STATE/failed"
      else
        echo "$HOST installed${TAG}"
        [[ -n $DRY ]] || sbnote
      fi
      echo "log: /tmp/nixinstall-$HOST.log"
      exit "$((rc ? 1 : 0))"
    fi
    read -rp "abort? [y/N] " a </dev/tty
    if [[ $a == [yY]* ]]; then
      kill -- -"$(<"$STATE/runner.pid")" 2>/dev/null
      cp "$LOG" "/tmp/nixinstall-$HOST.log" 2>/dev/null
      echo "aborted, disk may be half done. log: /tmp/nixinstall-$HOST.log"
      exit 1
    fi
  done
}

c=""
[[ -n $ARG ]] && c=install
while :; do
  [[ -n $c ]] || c=$(menu) || exit 0
  case $c in
    quit) exit 0 ;;
    install)
      c=""
      bash "$SELF" --compat
      if (($? == 2)) && [[ -z $DRY ]]; then
        MSG="$BAD blocked, see compatibility"
        ARG=""
        continue
      fi
      choose_host || continue
      MSG=""
      while :; do
        c=$(confirm) || exit 0
        [[ $c == no ]] && exit 0
        [[ -e $(dev) ]] && break
        MSG="$BAD $(dev) isn't here"
      done
      passphrase || exit 0
      wait_install
      ;;
    *) c="" ;;
  esac
done
