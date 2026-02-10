{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p16s-amd-gen1
  ];

  networking.hostName = "p16s";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.libinput.enable = true;

  services.fprintd.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 85;
      STOP_CHARGE_THRESH_BAT0 = 90;
    };
  };
}