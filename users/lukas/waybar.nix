{ pkgs, ... }:

let
  colors = {
    bar_bg = "rgba(0, 0, 0, 0)";
    module_bg = "rgba(39, 29, 27, 0.8)";
    border = "rgba(160, 140, 135, 0.2)";
    primary = "#ffb59f";
    text = "#f1dfda";
    text_dim = "#d8c2bc";
  };
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";

    settings = [{
      layer = "top";
      position = "top";
      height = 38;
      margin-top = 4;
      margin-left = 8;
      margin-right = 8;
      spacing = 0;

      modules-left = [ 
        "custom/appmenu" 
        "hyprland/workspaces" 
        "group/links"
      ];
      
      modules-center = [ 
        "hyprland/window" 
      ];
      
      modules-right = [ 
        "pulseaudio" 
        "network" 
        "group/hardware"
        "battery" 
        "clock" 
        "tray" 
        "custom/exit" 
      ];

      "hyprland/workspaces" = {
        on-scroll-up = "hyprctl dispatch workspace r-1";
        on-scroll-down = "hyprctl dispatch workspace r+1";
        format = "{icon}";
        on-click = "activate";
      };

      "hyprland/window" = {
        max-length = 40;
        separate-outputs = true;
      };

      "group/hardware" = {
        orientation = "horizontal";
        modules = [ "cpu" "memory" ];
      };

      "cpu" = { format = " {usage}%"; };
      "memory" = { format = " {percentage}%"; };

      "pulseaudio" = {
        format = "{icon} {volume}%";
        format-muted = "";
        format-icons = { default = ["" "" ""]; };
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "network" = {
        format-wifi = "";
        format-ethernet = "";
        tooltip-format = "{essid}";
      };

      "clock" = {
        format = "{:%H:%M}";
        tooltip-format = "{:%A, %d. %B %Y}";
      };

      "custom/appmenu" = {
        format = "";
        on-click = "rofi -show drun";
      };

      "custom/exit" = {
        format = "";
        on-click = "wlogout";
      };
    }];

    style = ''
      * {
        font-family: "Fira Sans Semibold", "Font Awesome 6 Free";
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: ${colors.bar_bg};
      }

      /* Gemeinsames Styling für alle "Boxen" */
      #workspaces,
      #window,
      #pulseaudio,
      #network,
      #group-hardware,
      #battery,
      #clock,
      #tray,
      #custom-appmenu,
      #custom-exit {
        background-color: ${colors.module_bg};
        color: ${colors.text};
        border-radius: 12px;
        border: 1px solid ${colors.border};
        margin: 4px 4px;
        padding: 0px 12px;
        transition: all 0.3s ease;
      }

      /* Workspaces Spezifisch */
      #workspaces {
        padding: 0px 4px;
      }

      #workspaces button {
        color: ${colors.text_dim};
        padding: 0px 8px;
        margin: 4px 2px;
      }

      #workspaces button.active {
        color: ${colors.primary};
        background: rgba(255, 255, 255, 0.1);
        border-radius: 8px;
      }

      /* Window Titel Box */
      #window {
        background-color: transparent; /* Center oft ohne Box oder dezenter */
        border: none;
      }

      /* Interaktive Elemente Hover-Effekt */
      #custom-appmenu:hover,
      #custom-exit:hover,
      #pulseaudio:hover {
        background-color: ${colors.primary};
        color: ${colors.bar_bg};
      }

      #clock {
        font-weight: bold;
      }

      /* Hardware Group Korrektur */
      #cpu, #memory {
        padding: 0 6px;
      }
    '';
  };
}