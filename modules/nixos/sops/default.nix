{ config, inputs, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    age.keyFile = "/var/lib/sops-nix/key.txt";

    age.generateKey = true;

    secrets.git_ssh_key = {
      owner = "noel";
      path = "/home/noel/.ssh/id_git";
    };

    secrets.noel_password = {
      neededForUsers = true;
    };
  };
}
