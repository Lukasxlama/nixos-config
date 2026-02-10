{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Cursor-Fix für den Start
      exec-once = [
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ];
      input = {
        kb_layout = "de";
        kb_variant = "";
        follow_mouse = 1;
      };
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, kitty"
        "CONTROL_$mod, Return, exec, wofi --show drun"
        "$mod, Q, killactive,"
        "$mod_SHIFT, M, exit,"
      ];
      monitor = [
        ",preferred,auto,1"
      ];
    };
  };
}