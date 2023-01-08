;;;; crafted-kotlin.el --- Kotlin configuration       -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:
(crafted-package-install-package 'kotlin-mode)

(add-hook 'kotlin-mode-hook #'eglot-ensure)

(provide 'crafted-kotlin)
;;; crafted-kotlin.el ends here
