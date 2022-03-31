;;; bee-key.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'which-key)
(require-package 'better-jumper)
(require-package 'expand-region)
(require-package 'undo-tree)

(add-hook 'after-init-hook 'which-key-mode)

(setq-default which-key-idle-delay 1.5)

(defun sanityinc/disable-features-during-macro-call (orig &rest args)
  "When running a macro, disable features that might be expensive.
  ORIG is the advised function, which is called with its ARGS."
  (let (post-command-hook
         font-lock-mode
         (tab-always-indent (or (eq 'complete tab-always-indent) tab-always-indent)))
    (apply orig args)))

(advice-add 'kmacro-call-macro :around 'sanityinc/disable-features-during-macro-call)

;; Enable better-jumper.
(better-jumper-mode +1)

(global-set-key (kbd "C-c C-o") 'better-jumper-jump-backward)
(global-set-key (kbd "C-c <C-i>") 'better-jumper-jump-forward)

(global-set-key (kbd "C-c RET") 'er/expand-region)

(with-eval-after-load 'evil
  (define-key evil-motion-state-map (kbd "RET") 'er/expand-region))


(provide 'bee-key)

;;; bee-key.el ends here
