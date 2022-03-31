;;; bee-projectile.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'projectile)
(require-package 'ripgrep)

(add-hook 'after-init-hook 'projectile-mode)

;; Shorter modeline
(setq-default projectile-mode-line-prefix " Proj")

(when (executable-find "rg")
  (setq-default projectile-generic-command "rg --files --hidden"))

(with-eval-after-load 'projectile
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; Evil key bindings:
(with-eval-after-load 'evil
  (my-space-leader-def
    "bb" 'projectile-switch-to-buffer

    "pa" 'projectile-add-known-project
    "pd" 'projectile-remove-known-project
    "pp" 'projectile-switch-project
    "pf" 'projectile-find-file
    "/"  'projectile-grep))

(provide 'bee-projectile)

;;; bee-projectile.el ends here
