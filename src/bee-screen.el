;;; bee-screen.el -*- lexical-binding: t -*-

;;; Code:

;;; Packages:
(require-package 'elscreen)

;; Start screen:
(elscreen-start)
(setq-default elscreen-display-tab nil)

(defface bee/elscreen-current-face
  '((t (:background "brightblack" :weight bold :inherit default)))
  "Powerline face for evil NORMAL state."
  :group 'default)

(defun bee/elscreen-display ()
  "Display a list of workspaces (like tabs) in the echo area."
  (interactive)
  (let* ((screen-list (sort (elscreen-get-screen-list) '<))
         (screen-to-name-alist (elscreen-get-screen-to-name-alist))
         (truncate-length (- (frame-width) 6))
         (candidate (concat
                     (mapconcat
                      (lambda (screen)
                        (let* ((screen-label (+ screen 1))
                               (status-label (elscreen-status-label screen))
                               (screen-name (elscreen-truncate-screen-name
                                             (assoc-default screen screen-to-name-alist)
                                             truncate-length)))
                          (cond ((string-equal status-label "+") (propertize
                                                                  (format " [%d] %s " screen-label screen-name)
                                                                  'face 'bee/elscreen-current-face))
                                (t (format " [%d] %s " screen-label screen-name)))))
                      screen-list nil))))
    (message candidate)))

;; Save / load session:
;;
;; From https://stackoverflow.com/questions/22445670/save-and-restore-elscreen-tabs-and-split-frames
;; http://stackoverflow.com/questions/803812/emacs-reopen-buffers-from-last-session-on-startup
(defvar bee/emacs-configuration-directory
  "~/.emacs.d/"
  "The directory where the emacs configuration files are stored.")

(defvar bee/elscreen-tab-configuration-store-filename
  (concat bee/emacs-configuration-directory ".elscreen")
  "The file where the elscreen tab configuration is stored.")

(defun bee/elscreen-store ()
  "Store the elscreen tab configuration."
  (interactive)
  (if (desktop-save bee/emacs-configuration-directory)
      (with-temp-file bee/elscreen-tab-configuration-store-filename
        (insert (prin1-to-string (elscreen-get-screen-to-name-alist))))))

(defun bee/elscreen-restore ()
  "Restore the elscreen tab configuration."
  (interactive)
  (if (desktop-read)
      (let ((screens (reverse
                      (read
                       (with-temp-buffer
                         (insert-file-contents bee/elscreen-tab-configuration-store-filename)
                         (buffer-string))))))
        (while screens
          (setq screen (car (car screens)))
          (setq buffers (split-string (cdr (car screens)) ":"))
          (if (eq screen 0)
              (switch-to-buffer (car buffers))
            (elscreen-find-and-goto-by-buffer (car buffers) t t))
          (while (cdr buffers)
            (switch-to-buffer-other-window (car (cdr buffers)))
            (setq buffers (cdr buffers)))
          (setq screens (cdr screens))))))

(defun bee/elscreen-close-window-or-workspace (&optional args)
  "Close the selected window. If it's the last window in the workspace,
either close the workspace (as well as its associated frame, if one exists)
and move to the next"
  (interactive)
  (let ((current-screen-list (split-string (assoc-default (elscreen-get-current-screen)
                                                          (elscreen-get-screen-to-name-alist))
                                           ":")))
    (message (format "%s" current-screen-list))
    (if (> (length current-screen-list) 1)
        (evil-window-delete)
      (elscreen-kill args))))

;; Evil key bindings:
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "gt") 'elscreen-next)
  (define-key evil-normal-state-map (kbd "gT") 'elscreen-previous)
  (my-space-leader-def
    "0"       (lambda () (interactive) (elscreen-goto 0) (elscreen-previous))
    "1"       (lambda () (interactive) (elscreen-goto 0))
    "2"       (lambda () (interactive) (elscreen-goto 1))
    "3"       (lambda () (interactive) (elscreen-goto 2))
    "4"       (lambda () (interactive) (elscreen-goto 3))
    "5"       (lambda () (interactive) (elscreen-goto 4))
    "6"       (lambda () (interactive) (elscreen-goto 5))
    "7"       (lambda () (interactive) (elscreen-goto 6))
    "8"       (lambda () (interactive) (elscreen-goto 7))
    "9"       (lambda () (interactive) (elscreen-goto 8))
    "qS"      'bee/elscreen-store
    "qL"      'bee/elscreen-restore
    "wt"      'elscreen-create
    "wd"      'bee/elscreen-close-window-or-workspace
    "TAB t"   'elscreen-create
    "TAB d"   'elscreen-kill
    "TAB TAB" 'bee/elscreen-display))

(provide 'bee-screen)

;;; bee-screen.el ends here
