{ pkgs, config, ...}:

{
  #Configure pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    #alsa.enable = true;
    #jack.enable = true;
    #pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  # Setup greetd with tuigreet
  services.greetd = {
    enable = true;
    settings = {
      # Tuigreet as display manager
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland -r --asterisks";
        user = "greeter";
      };
    };
  };

  # Use network manager
  networking.networkmanager.enable = true;
  # Turn off network wait because it slows down boot
  systemd.network.wait-online.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false; 

  # Setup swaylock with pam (otherwise it can't unlock)
  security.pam.services.swaylock = {};

  # Setup fingerprint login
  #services.fprintd.enable = true;
  #security.pam.services.carson.fprintAuth = config.services.fprintd.enable;

}
