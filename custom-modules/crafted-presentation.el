;;;; crafted-presentation.el --- Presentation configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'org-tree-slide)
(crafted-package-install-package 'hide-mode-line)

(defun efs/presentation-setup ()
  (hide-mode-line-mode 1)
  (org-display-inline-images) ;; Can also use org-startup-with-inline-images
  (setq text-scale-mode-amount 3)
  (text-scale-increase 2))

(defun efs/presentation-end ()
  (hide-mode-line-mode 0)
  (text-scale-decrease 2))

(add-hook 'org-tree-slide-play-hook #'efs/presentation-setup)
(add-hook 'org-tree-slide-stop-hook #'efs/presentation-end)

(setq org-tree-slide-slide-in-effect t)
(setq org-tree-slide-activate-message "Presentation started!")
(setq org-tree-slide-deactivate-message "Presentation finished!")
(setq org-tree-slide-header t)
(setq org-tree-slide-breadcrumbs " > ")
(setq org-image-actual-width nil)

(provide 'crafted-presentation)
;;; crafted-presentation.el ends here
