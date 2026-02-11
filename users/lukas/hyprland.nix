{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # --- Autostart ---
      # Setzt den Cursor beim Hyprland-Start (Fix für leeren Desktop)
      exec-once = [
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ];

      # --- Monitor & Input ---
      monitor = [
        ",preferred,auto,1"
      ];

      input = {
        kb_layout = "de";
        kb_variant = "";
        follow_mouse = 1;
        touchpad.natural_scroll = false;
      };

      # --- Look & Feel ---
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        # Farbverlauf passend zum Orchis-Theme
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        
        # Standard-Verhalten: Aktiv = Deckend, Inaktiv = Transparent
        active_opacity = 0.9;
        inactive_opacity = 0.8;

        blur = {
          enabled = true;
          size = 6;
          passes = 3; # Hohe Qualität für echte Hardware
          new_optimizations = true;
          ignore_opacity = true; # Wichtig, damit Blur auch bei Transparenz wirkt
          xray = false;
        };

        # Schatten-Konfiguration (Neue Syntax Struktur)
        shadow = {
          enabled = true;
          range = 15;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      # --- Animationen ---
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # --- Layout (Dwindle) ---
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # --- Keybinds ---
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, kitty"
        "CONTROL_$mod, Return, exec, wofi --show drun"
        "$mod, Q, killactive,"
        "$mod SHIFT, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo," 
        "$mod, J, togglesplit," 
      ];

      # --- Window Rules (v1 Syntax) ---
      # Syntax: COMMAND, REGEX
      windowrule = [
        # Erzwingt Transparenz für Kitty (auch wenn aktiv)
        # 'override' hilft Hyprland, die Werte korrekt zu parsen
        "opacity 0.9 override 0.8 override, ^(kitty)$"
      ];
    };
  };
}
