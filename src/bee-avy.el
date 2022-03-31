;;; bee-avy.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'avy)  ;; For nuclear weapon.

(require-package 'wgrep)  ;; For nuclear weapon.
(require 'wgrep)

(define-key evil-motion-state-map (kbd "gs/") 'evil-avy-goto-char-timer)
(define-key evil-motion-state-map (kbd "gss") 'evil-avy-goto-char-2)
(define-key evil-motion-state-map (kbd "gsf") 'evil-avy-goto-char)
(define-key evil-motion-state-map (kbd "gsj") 'evil-avy-goto-line-below)
(define-key evil-motion-state-map (kbd "gsk") 'evil-avy-goto-line-above)
(define-key evil-motion-state-map (kbd "gse") 'evil-avy-goto-word-0)

(provide 'bee-avy)

;;; bee-avy.el ends here
