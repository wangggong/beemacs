;;; bee-magit.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'magit)

(setq-default magit-diff-refine-hunk t)
(setq-default ediff-split-window-function 'split-window-horizontally)

;; Magit blame:
(setq magit-blame-styles
  '((margin
     (margin-format    . ("%a %s%f" " %C" " %H"))
     (margin-width     . 42)
     (margin-face      . magit-blame-margin)
     (margin-body-face . (magit-blame-dimmed)))
    (headings
     (heading-format   . "%-20a %C %s\n"))
    (highlight
     (highlight-face   . magit-blame-highlight))
    (lines
     (show-lines       . t)
     (show-message     . t))))

;; Key bindings:
(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g /") 'magit-dispatch)
(global-set-key (kbd "C-c g B") 'magit-blame-addition)

;; Evil key bindings:
(with-eval-after-load 'evil
  (my-space-leader-def
    "gg" 'magit-status
    "g/" 'magit-dispatch
    "gB" 'magit-blame-addition)
  (setq magit-blame-mode-map
        '(keymap
          (normal-state keymap "Auxiliary keymap for Normal state"
                        (113 . magit-blame-quit))
          (3 keymap
             (17 . magit-blame-quit)))))

(provide 'bee-magit)

;;; bee-magit.el ends here
