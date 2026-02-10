{ ... }:

{
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  networking.firewall = {
    enable = true;
  };
}