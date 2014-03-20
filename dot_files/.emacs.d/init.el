(global-set-key "\C-h" 'delete-backward-char)

(setq load-path (cons "~/.emacs.d/elisp" load-path))

(load "east-asian-ambiguous")
(set-east-asian-ambiguous-width 2)

; agda-mode
(load-file (let ((coding-system-for-read 'utf-8))
             (shell-command-to-string "agda-mode locate")))

(setq agda2-include-dirs (mapcar (lambda (path) (expand-file-name path)) (file-expand-wildcards "~/Library/Agda2/*")))
(add-to-list 'agda2-include-dirs ".")
