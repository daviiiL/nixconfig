#!/usr/bin/env bash
set -euo pipefail

CORSAIR_VID=1b1c

usage() {
    cat >&2 <<EOF
Usage: $0 <1|2>
  1  chmod a+rw on all Corsair hidraw devices
  2  restore default 600 permissions on the same devices
EOF
    exit 1
}

[[ $# -eq 1 ]] || usage

case "$1" in
    1) mode="a+rw" ;;
    2) mode="600" ;;
    *) usage ;;
esac

mapfile -t devices < <(
    for d in /sys/class/hidraw/hidraw*; do
        [[ -e "$d/device/uevent" ]] || continue
        if grep -qiE "^HID_ID=[0-9a-f]+:0*${CORSAIR_VID}:" "$d/device/uevent"; then
            echo "/dev/$(basename "$d")"
        fi
    done
)

if [[ ${#devices[@]} -eq 0 ]]; then
    echo "No Corsair hidraw devices found (VID=${CORSAIR_VID})" >&2
    exit 1
fi

echo "Found ${#devices[@]} Corsair hidraw device(s):"
printf '  %s\n' "${devices[@]}"
echo "Applying mode: ${mode}"

sudo chmod "${mode}" "${devices[@]}"

echo "Done. Current state:"
ls -l "${devices[@]}"
