{ pkgs, lib, ... }: {
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 4;
      graphics = true;
      qemu.options = [
        "-device virtio-gpu-pci"
        "-display gtk,show-cursor=on,grab-on-hover=on" 
        "-device virtio-serial-pci"
        "-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0"
        "-chardev spicevmc,id=spicechannel0,name=vdagent"
      ];
    };

    users.users.lukas.initialPassword = lib.mkVMOverride "nix";
  };

  services.spice-vdagentd.enable = true;
  environment.systemPackages = with pkgs; [ spice-vdagent ];
}