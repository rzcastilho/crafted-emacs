;;; crafted-my-org-config.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;; Commentary

;; Provides custom configuration for Org Mode.

;;; Code:

(setq org-ellipsis " ▾")
(setq org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))

(setq visual-fill-column-width 110
      visual-fill-column-center-text t)

(setq org-image-actual-width nil)

(load-library "ox-reveal")

;; Turn on variable pitch fonts in Org Mode buffers
(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'org-bullets-mode)
(add-hook 'org-mode-hook 'visual-fill-column-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(provide 'crafted-my-org-config)
;;; crafted-my-org-config.el ends here
