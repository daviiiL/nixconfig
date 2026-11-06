{
  config,
  lib,
  ...
}: let
  cfg = config.localHome.programs.development.git;
in {
  options.localHome.programs.development.git.enable =
    lib.mkEnableOption "git with user identity and global ignores";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings.user = {
        name = "David Liu";
        email = "davidas99017@gmail.com";
      };

      ignores = [
        # agent instructions
        "AGENTS.md"
        "CLAUDE.md"
        "GEMINI.md"

        # agent state
        ".aider/"
        ".claude/"
        ".claude/settings.local.json"
        ".cursor/"
        ".cursorignore"
        ".cursorrules"
        ".gemini/"
        ".gemini-clipboard/"
        ".codex/"
        ".opencode/"

        # logs
        "*.jsonl"
        "*.log"
        ".aider.input.history"
        ".aider.chat.history.md"
        ".aider.tags.cache.v3"
        ".claude-history"
        "gemini-debug.log"

        # superpowers output
        "docs/superpowers/"
        ".superpowers/"

        # local
        ".local/"
        ".sdkmanrc"

        # ide
        ".idea/"
      ];
    };
  };
}
