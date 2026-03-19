{ pkgs, ... }:

{
  users.users.noel = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "kvm"
    ];
    shell = pkgs.zsh;
  };
}
