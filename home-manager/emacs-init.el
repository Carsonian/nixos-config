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

 ;;Install & load theme
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium t)
)

;; Org mode settings
;;(setq org-todo-keywords
  ;;'((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

;; Install different modes
(use-package ledger-mode)
(use-package nix-mode)

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

(use-package all-the-icons
  :if (display-graphic-p))

(use-package aggressive-indent
  :init
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'nix-mode-hook #'aggressive-indent-mode))

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
  ;; Bind `marginalia-cycle' locally in the minibuffer and *Completions* buffer
  :bind
  (:map minibuffer-local-map
        ("M-A" . marginalia-cycle))
  (:map completion-list-mode-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim) 
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Better searching with consult
(use-package consult
  :bind (;; C-c bindings in `mode-specific-map'
	 	 
	 ;; Bindings I actually use
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer	 
         ("C-c i" . consult-info)
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop	 

	 ;; Bindings for things I may want to use someday
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ([remap Info-search] . consult-info)

         ;; C-x bindings in `ctl-x-map'
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Other custom bindings

         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake) 
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)

         ;; M-s bindings in `search-map'
	 ;; Bindings for searching in all files
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
	 
  ;; Enable automatic preview at point in the *Completions* buffer.
  ;; Relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)
  )
)

;; Replace isearch with consult-line on C-s
(global-set-key "\C-s" 'consult-line)

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Corfu Auto completion
(use-package corfu
  :custom
  (corfu-auto t)          ;; Enable auto completion
  :init
  (global-corfu-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  (setq read-extended-command-predicate
         #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)

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
