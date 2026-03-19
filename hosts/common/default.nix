{ pkgs, ... }:

{
  imports = [
    ../../modules/nixos/nix-settings
    ../../modules/nixos/sops
    ../../modules/nixos/locale
    ../../modules/nixos/users
  ];

  system.stateVersion = "25.11";
}
