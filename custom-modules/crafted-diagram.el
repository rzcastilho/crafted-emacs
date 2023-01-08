;;;; crafted-diagram.el --- Diagram configuration     -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'plantuml-mode)
(crafted-package-install-package 'flycheck-plantuml)

(setq org-plantuml-jar-path (expand-file-name "/usr/local/bin/plantuml.jar"))

(provide 'crafted-diagram)
;;; crafted-diagram.el ends here
