;;; bee-xterm.el -*- lexical-binding: t -*-

;;; Code:

;; Init frame hooks, from purcell's configuration.
(defvar after-make-console-frame-hooks '()
  "Hooks to run after creating a new TTY frame")
(defvar after-make-window-system-frame-hooks '()
  "Hooks to run after creating a new window-system frame")

(defcustom console-frame-setup-xterm-mouse -1
  "Whether the frame supports xterm mouse."
  :type 'number
  :group 'console-frame-setup)

(defun run-after-make-frame-hooks (frame)
  "Run configured hooks in response to the newly-created FRAME.
Selectively runs either `after-make-console-frame-hooks' or
`after-make-window-system-frame-hooks'"
  (with-selected-frame frame
    (run-hooks (if window-system
                   'after-make-window-system-frame-hooks
                 'after-make-console-frame-hooks))))

(defun sanityinc/console-frame-setup ()
  (xterm-mouse-mode console-frame-setup-xterm-mouse)) ; Mouse in a terminal (Use shift to paste with middle button)

;; (defun bee/remove-background ()
;;   (interactive)
;;   (set-face-background 'default "unspecified-bg" (selected-frame)))

;; Modify cursor shape like neovim, from these links:
;; https://toutiao.io/posts/n3d70u/preview
;; https://github.com/syl20bnr/spacemacs/issues/7112
(defun bee/graphic-set-evil-state-cursor ()
  (setq evil-emacs-state-cursor '("red" box))
  (setq evil-normal-state-cursor '("green" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("red" bar))
  (setq evil-replace-state-cursor '("red" hbar))
  (setq evil-operator-state-cursor '("red" hollow)))

(defun bee/vte-set-evil-state-cursor ()
  (add-hook 'evil-normal-state-entry-hook (lambda () (send-string-to-terminal "\033[0 q")))
  (add-hook 'evil-replace-state-entry-hook (lambda () (send-string-to-terminal "\033[4 q")))
  (add-hook 'evil-insert-state-entry-hook (lambda () (send-string-to-terminal "\033[6 q"))))

(add-hook 'after-make-frame-functions 'run-after-make-frame-hooks)

(defconst sanityinc/initial-frame (selected-frame)
  "The frame (if any) active during Emacs initialization.")

(add-hook 'after-init-hook
          (lambda () (when sanityinc/initial-frame
                       (run-after-make-frame-hooks sanityinc/initial-frame))))

;; From https://www.emacswiki.org/emacs/TransparentEmacs:
(unless window-system
  (set-frame-parameter (selected-frame) 'alpha '(85 . 50))
  (add-to-list 'default-frame-alist '(alpha . (85 . 50))))

;; (add-hook 'after-make-console-frame-hooks 'bee/remove-background)

(add-hook 'after-make-console-frame-hooks 'sanityinc/console-frame-setup)

(with-eval-after-load 'evil
  (if window-system
      (bee/graphic-set-evil-state-cursor)
    (bee/vte-set-evil-state-cursor)))

(provide 'bee-xterm)

;;; bee-xterm.el ends here
