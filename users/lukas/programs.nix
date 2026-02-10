{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    btop
    firefox
    bitwarden-desktop
  ];

  programs.kitty.enable = true;
  programs.wofi.enable = true;
  programs.home-manager.enable = true;
}