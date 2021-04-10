;;; init.el --- user init file -*- no-byte-compile: t -*-

(setq user-full-name "William Culhane"
      user-mail-address "sxroka@gmail.com")

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

; UI
(column-number-mode)
(global-display-line-numbers-mode t)

(set-fringe-mode 10)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setq inhibit-splash-screen t)

(setq-default show-trailing-whitespace t)

; Org setup
(setq org-directory "~/Documents/org"
      org-agenda-files (list org-directory)
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-log-done 'time
      org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)" "KILL(@k)"))
      org-return-follows-link t
      org-agenda-start-with-log-mode t
      org-agenda-start-on-weekday 0)

; Package management
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-compile
	     :config
	     (auto-compile-on-load-mode)
	     (auto-compile-on-save-mode))

(use-package auto-package-update
	     :custom
	     (auto-package-update-interval 7)
	     (auto-package-update-prompt-before-update t)
	     :config
	     (auto-package-update-maybe)
	     (auto-package-update-at-time "09:00"))

; Plugins
(use-package quasi-monochrome-theme
	     :config (load-theme 'quasi-monochrome t))

(use-package evil
	     :init
	     (setq evil-want-keybinding nil
		   evil-want-integration t
		   evil-want-C-u-scroll t
		   evil-undo-system 'undo-redo)
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

(use-package toc-org
	     :init
	     (add-hook 'org-mode-hook 'toc-org-mode)
	     (add-hook 'markdown-mode-hook 'toc-org-mode))

(use-package magit
	     :config
	     (magit-add-section-hook 'magit-status-sections-hook
				     'magit-insert-modules
				     'magit-insert-stashes
				     'append))

(use-package projectile
	     :init
	     (setq projectile-project-search-path '("~/.emacs.d" "~/depot" "~/Documents"))
	     :config
	     (projectile-mode +1))

(use-package general
	     :config
	     (general-create-definer general/main
				     :keymaps '(normal insert visual emacs)
				     :prefix "SPC"
				     :global-prefix "C-SPC")

	     (general/main
	       "j"  'swiper
	       "na" 'org-agenda
	       "m"  (general-simulate-key "C-c")
	       "x"  (general-simulate-key "C-x")
	       "h"  (general-simulate-key "C-h")
	       "cc" 'evilnc-comment-or-uncomment-lines
	       "cu" 'uncomment-region
	       "ct" 'evilnc-toggle-invert-comment-line-by-line
	       "ff" 'find-file
	       "bb" 'counsel-switch-buffer
	       "pf" 'projectile-find-file
	       "pp" 'projectile-switch-project
	       "gg" 'magit))
