;;; init.el -*- lexical-binding: t -*-

;;; Code:

(add-to-list 'load-path (expand-file-name "src" user-emacs-directory))

;; Constants.
(defconst *is-mac* (eq system-type 'darwin) "Is a Mac?")
(defconst *is-linux* (eq system-type 'gnu/linux) "Is a Linux PC?")
(defconst *is-windows* (memq system-type '(cygwin windows-nt ms-dos)) "Is a Windows PC?")

;; Init GC config: don't GC during startup to save time.
(setq gc-cons-percentage 0.6)
(setq gc-cons-threshold most-positive-fixnum)

;; Custom file config.
(setq custom-file (locate-user-emacs-file "custom.el"))

(require 'bee-autoload)
(require 'bee-elpa)

(require-package 'general)

(require 'bee-xterm)
(require 'bee-ui)
(require 'bee-key)
(require 'bee-evil)
(require 'bee-term)
(require 'bee-screen)
(require 'bee-avy)
;; (require 'bee-ivy)
(require 'bee-vertico)
(require 'bee-flycheck)
(require 'bee-magit)
(require 'bee-company)
(require 'bee-snippet)
;; (require 'bee-projectile)

(require 'bee-lsp)
;; (require 'bee-tags)

(require 'bee-go)
(require 'bee-php)

(require 'bee-diminish)

;; @see https://www.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/
;; Emacs 25 does gc too frequently
(setq gc-cons-threshold  (* 64 1024 1024)) ; 64M
(setq gc-cons-percentage 0.1)              ; original value

;; http://blog.lujun9972.win/blog/2019/05/16/%E4%BC%98%E5%8C%96emacs%E7%9A%84%E5%9E%83%E5%9C%BE%E6%90%9C%E9%9B%86%E8%A1%8C%E4%B8%BA/index.html
(defmacro bee-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

(defvar bee-gc-timer
  (run-with-idle-timer 10 t
                       (lambda ()
                         (message "Garbage Collector has run for %.06fsec"
                                  (bee-time (garbage-collect))))))

(provide 'init)

;;; init.el ends here

