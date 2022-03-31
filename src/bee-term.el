;;; bee-term.el -*- lexical-binding: t -*-

;;; Code:

;;; Packages:
(require-package 'vterm)
(require-package 'vterm-toggle)

;; Just goto project root when toggle term.
(setq-default vterm-toggle-scope 'project)
;; When toggled, just reset window.
(setq-default vterm-toggle-hide-method 'reset-window-configration)
(setq-default vterm-toggle-reset-window-configration-after-exit t)

;; Evil key bindings:
(with-eval-after-load 'evil
  ;; (define-key vterm-mode-map (kbd "C-d") 'vterm-send-C-d)
  (my-space-leader-def
    "'"  'vterm-toggle
    "ot" 'vterm-toggle
    "oT" 'vterm))

(provide 'bee-term)

;;; bee-term.el ends here
