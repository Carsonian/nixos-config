;; My Emacs config (init.el)

;; Add package archives I want
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
;;(eval-when-compile
  (require 'use-package);;)
;;(require 'use-package)
;; Set use package to always ensure
;;(eval-and-compile
;;(setq use-package-always-ensure t
;;      use-package-expand-minimally t))

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Switch to the help window when it opens
(setq help-window-select t)

;; Turn autopair on
(setq electric-pair-mode t)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;;Install & load theme (no need, using nix-colors now)
;;(use-package gruvbox-theme
;;  :config
;;  (load-theme 'gruvbox-dark-medium t)
;;  )

;; Customize mpc
(setq
 mpc-browser-tags '(Artist Album)
 mpc-songs-format "%-5{Time} %25{Title} %20{Album} %20{Artist}")

;; Set font
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font" ))

(use-package nerd-icons
  :custom
  (nerd-icons-font-family "JetBrainsMono Nerd Font")
  )

;; Org mode settings
;;(setq org-todo-keywords
;;'((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

;; Setup elpy
(use-package elpy
  :ensure t
  :init
  (elpy-enable))
;; workon home
(setenv "WORKON_HOME" "/home/carson/Files/python_projects/base-venv/.venv")
(setq elpy-rpc-virtualenv-path 'current)


;; Install different modes
(use-package ledger-mode
  ;; Setup tab completion for ledger mode
  :init
  (add-hook 'ledger-mode-hook
	    ;;(lambda ()
	    (setq-local tab-always-indent 'complete)
	    (setq-local completion-cycle-threshold t)
	    (setq-local ledger-complete-in-steps t))
  ;;)
  )

(use-package nix-mode)
(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

;; Install some basic helper packages
(use-package which-key
  :init
  (which-key-mode))

(use-package magit)

(use-package flycheck
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package sudo-edit
  :bind
  ("C-c C-r" . sudo-edit))

(use-package beacon
  :init
  (beacon-mode))

(use-package indent-guide
  :init
  (indent-guide-global-mode))

(use-package smart-hungry-delete
  :bind (([remap backward-delete-char-untabify] . smart-hungry-delete-backward-char)
	 ([remap delete-backward-char] . smart-hungry-delete-backward-char)
	 ([remap delete-char] . smart-hungry-delete-forward-char))
  :init (smart-hungry-delete-add-default-hooks))

(use-package smooth-scrolling
  :init (smooth-scrolling-mode))

(use-package speed-type)

;; (use-package all-the-icons
;;   :if (display-graphic-p))

(use-package aggressive-indent
  :init
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'nix-mode-hook #'aggressive-indent-mode))

;; Swiper for better searching with C-s
(use-package swiper
  :bind
  (("\C-s" . swiper))
  )

;; Dashboard setup
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome")
  ;; Set the banner
  (setq dashboard-startup-banner 4)
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents  . 5) (bookmarks . 5) (projects . 5)))
  (dashboard-modify-heading-icons '((recents . "nf-oct-file_symlink_file")
                                    (bookmarks . "nf-oct-book")
				    (projects . "nf-oct-briefcase")))
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-init-info t)
  )

(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  )

;; Install vertico & friends packages #########################
(use-package vertico
  :init
  (vertico-mode)
  (savehist-mode)
  )

;; Searching without order mattering
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Rich annotations in the minibuffer
(use-package marginalia
  :init
  (marginalia-mode))

;; Use C-. to perform actions on things
(use-package embark
  :bind
  (("C-." . embark-act))
  ;;("C-;" . embark-dwim)        ;; good alternative: M-.
  
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
	       '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  )

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  (setq read-extended-command-predicate
        #'command-completion-default-include-p)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t)
  )

;; End of  vertico & friends packages #########################

;; Code to keep backup files and auto saves in a specific directory
;; Put backup files neatly away
(let ((backup-dir "~/tmp/emacs/backups")
      (auto-saves-dir "~/tmp/emacs/auto-saves/"))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-")
        tramp-backup-directory-alist `((".*" . ,backup-dir))
        tramp-auto-save-directory auto-saves-dir))

(setq backup-by-copying t    ; Don't delink hardlinks
      delete-old-versions t  ; Clean up the backups
      version-control t      ; Use version numbers on backups,
      kept-new-versions 5    ; keep some new versions
      kept-old-versions 2)   ; and some old ones, too


;; Setup to make C-a & C-e move to indentation first
;;; C-a move-beginning-of-line-or-indentation
(defun at-or-before-indentation-p ()
  (save-excursion
    (let ((old-point (point)))
      (back-to-indentation)
      (<= old-point (point)))))
(defun move-beginning-of-line-or-indentation () (interactive)
       "If at the begining of line go to previous line.
 If at the indention go to begining of line.
 Go to indention otherwise."
       (cond ((bolp) (forward-line -1))
             ((at-or-before-indentation-p) (move-beginning-of-line nil))
             (t (back-to-indentation))))
(global-set-key (kbd "C-a") #'move-beginning-of-line-or-indentation)

;;; C-e move-end-of-line-or-indentation
(defun at-or-after-indentation-p ()
  (save-excursion
    (let ((old-point (point)))
      (back-to-indentation)
      (>= old-point (point)))))
(defun move-end-of-line-or-indentation () (interactive)
       "If at end of line go to next line.
If at indentation go to end of line.
Go to indentation otherwise"
       (cond ((eolp) (forward-line 1))
             ((at-or-after-indentation-p) (move-end-of-line nil))
             (t (back-to-indentation))))
(global-set-key (kbd "C-e") #'move-end-of-line-or-indentation)
