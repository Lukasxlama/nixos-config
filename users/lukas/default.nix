{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./hyprland.nix
  ];

  home.username = "lukas";
  home.homeDirectory = "/home/lukas";

  home.packages = with pkgs; [
    vscode
    btop
    firefox
    bitwarden-desktop
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
