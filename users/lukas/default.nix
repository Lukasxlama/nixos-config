{ pkgs, ... }:

{
  imports = [
    ./programs.nix
    ./hyprland.nix
    ./hyprpanel.nix
    ./hyprlock.nix
    ./theme.nix
    ./rofi.nix
    ./wlogout.nix
    ./shell.nix
  ];

  home.username = "lukas";
  home.homeDirectory = "/home/lukas";
  home.stateVersion = "25.11";
}
