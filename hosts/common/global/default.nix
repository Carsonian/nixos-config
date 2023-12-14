# This file (and the global directory) holds config that I use on all hosts
{ inputs, outputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  # Programs all systems will have at the system level
  programs = {
    zsh.enable = true;
    git.enable = true;
    
  };

  environment.systemPackages = [
    pkgs.unzip
  ];

  # Configure pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    #alsa.enable = true;
    #jack.enable = true;
    #pulse.enable = true;
  };

}
