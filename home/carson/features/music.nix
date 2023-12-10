{ pkgs, config, ...}:

{
  home.packages = with pkgs; [

    # Music player, visualizer, controller
    cmus
    cava
    playerctl
    mpc-cli

  ];

  # Configure mpd
  # services.mpd = {
  #   enable = true;
  #   musicDirectory = "~/Music";
  #   extraConfig = ''
  #   audio_output {
  #     type "pipewire"
  #     name "My PipeWire Output"
  #   }
  #   '';
  # };

  # This service allows mpd to be detected by playerctl
  services.mpd-mpris = {
    enable = true;
  };
}
