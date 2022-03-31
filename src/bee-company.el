;;; bee-company.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'company)

(add-hook 'after-init-hook 'global-company-mode)

(setq-default company-idle-delay 0
              company-minimum-prefix-length 2
              company-selection-wrap-around t
              company-transformers '(company-sort-prefer-same-case-prefix company-sort-by-occurrence)
              company-backends '((company-capf
                                  company-dabbrev
                                  company-files
                                  company-keywords)))

;; From https://manateelazycat.github.io/emacs/2021/06/30/company-multiple-backends.html
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

;; (setq company-backends company-backends-list)
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;; Add `company-elisp' backend for elisp.
(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (set (make-local-variable 'company-backends)
                                       '(company-elisp
                                         (:separate company-dabbrev-code company-keywords)
                                         company-files))))

;; yasnippet integration: from http://gist.github.com/265010
;; (defun company-yasnippet-or-completion ()
;;   "Company interferes with Yasnippet’s native behaviour. Here’s a quick fix"
;;   (interactive)
;;   (unless (yas-expand)
;;     (company-complete-common)))

;; (with-eval-after-load 'company
;;   (define-key company-active-map (kbd "TAB") 'company-yasnippet-or-completion))

(provide 'bee-company)

;;; bee-company.el ends here
