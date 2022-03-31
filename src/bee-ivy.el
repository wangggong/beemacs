;;; bee-ivy.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'ivy)
(require-package 'swiper)
(require-package 'counsel)  ;; counsel -> swiper -> ivy

(require-package 'amx)

(with-eval-after-load 'projectile
  (require-package 'counsel-projectile))

(add-hook 'after-init-hook 'ivy-mode)
(add-hook 'after-init-hook 'amx-mode)

(defun bee/counsel-grep-or-swiper-at-point ()
  "Call `swiper' for small buffers and `counsel-grep' for large ones -- for symbol at point.
When non-nil, INITIAL-INPUT is the initial search pattern."
  (interactive)
  (let ((symbol-at-point (thing-at-point 'symbol)))
    (counsel-grep-or-swiper symbol-at-point)))

(defun bee/counsel-grep-or-swiper-backward-at-point ()
  "Call `swiper-backward' for small buffers and `counsel-grep-backward' for
large ones -- for symbol at point.
When non-nil, INITIAL-INPUT is the initial search pattern."
  (interactive)
  (let ((symbol-at-point (thing-at-point 'symbol)))
    (counsel-grep-or-swiper-backward symbol-at-point)))

(defun bee/counsel-projectile-rg-at-point (&optional options)
  "Search the current project with rg at point.

OPTIONS, if non-nil, is a string containing additional options to
 be passed to rg. It is read from the minibuffer if the function
is called with a `\\[universal-argument]' prefix argument. Just pass
`counsel-projectile-rg-initial-input' into `counsel-projectile-rg'."
  (interactive)
  (let ((ivy-update-fns-alist
         '((ivy-switch-buffer . counsel--switch-buffer-update-fn)))
        (ivy-unwind-fns-alist
         '((ivy-switch-buffer . ivy-call-and-recenter)))
        (counsel-projectile-rg-initial-input (thing-at-point 'symbol)))
    (counsel-projectile-rg options)))

(setq-default counsel-switch-buffer-preview-virtual-buffers t
              ivy-use-virtual-buffers t
              ivy-wrap t
              ivy-truncate-lines nil)

(with-eval-after-load 'projectile
  (setq-default counsel-projectile-preview-buffers t))

;; Key bindings:
(global-set-key (kbd "C-x b") 'counsel-switch-buffer)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x C-b") 'counsel-ibuffer)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x M-f") 'counsel-recentf)
(global-set-key (kbd "C-s") 'bee/counsel-grep-or-swiper-at-point)
(global-set-key (kbd "C-r") 'bee/counsel-grep-or-swiper-backward-at-point)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-h f") 'counsel-describe-function)

;; Evil key bindings:
(with-eval-after-load 'evil
  (my-space-leader-def
    "SPC" 'counsel-M-x
    "."   'counsel-find-file

    "bB" 'counsel-switch-buffer

    "ff"  'counsel-find-file

    ;; swiper
    "ss" 'counsel-grep-or-swiper
    "sS" 'bee/counsel-grep-or-swiper-at-point
    "sb" 'counsel-grep-or-swiper)

  ;; For projectile:
  (with-eval-after-load 'projectile
    (my-space-leader-def
      "bb" 'counsel-projectile-switch-to-buffer
      "pp" 'counsel-projectile-switch-project
      "pf" 'counsel-projectile-find-file

      ","  'counsel-projectile-switch-to-buffer
      "/"  'bee/counsel-projectile-rg-at-point)))

(provide 'bee-ivy)

;;; bee-ivy.el ends here
