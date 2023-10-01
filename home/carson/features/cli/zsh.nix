{ pkgs, config, ...}:

{
  programs = {
    zsh = {
      enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "(cd /nix-config && sudo nixos-rebuild switch --flake .#angkor)";
      test = "(cd /nix-config && sudo nixos-rebuild test --flake .#angkor)";
    };
    # History settings
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    # zsh plugin manager
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "alanpeabody";
    };
    };
  };
}
  
