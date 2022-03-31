;;; bee-go.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'go-mode)
(require-package 'go-fill-struct)
(require-package 'go-impl)
;; (require-package 'go-gen-test)
(require-package 'go-tag)

(add-hook 'go-mode-hook (lambda ()
                          (add-hook 'before-save-hook #'lsp-organize-imports t t)
                          (add-hook 'before-save-hook #'lsp-format-buffer t t)))

(when bee-lsp-enabled
  (add-hook 'go-mode-hook #'lsp))

(when bee-tags-enabled
  (add-hook 'go-mode-hook (lambda () (ggtags-mode 1))))

;; Hide-show:
(add-to-list 'hs-special-modes-alist '(go-mode "[[{\\(]" "[]}\\)]" "/[*/]" nil nil))
(add-hook 'go-mode-hook #'hs-minor-mode)

(provide 'bee-go)

;;; bee-go.el ends here
