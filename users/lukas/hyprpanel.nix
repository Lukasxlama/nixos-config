{
  inputs,
  pkgs,
  osConfig,
  lib,
  ...
}:

{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar = {
        layouts."0" = {
          left = [
            "dashboard"
            "workspaces"
          ];
          middle = [ "windowtitle" ];
          right = [
            "volume"
            "bluetooth"
            "network"
            "battery"
            "notifications"
            "clock"
          ];
        };

        # Fenster-Titel minimalistisch (wie Waybar)
        windowtitle = {
          max_length = 40;
          # Zeigt nur den Klassennamen (z.B. "firefox") statt des langen Tab-Namens
          # Wenn du den Tab-Namen willst, setze dies auf false
          title_placeholder = "Desktop";
        };

        workspaces = {
          workspaces = 9; # 0-9 wie gewünscht
          show_icons = false;
          show_numbered = true;
        };
      };

      # Dashboard minimalistisch umbauen
      menus.dashboard = {
        user.name = "Lukas";
        # Wir deaktivieren die unnötigen Widgets für mehr Minimalismus
        shortcuts.enabled = false;
        directories.enabled = false;
        stats.enabled = true; # CPU, RAM, Disk
      };

      # Batterie Fix
      # Wir weisen HyprPanel an, auf dem ThinkPad nach der richtigen Hardware zu suchen
      system.battery.device = "BAT0";

      theme = {
        font = {
          name = "Fira Sans Semibold";
          size = "13px";
        };

        bar = {
          transparent = true;
          buttons = {
            # Hintergrund der Labels leicht transparent (0.8)
            # Wir nutzen hier die Standardfarben, aber regeln die Deckkraft
            opacity = 80;
            radius = "12px";
          };
        };
      };
    };
  };

  # Deaktiviere swaync, da HyprPanel alles übernimmt
  services.swaync.enable = false;

  home.packages = with pkgs; [
    hyprpicker
    hyprsunset
    hypridle
    btop
    grimblast
  ];
}
