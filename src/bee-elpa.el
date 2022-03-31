;;; bee-elpa.el -*- lexical-binding: t -*-

;;; Code:

;; Set mirror:
;;(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;                         ("melpa" . "http://elpa.emacs-china.org/melpa/")
;;                         ("org"   . "http://elpa.emacs-china.org/org/")))
(setq package-archives '(("gnu"   . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                         ("melpa" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/")
                         ("org"   . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/org/")))

(require 'package)

(setq package-enable-at-startup nil)
(package-initialize)

;; settings for use-package package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; configure use-package prior to loading it
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-always-defer t
        use-package-expand-minimally t)
  (require 'use-package))

;; On-demand installation of packages
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
  If NO-REFRESH is non-nil, the available package lists will not be
  re-downloaded in order to locate PACKAGE."
  (or (package-installed-p package min-version)
      (let* ((known (cdr (assoc package package-archive-contents)))
             (best (car (sort known (lambda (a b)
                                      (version-list-<= (package-desc-version b)
                                                       (package-desc-version a)))))))
        (if (and best (version-list-<= min-version (package-desc-version best)))
          (package-install best)
          (if no-refresh
            (error "No version of %s >= %S is available" package min-version)
            (package-refresh-contents)
            (require-package package min-version t)))
        (package-installed-p package min-version))))

;; fire up packages.el

(provide 'bee-elpa)

;;; bee-elpa.el ends here
