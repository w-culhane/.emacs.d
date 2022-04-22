;;; init.el --- user init file -*- no-byte-compile: t -*-

;;; General options
(fset 'yes-or-no-p 'y-or-n-p)

(setq shell-file-name "/bin/bash")

(setq user-full-name "William Culhane"
      user-mail-address "will@culhane.top")

(setq url-history-file (expand-file-name "url/history" user-emacs-directory))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-prettify-symbols-mode +1)

(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq backup-directory-alist '((".*" . "~/.local/share/backup"))
      tramp-backup-directory-alist backup-directory-alist
      auto-save-file-name-transforms '((".*" "~/.local/share/auto-save/" t t))
      version-control t
      kept-new-versions 32
      backup-by-copying t
      delete-old-versions t
      create-lockfiles nil)

;;; UI options
(column-number-mode)
(global-display-line-numbers-mode t)

(set-fringe-mode 10)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setq inhibit-splash-screen t)

(setq-default show-trailing-whitespace t)

;;; Org setup
(setq org-directory "~/Documents/org"
      org-agenda-files (list org-directory)
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-log-done 'time
      org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)" "KILL(@k)"))
      org-return-follows-link t
      org-agenda-start-with-log-mode t
      org-agenda-start-on-weekday 0)

;;; Package management
(setq straight-check-for-modifications '(watch-files))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

					; (straight-use-package auto-compile
					; :init
					; (setq load-prefer-newer t)
					; :config
					; (auto-compile-on-load-mode)
					; (auto-compile-on-save-mode)

					; (setq auto-compile-display-buffer nil)
					; (setq auto-compile-mode-line-counter t))

					; (straight-use-package auto-package-update
					; :custom
					; (auto-package-update-interval 7)
					; (auto-package-update-prompt-before-update t)
					; :config
					; (auto-package-update-maybe)
					; (auto-package-update-at-time "09:00"))

(use-package no-littering
  :straight t)

;;; Packages
(use-package quasi-monochrome-theme
  :straight t
  :config (load-theme 'quasi-monochrome t))

(use-package evil
  :straight t
  :init
  (setq evil-want-keybinding nil
	evil-want-integration t
	evil-want-C-u-scroll t
	evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle))

(use-package evil-collection
  :straight t
  :after evil
  :config (evil-collection-init))

(use-package evil-vimish-fold
  :straight t
  :after evil)

(use-package evil-nerd-commenter
  :straight t
  :after evil
  :config (evilnc-default-hotkeys nil t))

(use-package evil-surround
  :straight t
  :after evil
  :config (global-evil-surround-mode 1))

(use-package evil-lion
  :straight t
  :after evil
  :config (evil-lion-mode))

(use-package evil-exchange
  :straight t
  :after evil
  :config (evil-exchange-cx-install))

(use-package ivy
  :straight t
  :config (ivy-mode 1))

(use-package ivy-rich
  :straight t
  :after (ivy counsel)
  :config (ivy-rich-mode 1))

(use-package counsel
  :straight t
  :config (counsel-mode 1))

(use-package which-key
  :straight t
  :init (setq which-key-idle-delay 0.5)
  :config (which-key-mode))

(use-package helpful
  :straight t
  :config
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key))

(use-package flycheck
  :straight t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package toc-org
  :straight t
  :init
  (add-hook 'org-mode-hook 'toc-org-mode)
  (add-hook 'markdown-mode-hook 'toc-org-mode))

(use-package magit
  :straight t
  :config
  (magit-add-section-hook 'magit-status-sections-hook
			  'magit-insert-modules
			  'magit-insert-stashes
			  'append))

(use-package projectile
  :straight t
  :init
  (setq projectile-project-search-path '("~/.emacs.d" "~/depot" "~/Documents"))
  :config
  (projectile-mode +1))

(use-package projectile-ripgrep
  :straight t)

(use-package notmuch
  :straight t
  :config
  (setq mail-user-agent 'notmuch-user-agent))

(use-package org-msg
  :straight t
  :after notmuch
  :config
  (setq org-msg-default-alternatives '(text html)
	org-msg-greeting-fmt "Hello %s,\n\n"
	org-msg-signature "
#+BEGIN_SIGNATURE
Regards,

Will
#+END_SIGNATURE")
  (org-msg-mode))

(use-package tex
  :straight auctex
  :config
  (setq TeX-auto-save t
	TeX-parse-self t))

(use-package elpher
  :straight t)

(use-package rustic
  :straight t
  :config
  (setq rustic-format-on-save t))

(use-package dts-mode
  :straight t)

;(use-package arduino-mode
  ;:straight t)

(use-package lsp-mode
  :straight t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'c++-mode-hook 'lsp)
  (add-hook 'python-mode-hook 'lsp))

(use-package lsp-ivy
  :straight t
  :after (ivy lsp-mode))

(use-package general
  :straight t
  :config
  (general-create-definer general/main
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general/main
    "j"  'swiper
    "na" 'org-agenda
    "ww" 'whitespace-mode
    "wW" 'whitespace-cleanup
    "nm" 'notmuch
    "nc" 'calc-dispatch
    "nC" 'calendar
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
    "ps" 'projectile-ripgrep
    "g"  'magit))
