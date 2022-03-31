;;; bee-lsp.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'lsp-mode)
(require-package 'lsp-ui)

(add-hook 'lsp-mode-hook (lambda ()
                           (lsp-enable-which-key-integration)))

(setq-default bee-lsp-enabled t)

;; NOTE: `lsp-auto-guess-root' automatically guess the project root using projectile/project.
;; Do *not* use this setting unless you are familiar with ‘lsp-mode’ internals and you are sure
;; that all of your projects are following ‘projectile’/‘project.el’ conventions.
(setq lsp-auto-guess-root nil
      lsp-enable-file-watchers nil
      lsp-ui-sideline-show-hover nil
      lsp-completion-provider :capf)

(with-eval-after-load 'php-mode
  (setq-default lsp-intelephense-php-version "7.0.6"))

;; Key bindings:
(setq lsp-keymap-prefix "C-c l")
(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))

;; LSP UI:
(setq lsp-ui-sideline-ignore-duplicate t
      lsp-modeline-code-actions-segments '(count name)
      lsp-headerline-breadcrumb-enable nil

      lsp-ui-doc-enable nil
      lsp-ui-doc-show-with-cursor nil
      lsp-ui-doc-show-with-mouse nil)
;;(setq lsp-ui-doc-include-signature t
;; lsp-ui-doc-position 'at-point
;; lsp-ui-doc-border "dim gray"
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'lsp-ui-mode-hook 'lsp-modeline-code-actions-mode)

;; (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
;; (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

;; Evil key bindings:
(with-eval-after-load 'evil
  (add-hook 'lsp-mode-hook (lambda ()
                             (define-key evil-motion-state-local-map (kbd "gd") 'lsp-find-definition)
                             (define-key evil-motion-state-local-map (kbd "gD") 'lsp-find-references)
                             (define-key evil-motion-state-local-map (kbd "K") 'lsp-describe-thing-at-point)))
  (my-space-leader-def
    "cd" 'lsp-find-definition
    "cD" 'lsp-find-references
    "ci" 'lsp-find-implementation
    "co" 'lsp-organize-imports
    "ct" 'lsp-find-type-definition
    "cr" 'lsp-rename))

(provide 'bee-lsp)

;;; bee-lsp.el ends here
