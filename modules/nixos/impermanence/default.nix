{ inputs, ... }:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.persistence."/persist" = {
    hideMounts = true;

    # --- SYSTEM WIDE PERSISTENCE ---
    directories = [
      # System Services
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/secureboot"

      # Networking & Security
      "/var/lib/bluetooth"
      "/var/lib/networkmanager"
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"

      # Virtualization
      "/var/lib/libvirt"
      "/etc/libvirt"
      "/var/lib/swtpm"
      "/var/log/swtpm"
      "/var/lib/swtpm-localca"
    ];

    files = [
      "/etc/machine-id"
    ];

    # --- USER DATA ---
    users.noel = {
      directories = [
        # Personal Folders
        "Documents"
        "Downloads"
        "Pictures"
        "Music"
        "Videos"

        # Communication & Productivity
        ".config/discord"
        ".config/Signal"
        ".config/Bitwarden"
        ".config/Proton Mail"
        ".local/share/Anki2"

        # Tools & System
        ".ssh"
        ".local/share/keyrings"
        ".config/OrcaSlicer"

        # Gaming
        ".local/share/Steam"
        ".steam"
        ".var/app"

        # Firefox Persistent Data
        ".mozilla/firefox/default/storage"
        ".mozilla/firefox/default/extension-store"
      ];

      files = [
        ".zsh_history"

        # Firefox Core
        ".mozilla/firefox/default/logins.json"
        ".mozilla/firefox/default/key4.db"
        ".mozilla/firefox/default/cookies.sqlite"
        ".mozilla/firefox/default/places.sqlite"
        ".mozilla/firefox/default/extension-preferences.json"
        ".mozilla/firefox/default/extension-settings.json"
        ".mozilla/firefox/default/prefs.js"
      ];
    };
  };

  programs.fuse.userAllowOther = true;
}
