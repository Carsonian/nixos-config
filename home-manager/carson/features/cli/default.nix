{ pkgs, config, ...}:

{

  imports = [
    ./zsh.nix
  ];
  
  programs = {
    btop = {
      enable = true;
    };
  };

}
