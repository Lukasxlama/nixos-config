{
  pkgs,
  osConfig,
  lib,
  ...
}:

let
  colors = {
    bar_bg = "rgba(0, 0, 0, 0)";
    module_bg = "rgba(20, 20, 20, 0.8)";
    border = "rgba(255, 255, 255, 0.1)";
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

    settings = [
      {
        layer = "top";
        position = "top";
        height = 42;
        margin-top = 4;
        margin-left = 8;
        margin-right = 8;
        spacing = 0;

        modules-left = [
          "custom/appmenu"
          "hyprland/workspaces"
        ];

        "custom/appmenu" = {
          format = "";
          on-click = "rofi -show drun";
        };

        "hyprland/workspaces" = {
          on-scroll-up = "hyprctl dispatch workspace r-1";
          on-scroll-down = "hyprctl dispatch workspace r+1";
          format = "{icon}";
          on-click = "activate";
        };

        modules-center = [
          "hyprland/window"
        ];

        "hyprland/window" = {
          max-length = 40;
          separate-outputs = true;
        };

        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
        ]
        ++ lib.optionals (osConfig.networking.hostName != "pc") [ "battery" ]
        ++ [
          "custom/notification"
          "custom/exit"
          "clock"
        ];

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
        };

        "bluetooth" = {
          "format" = "";
          "format-connected" = " {device_alias}";
          "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} verbunden";
          "tooltip-format-connected" =
            "{controller_alias}\t{controller_address}\n\n{num_connections} verbunden\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-enumerate-connected-battery" =
            "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          "on-click" = "${pkgs.blueman}/bin/blueman-manager";
        };

        "network" = {
          "format" = "󰈀 {ifname}";
          "format-wifi" = " {essid}";
          "format-ethernet" = "󰈀 {ifname}";
          "format-linked" = "󰈀 {ifname} (No IP)";
          "format-disconnected" = "󰙐 Disconnected";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
          "tooltip-format-ethernet" = "{ifname} ";
          "tooltip-format-disconnected" = "Disconnected";
          "on-click" = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        "battery" = {
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited = "";
            dnd-inhibited = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/exit" = {
          "format" = "";
          "on-click" = "${pkgs.wlogout}/bin/wlogout -b 2";
          "tooltip" = false;
        };

        "clock" = {
          "interval" = 1;
          "format" = "{:%H:%M:%S - %d.%m.%y}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        };
      }
    ];

    style = ''
      * {
        font-family: "Fira Sans Semibold", "Symbols Nerd Font";
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: ${colors.bar_bg};
      }

      #workspaces,
      #window,
      #pulseaudio,
      #bluetooth,
      #network,
      #battery,
      #custom-notification,
      #clock,
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

      #window {
        background-color: transparent;
        border: none;
      }

      #custom-appmenu:hover,
      #custom-exit:hover,
      #pulseaudio:hover,
      #bluetooth:hover,
      #network:hover,
      #battery:hover,
      #custom-notification:hover,
      #clock:hover {
        background-color: rgba(255, 255, 255, 0.15);
      }

      #bluetooth.connected {
        color: ${colors.primary};
      }

      #bluetooth.off {
        color: ${colors.text_dim};
      }

      #clock {
        font-weight: bold;
      }
    '';
  };

  services.swaync = {
    enable = true;
  };

  home.file.".config/swaync/style.css".text = ''
    @define-color bg-color ${colors.module_bg};
    @define-color text-color ${colors.text};
    @define-color selected-bg ${colors.primary};
    @define-color border-color ${colors.border};

    * {
      font-family: "Fira Sans Semibold", "Symbols Nerd Font";
    }

    .control-center {
      background: @bg-color;
      border: 1px solid @border-color;
      border-radius: 12px;
      margin: 8px;
      padding: 4px;
      color: @text-color;
    }

    .notification-row {
      outline: none;
      margin: 4px;
      padding: 0;
    }

    .notification {
      background: rgba(255, 255, 255, 0.05);
      border: 1px solid @border-color;
      border-radius: 12px;
      color: @text-color;
      padding: 8px;
    }

    .notification-content {
      background: transparent;
      padding: 4px;
    }

    .close-button {
      background: @selected-bg;
      color: #1a1a1a;
      border-radius: 12px;
      margin: 4px;
    }

    .control-center-title {
      color: @selected-bg;
      font-size: 1.2rem;
    }

    .widget-title > button {
      background: @selected-bg;
      color: #1a1a1a;
      border-radius: 8px;
      padding: 4px 12px;
    }

    .widget-dnd > switch {
      background: @border-color;
      border-radius: 12px;
    }

    .widget-dnd > switch:checked {
      background: @selected-bg;
    }
  '';
}
