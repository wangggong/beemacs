;;; bee-evil.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(setq-default evil-want-integration t)
(setq evil-want-keybinding nil)

;; Packages:
(require-package 'evil)
(require-package 'evil-escape)
(require-package 'evil-exchange)
;; (require-package 'evil-find-char-pinyin)
;; (require-package 'evil-mark-replace)
;; (require-package evil-matchit)
;; (require-package 'evil-nerd-commenter)
(require-package 'evil-surround)
(require-package 'evil-visualstar)
(require-package 'evil-collection)

;; TODO - this may not be here?
(require-package 'neotree)

;; Enable evil mode:
(evil-mode 1)
(global-set-key (kbd "C-u") 'evil-scroll-up)

;; Undo - Redo:
(global-undo-tree-mode t)
(evil-set-undo-system 'undo-tree)

;; Enable evil escape mode:
(setq-default evil-escape-delay 0.05)
(evil-escape-mode 1)

;; {{ Use `SPC` as leader key
;; all keywords arguments are still supported
(general-create-definer my-space-leader-def
  :prefix "SPC"
  :states '(normal visual))

;; Basic keymap:
(my-space-leader-def
  "SPC" 'execute-extended-command
  "'"   'eshell
  "."   'find-file
  "="   'neotree-toggle

  ;; buffer
  "bB" 'switch-to-buffer
  "bd" (lambda ()
         (interactive)
         (kill-buffer nil))

  ;; compile
  "cc" 'compile

  ;; file
  "fs"  'save-buffer
  "ff"  'find-file
  "fp"  'bee-open-init-file

  ;; help
  "ht"  'load-theme

  ;; windows
  "w/"  'evil-window-vsplit
  "w-"  'evil-window-split
  "wh"  'evil-window-left
  "wj"  'evil-window-down
  "wk"  'evil-window-up
  "wl"  'evil-window-right)

;; For project:
(require 'project)
(my-space-leader-def
  "," 'project-switch-to-buffer
  "/" 'project-find-regexp

  "bb" 'project-switch-to-buffer

  "gg" 'project-vc-dir

  "pp" (lambda (&optional dir)
         (interactive (list (project-prompt-project-dir)))
         (let ((project-switch-commands 'project-find-file))
           (project-switch-project dir)))
  "pf" 'project-find-file)

;; Modify `*` / `#` - 太难用了
;; (defalias #'forward-evil-word #'forward-evil-symbol)
(define-key evil-motion-state-map (kbd "*") (lambda ()
                                              (interactive)
                                              (evil-ex-search-word-forward 1 t)))
(define-key evil-motion-state-map (kbd "#") (lambda ()
                                              (interactive)
                                              (evil-ex-search-word-backward 1 t)))
(define-key evil-motion-state-map (kbd "n") 'evil-ex-search-next)
(define-key evil-motion-state-map (kbd "N") 'evil-ex-search-previous)
(define-key evil-motion-state-map (kbd "/") 'evil-ex-search-forward)
(define-key evil-motion-state-map (kbd "?") 'evil-ex-search-backward)

(with-eval-after-load 'better-jumper
  (define-key evil-motion-state-map (kbd "C-o") 'better-jumper-jump-backward)
  (define-key evil-motion-state-map (kbd "C-i") 'better-jumper-jump-forward))

(define-key evil-motion-state-map (kbd "zh") 'evil-scroll-left)
(define-key evil-motion-state-map (kbd "zl") 'evil-scroll-right)

;; H / L 留点 margin, 看上去会很 "高端".
(setq-default scroll-margin 3)

;; Evil surround:
(add-hook 'prog-mode-hook 'evil-surround-mode)

;; Evil collection:
;;
;; 只配置必要的 mode list. 先这么配着, 有用着不舒服的再开.
(setq evil-collection-mode-list
      `(
        ;; 2048-game
        ;; ag
        ;; alchemist
        ;; anaconda-mode
        ;; apropos
        ;; arc-mode
        ;; auto-package-update
        ;; beginend
        ;; bm
        ;; bookmark
        ;; (buff-menu "buff-menu")
        ;; calc
        ;; calendar
        ;; cider
        ;; cmake-mode
        ;; comint
        company
        compile
        consult
        ;; (custom cus-edit)
        ;; cus-theme
        ;; dashboard
        ;; daemons
        ;; deadgrep
        ;; debbugs
        ;; debug
        ;; devdocs
        ;; dictionary
        diff-hl
        diff-mode
        dired
        dired-sidebar
        ;; disk-usage
        ;; distel
        ;; doc-view
        ;; docker
        ;; ebib
        ;; edbi
        ;; edebug
        ediff
        ;; eglot
        ;; explain-pause-mode
        ;; elfeed
        ;; elisp-mode
        ;; elisp-refs
        ;; elisp-slime-nav
        embark
        ;; emms
        ;; epa
        ;; ert
        eshell
        eval-sexp-fu
        evil-mc
        ;; eww
        ;; fanyi
        ;; finder
        flycheck
        flymake
        ;; free-keys
        ;; geiser
        ;; ggtags
        ;; git-timemachine
        ;; gnus
        grep
        ;; guix
        ;; hackernews
        helm
        help
        helpful
        ;; hg-histedit
        ;; hungry-delete
        ibuffer
        ;; image
        ;; image-dired
        ;; image+
        ;; imenu
        ;; imenu-list
        ;; (indent "indent")
        ;; indium
        ;; info
        ivy
        ;; js2-mode
        ;; leetcode
        ;; lispy
        ;; log-edit
        ;; log-view
        lsp-ui-imenu
        lua-mode
        ;; kotlin-mode
        ;; macrostep
        ;; man
        magit
        magit-todos
        ;; markdown-mode
        ;; monky
        ;; mpdel
        ;; mu4e
        ;; mu4e-conversation
        neotree
        ;; newsticker
        ;; notmuch
        ;; nov
        (occur replace)
        ;; omnisharp
        org-present
        ;; zmusic
        ;; osx-dictionary
        ;; outline
        ;; p4
        ;; (package-menu package)
        ;; pass
        ;; (pdf pdf-view)
        ;; popup
        ;; proced
        ;; (process-menu simple)
        ;; prodigy
        ;; profiler
        ;; python
        ;; quickrun
        ;; racer
        ;; racket-describe
        ;; realgud
        ;; reftex
        ;; restclient
        rg
        ripgrep
        ;; rjsx-mode
        ;; robe
        rtags
        ;; ruby-mode
        ;; scroll-lock
        ;; selectrum
        ;; sh-script
        ;; ,@(when (>= emacs-major-version 28) '(shortdoc))
        ;; simple
        ;; slime
        ;; sly
        ;; speedbar
        ;; ,@(when (>= emacs-major-version 27) '(tab-bar))
        ;; tablist
        ;; tabulated-list
        ;; tar-mode
        ;; telega
        ;; (term term ansi-term multi-term)
        ;; tetris
        ;; ,@(when (>= emacs-major-version 27) '(thread))
        ;; tide
        ;; timer-list
        ;; transmission
        ;; trashed
        ;; tuareg
        ;; typescript-mode
        vc-annotate
        vc-dir
        vc-git
        vdiff
        vertico
        view
        vlf
        vterm
        ;; w3m
        ;; wdired
        wgrep
        which-key
        ;; woman
        xref
        ;; yaml-mode
        ;; youtube-dl
        ;; (ztree ztree-diff)
        ;; xwidget
        ))
(evil-collection-init)

(provide 'bee-evil)

;;; bee-evil.el ends here
