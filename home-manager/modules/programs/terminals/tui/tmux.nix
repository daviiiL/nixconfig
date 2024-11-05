{
  pkgs,
  inputs,
  ...
}: {
  programs.tmux = {
    enable = true;
    catppuccin.enable = true;
    clock24 = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    mouse = true;
    terminal = "screen-256color";
  };
}
