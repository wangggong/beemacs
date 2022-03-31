;;; bee-diminish.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'diminish)

(with-eval-after-load 'which-key (diminish 'which-key-mode))
(with-eval-after-load 'whitespace (diminish 'whitespace-mode))
(with-eval-after-load 'flycheck (diminish 'flycheck-mode))
(with-eval-after-load 'ivy (diminish 'ivy-mode))
(with-eval-after-load 'autopair (diminish 'autopair-mode))
(with-eval-after-load 'undo-tree (diminish 'undo-tree-mode))
(with-eval-after-load 'auto-complete (diminish 'auto-complete-mode))
(with-eval-after-load 'projectile (diminish 'projectile-mode))
(with-eval-after-load 'yasnippet (diminish 'yas-minor-mode))
(with-eval-after-load 'guide-key (diminish 'guide-key-mode))
(with-eval-after-load 'eldoc (diminish 'eldoc-mode))
(with-eval-after-load 'smartparens (diminish 'smartparens-mode))
(with-eval-after-load 'company (diminish 'company-mode))
(with-eval-after-load 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(with-eval-after-load 'git-gutter+ (diminish 'git-gutter+-mode))
(with-eval-after-load 'magit (diminish 'magit-auto-revert-mode))
(with-eval-after-load 'hs-minor-mode (diminish 'hs-minor-mode))
(with-eval-after-load 'color-identifiers-mode (diminish 'color-identifiers-mode))

(provide 'bee-diminish)

;;; bee-diminish.el ends here
