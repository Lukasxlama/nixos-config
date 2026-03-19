{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/networkmanager"
      "/etc/secureboot"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
