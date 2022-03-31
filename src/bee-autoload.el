;;; bee-autoload.el -*- lexical-binding: t -*-

;;; Code:

;; settings for system encoding
(set-language-environment "UTF-8")
(unless *is-windows*
  (setq selection-coding-system 'utf-8))

(setq make-backup-files nil             ; disable backup file
      auto-save-default nil
      inhibit-startup-screen t          ; disable the startup screen splash
      inhibit-default-init t
      visible-bell nil
      inhibit-compacting-font-caches t
      read-process-output-max (* 64 1024))

;; Support hide/show for elisp.
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)

(electric-pair-mode t)

;; macOS: move file to trash when delete
(when *is-mac* (setq delete-by-moving-to-trash t))

;; Some variables for packages.
(defcustom bee-lsp-enabled nil
  "I need know whether lsp is enabled."
  :group 'bee-package
  :type 'boolean)

(defcustom bee-tags-enabled nil
  "I need know whether lsp is enabled."
  :group 'bee-package
  :type 'boolean)

(defun bee-open-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(provide 'bee-autoload)

;;; bee-autoload.el ends here

