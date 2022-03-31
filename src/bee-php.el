;;; bee-php.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'php-mode)

(when bee-lsp-enabled
  (add-hook 'php-mode-hook #'lsp))

(when bee-tags-enabled
  (add-hook 'php-mode-hook (lambda () (ggtags-mode 1))))

;; Hide-show:
(add-to-list 'hs-special-modes-alist '(php-mode "[[{\\(]" "[]}\\)]" "/[*/]" nil nil))
(add-hook 'php-mode-hook #'hs-minor-mode)

(with-eval-after-load 'yasnippet
  (defun yas-php-get-class-name-by-file-name ()
    "Return name of class-like construct by `file-name'.

\"class-like\" contains class, trait and interface."
    (file-name-nondirectory
     (file-name-sans-extension (or (buffer-file-name)
                                   (buffer-name (current-buffer)))))))

(provide 'bee-php)

;;; bee-php.el ends here
