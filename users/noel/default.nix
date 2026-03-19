{ pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/hyprland
    ../../modules/home-manager/hyprlock
    ../../modules/home-manager/hyprpanel
    ../../modules/home-manager/programs
    ../../modules/home-manager/rofi
    ../../modules/home-manager/shell
    ../../modules/home-manager/theme
  ];

  home.username = "noel";
  home.homeDirectory = "/home/noel";
  home.stateVersion = "25.11";
}
