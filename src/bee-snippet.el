;;; bee-snippet.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'yasnippet)
(require-package 'auto-yasnippet)

(setq-default yas-snippet-dirs '("~/.emacs.d/.snippets"))
(yas-global-mode 1)

(provide 'bee-snippet)

;;; bee-snippet.el ends here
