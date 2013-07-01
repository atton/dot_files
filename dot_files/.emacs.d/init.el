(global-set-key "\C-h" 'delete-backward-char)

(setq load-path (cons "~/.emacs.d/elisp" load-path))

; agda-mode
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

(setq agda2-include-dirs (list "." (expand-file-name "~/Library/Agda2/current/src")))
