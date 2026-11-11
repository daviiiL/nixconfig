{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.development.languages.python;
in {
  options.localHome.programs.development.languages.python.enable =
    lib.mkEnableOption "Python 3 with data science libraries, pyright, ruff and uv";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (python3.withPackages (ps:
        with ps; [
          numpy
          pandas
          polars
          pyarrow
          openpyxl
          scipy
          scikit-learn
          statsmodels
          matplotlib
          seaborn
          plotly
          jupyterlab
          ipykernel
          ipython
          tqdm
          requests
        ]))
      pyright
      ruff
      uv
    ];
  };
}
