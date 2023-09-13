;; My Emacs config (init.el)

;; Add package archives I want
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; always-insure doesn't work idk why. TODO
;;(eval-and-compile
  ;;(setq use-package-always-ensure t
  ;;	use-package-expand-minimally t))

;; Turn off some unneeded UI elements
(menu-bar-mode -1) 
(tool-bar-mode -1)

;; Switch to the help window when it opens
(setq help-window-select t)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;; Install & load theme
(use-package gruvbox-theme
  :ensure t
  :config
    (load-theme 'gruvbox-dark-medium t)
  )

;; Org mode settings
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

;; Install ledger-mode
(use-package ledger-mode
  :ensure t)

;; Set ledger-mode to run automatically when opening a .ledger file
;;(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
;;(add-to-list 'load-path
;;	     (expand-file-name "C:/Users/Carso/ledger-mode"))
;;     (add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))
;;
;;(add-hook 'ledger-mode-hook
;;	       (lambda ()
;;		 (setq-local tab-always-indent 'complete)
;;		 (setq-local completion-cycle-threshold t)
;;		 (setq-local ledger-complete-in-steps t)))
