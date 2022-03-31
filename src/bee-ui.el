;;; bee-ui.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'doom-themes)

(require-package 'powerline-evil)

(require-package 'rainbow-delimiters)

;; Set about whitespaces.
(setq-default whitespace-line-column 120)
(setq-default whitespace-style '(face indentation tabs tab-mark spaces space-mark new-line new-line-mark trailing lines-tail))
;; (add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'toggle-truncate-lines)

;; Don't prompt to confirm theme safety. This avoids problems with
;; first-time startup on Emacs > 26.3.
(setq custom-safe-themes t)
(setq-default indent-tabs-mode nil
              tab-width 4)

;; If you don't customize it, this is the theme you get.
(load-theme 'doom-gruvbox t)
;; (setq-default solarized-high-contrast-mode-line t)
;; (setq-default solarized-emphasize-indicators nil)
(setq-default x-underline-at-descent-line t)

;; Font:
;(set-frame-font "SauceCodePro NF-16")
(set-frame-font "Fira Code-18")

;; Transparency:
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 85 50))

(global-set-key (kbd "C-h t") 'load-theme)

;; Powerline.
(defun bee/powerline-evil-vim-color-theme ()
  "Powerline's Vim-like mode-line with evil state at the beginning in color, with arrows."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (let ((evil-face (powerline-evil-face)))
                                       (if evil-mode
                                           (powerline-raw (powerline-evil-tag) evil-face)))
                                     (let ((evil-face (powerline-evil-face)))
                                       (if evil-mode
                                           (funcall separator-left evil-face mode-line)))
                                     (powerline-buffer-id `(mode-line-buffer-id ,mode-line) 'l)
                                     (funcall separator-left mode-line face1)
                                     (powerline-raw "[" face1 'l)
                                     (powerline-major-mode face1)
                                     (powerline-process face1)
                                     (powerline-raw "]" face1)
                                     (when (buffer-modified-p)
                                       (powerline-raw "[+]" face1))
                                     (when buffer-read-only
                                       (powerline-raw "[RO]" face1))
                                     (powerline-raw "[%z]" face1)
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format nil 'l))
                                     (when (boundp 'erc-modified-channels-object)
                                       (powerline-raw erc-modified-channels-object face1 'l))
                                     (funcall separator-right face1 mode-line)
                                     ;;(powerline-vc mode-line)
                                     (when (and vc-mode buffer-file-name)
                                       (let ((backend (vc-backend buffer-file-name)))
                                         (when backend
                                           (format-mode-line '(vc-mode vc-mode)))))
                                     (funcall separator-left mode-line face2)
                                     (powerline-raw "[" face2 'l)
                                     (powerline-minor-modes face2)
                                     (powerline-raw "%n" face2)
                                     (powerline-raw "]" face2)
                                     (funcall separator-left face2 mode-line)))
                          (rhs (list
                                ;; (funcall separator-right face2 face1)
                                (powerline-raw '(10 "%i"))
                                (powerline-raw global-mode-string mode-line 'r)
                                (powerline-raw "%l," mode-line 'l)
                                (powerline-raw (format-mode-line '(10 "%c")))
                                (powerline-raw (replace-regexp-in-string  "%" "%%" (format-mode-line '(-3 "%p"))) mode-line 'r))))
                     (concat (powerline-render lhs)
                             (powerline-fill mode-line (powerline-width rhs))
                             (powerline-render rhs)))))))

;;(setq-default powerline-default-separator nil)
;;(setq-default powerline-gui-use-vcs-glyph nil)
;;(setq-default powerline-utf-8-separator-left  #x7c
;;              powerline-utf-8-separator-right #x3e)
(bee/powerline-evil-vim-color-theme)

;; Rainbow delimiters.
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(unless (and (display-graphic-p) (eq system-type 'darwin))
  (menu-bar-mode -1))
(tool-bar-mode -1)

;; Line numbers.
(setq-default display-line-numbers nil)
;; (setq-default display-line-numbers 'relative)
;; (global-linum-mode 1)
(global-hl-line-mode t)

;; Customize my initial scratch message.
(setq initial-scratch-message ";; Avoid nesting by handling errors first;\n;; Avoid repetition when possible;\n;; Important code goes first;\n;; Document your code;\n;; Shorter is better;\n;; Packages with multiple files;\n;; Make your packages \"go get\"-able;\n;; Ask for what you need;\n;; Keep independent packages independent;\n;; Avoid concurrency in your API;\n;; Use goroutines to manage state;\n;; Avoid goroutine leaks;\n;;\n")

(provide 'bee-ui)

;;; bee-ui.el ends here
