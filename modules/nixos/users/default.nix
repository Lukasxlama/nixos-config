{ pkgs, config, ... }:

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
    hashedPasswordFile = config.sops.secrets.noel_password.path;
  };
}
