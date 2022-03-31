;;; bee-vertico.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'vertico)
(require-package 'savehist)
(require-package 'marginalia)
(require-package 'consult)

(require-package 'embark)
(require-package 'orderless)

(with-eval-after-load 'consult
  (with-eval-after-load 'embark
    (require 'embark-consult)
    (add-hook 'embark-collect-mode-hook 'consult-preview-at-point-mode)))

(recentf-mode nil)
(vertico-mode t)
(savehist-mode t)
(with-eval-after-load 'vertico
  (marginalia-mode t)
  (setq-default marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil)))

(defun bee/consult-ripgrep-at-point (&optional dir)
  "Search for regexp with rg in DIR with input at point.

See `consult-grep' for more details."
  (interactive)
  (let ((initial (thing-at-point 'symbol)))
    (consult-ripgrep dir initial)))

;; vertico configuration - from https://github.com/minad/vertico
(setq-default vertico-count 20
              vertico-cycle t)

(setq-default completion-styles '(orderless)
              completion-category-defaults nil
              completion-category-overrides '((file (styles partial-completion))))

(setq-default enable-recursive-minibuffers t)

;; consult configuration - from https://github.com/minad/consult:
(add-hook 'completion-list-mode-hook 'consult-preview-at-point-mode)

(setq-default register-preview-delay 0
              register-preview-function 'consult-register-format)

(setq-default consult-project-root-function
      (lambda ()
        (when-let (project (project-current))
          (car (project-roots project)))))

(with-eval-after-load 'projectile
  (setq-default consult-project-root-function 'projectile-project-root))

;; Optionally tweak the register preview window.
;; This adds thin lines, sorting and hides the mode line of the window.
(advice-add 'register-preview :override 'consult-register-window)

;; Optionally replace `completing-read-multiple' with an enhanced version.
(advice-add 'completing-read-multiple :override 'consult-completing-read-multiple)
(advice-add 'multi-occur :override 'consult-multi-occur)

;; Use Consult to select xref locations with preview
(setq-default xref-show-xrefs-function 'consult-xref
              xref-show-definitions-function 'consult-xref)

;; Key bindings:
(global-set-key (kbd "C-x M-f") 'consult-recent-file)
;; (global-set-key (kbd "C-s") 'consult-line)
;; (global-set-key (kbd "C-r") 'consult-line)

(define-key minibuffer-local-map (kbd "C-s")     'consult-history)
(define-key minibuffer-local-map (kbd "C-c a")   'embark-act)
(define-key minibuffer-local-map (kbd "C-c e")   'embark-export)

;; Evil key bindings:
(with-eval-after-load 'evil
  (my-space-leader-def
    "SPC" 'execute-extended-command
    "/"   'bee/consult-ripgrep-at-point
    "."   'find-file

    "a"  'embark-act
    "bB" 'switch-to-buffer

    "ff"  'find-file
    "fr"  'consult-recent-file

    "ht"  'consult-theme

    ;; swiper
    "ss" 'consult-line
    "sS" 'consult-line
    "sb" 'consult-line)

  ;; For projectile:
  (with-eval-after-load 'projectile
    (my-space-leader-def
      "," 'projectile-switch-to-buffer

      "bb" 'projectile-switch-to-buffer))
  (define-key minibuffer-local-map (kbd "C-w C-w") 'other-window)
  (define-key minibuffer-local-map (kbd "C-w j")   'evil-window-down)
  (define-key minibuffer-local-map (kbd "C-w k")   'evil-window-up))

(provide 'bee-vertico)

;;; bee-vertico.el ends here
