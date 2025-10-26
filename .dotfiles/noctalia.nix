{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    colors = {
      mError = "#dddddd";
      mOnError = "#111111";
      mOnPrimary = "#111111";
      mOnSecondary = "#111111";
      mOnSurface = "#828282";
      mOnSurfaceVariant = "#5d5d5d";
      mOnTertiary = "#111111";
      mOutline = "#3c3c3c";
      mPrimary = "#aaaaaa";
      mSecondary = "#a7a7a7";
      mShadow = "#000000";
      mSurface = "#111111";
      mSurfaceVariant = "#191919";
      mTertiary = "#cccccc";
    };
    settings = {
      bar = {
        density = "compact";
        position = "right";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "SidePanelToggle";
              useDistroLogo = true;
            }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/mrbrooks/.face";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "USA";
      };
    };
  };
}
