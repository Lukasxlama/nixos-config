{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./hyprland.nix
    ./programs.nix
    ./theme.nix
  ];

  home.username = "lukas";
  home.homeDirectory = "/home/lukas";
  home.stateVersion = "25.11";
}