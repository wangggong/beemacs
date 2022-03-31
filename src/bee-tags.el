;;; bee-tags.el -*- lexical-binding: t -*-

;;; Code:

;; Packages:
(require-package 'ggtags)

(setq-default bee-tags-enabled t)

;; Key bindings:
(global-set-key (kbd "C-x g g") 'ggtags-find-tag-dwim)
(global-set-key (kbd "C-x g d") 'ggtags-find-definition)
(global-set-key (kbd "C-x g D") 'ggtags-find-reference)

(provide 'bee-tags)

;;; bee-tags.el ends here
