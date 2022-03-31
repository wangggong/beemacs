;;; bee-flycheck.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'flycheck)

(add-hook 'after-init-hook 'global-flycheck-mode)
(with-eval-after-load 'flycheck
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
  (setq flycheck-checkers (delq 'html-tidy flycheck-checkers))
  (setq flycheck-standard-error-navigation nil))

;; Evil key bindings:
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "[g") 'flycheck-previous-error)
  (define-key evil-normal-state-map (kbd "]g") 'flycheck-next-error))

(provide 'bee-flycheck)

;;; bee-flycheck.el ends here
