{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            position = "0,0";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "BOE NE135A1M-NY1";
            status = "disable";
          }
          {
            criteria = "DP-1";
            position = "0,0";
          }
        ];
      }
    ];
  };
}
