;;; init.el --- user init file -*- no-byte-compile: t -*-

; Borg initialization
(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

(eval-when-compile (require 'use-package))

(use-package auto-compile
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

; Plugins
(use-package quasi-monochrome-theme
  :config (load-theme 'quasi-monochrome t))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-redo)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

(use-package evil-vimish-fold
  :after evil)

(use-package evil-nerd-commenter
  :after evil
  :config (evilnc-default-hotkeys nil t))

(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

(use-package evil-lion
  :after evil
  :config (evil-lion-mode))

(use-package evil-exchange
  :after evil
  :config (evil-exchange-cx-install))

(use-package ivy
  :config (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :config (ivy-rich-mode 1))

(use-package counsel
  :config (counsel-mode 1))

(use-package which-key
  :init (setq which-key-idle-delay 0.5)
  :config (which-key-mode))

(use-package helpful
  :config
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key))

(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package magit
  :config
  (magit-add-section-hook 'magit-status-sections-hook
			  'magit-insert-modules
			  'magit-insert-stashes
			  'append))

(use-package general
  :config
  (general-create-definer general/main
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general/main
    "j" 'swiper
    "na" 'org-agenda
    "m" (general-simulate-key "C-c")
    "x" (general-simulate-key "C-x")
    "h" (general-simulate-key "C-h")
    "cc" 'evilnc-comment-or-uncomment-lines
    "cu" 'uncomment-region
    "ct" 'evilnc-toggle-invert-comment-line-by-line
    "ff" 'find-file
    "gg" 'magit))

(setq user-full-name "William Culhane"
      user-mail-address "sxroka@gmail.com")

; Org setup
(setq org-directory "~/Documents/org")
(setq org-agenda-files (list org-directory))
(setq org-log-done 'time)

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)" "KILL(k!)")))

; UI
(column-number-mode)
(global-display-line-numbers-mode t)

(set-fringe-mode 10)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setq inhibit-splash-screen t)
