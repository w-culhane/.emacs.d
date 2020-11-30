; Borg initialization
(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

; Plugins
(require 'evil)
(evil-mode 1)

(require 'ivy)
(ivy-mode 1)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'magit)
(with-eval-after-load 'magit
		      (magit-add-section-hook 'magit-status-sections-hook
					      'magit-insert-modules
					      'magit-insert-stashes
					      'append))

(require 'quasi-monochrome)
(load-theme 'quasi-monochrome t)

(setq user-full-name "William Culhane"
      user-mail-address "sxroka@gmail.com")

; Org setup
(setq org-directory "~/Documents/org")
(setq org-agenda-files (list org-directory))
(setq org-log-done 'time)

; UI
(setq display-line-numbers-type t)

(menu-bar-mode -1)
(tool-bar-mode -1)
