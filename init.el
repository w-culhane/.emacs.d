(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

(require 'evil)
(evil-mode 1)

(with-eval-after-load 'magit
		      (magit-add-section-hook 'magit-status-sections-hook
					      'magit-insert-modules
					      'magit-insert-stashes
					      'append))

; (load-theme 'quasi-monochrome t)

(setq user-full-name "William Culhane"
      user-mail-address "sxroka@gmail.com")

(setq org-directory "~/Documents/org"
      deft-directory "~/Documents/org")

(setq org-agenda-files (list org-directory))

(setq org-log-done 'time)

(setq display-line-numbers-type t)
