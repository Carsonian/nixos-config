{ pkgs, config, ...}:

{
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
      nix-mode
      markdown-mode
      which-key
      magit
      flycheck
      sudo-edit
      beacon
      indent-guide
      smart-hungry-delete
      smooth-scrolling
      speed-type
      aggressive-indent
      dashboard
      projectile
      vertico
      orderless
      marginalia
      embark
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
