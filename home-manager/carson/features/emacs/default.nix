{ pkgs, config, ...}:

{
  # Enable the emacs daemon
  services.emacs = {
    enable = true;
    #defaultEditor = true;
  };

  # Configure emacs version & packages, point to init.el
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: with epkgs; [
      use-package
      gruvbox-theme
      nerd-icons
      ledger-mode
      elpy
      company
      nix-mode
      markdown-mode
      doom-modeline
      which-key
      magit
      windsize
      flycheck
      sudo-edit
      beacon
      indent-guide
      smart-hungry-delete
      smooth-scrolling
      speed-type
      aggressive-indent
      dashboard
      #projectile
      vertico
      orderless
      marginalia
      consult
      #embark
      swiper
      base16-theme
    ];
    extraConfig = builtins.readFile ./emacs-init.el
                  # Add the base16 theme we are using in nixos to emacs
                  +''(use-package base16-theme
                        :config
                        (load-theme 'base16-${config.colorScheme.slug} t))
                        (set-cursor-color "#${config.colorScheme.colors.base09}") 
                        '';
  };
}
