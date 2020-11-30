(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

(with-eval-after-load 'magit
		      (magit-add-section-hook 'magit-status-sections-hook
					      'magit-insert-modules
					      'magit-insert-stashes
					      'append))
