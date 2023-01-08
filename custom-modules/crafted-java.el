;;;; crafted-java.el --- Java configuration           -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(add-hook 'java-mode-hook #'eglot-ensure)

(provide 'crafted-java)
;;; crafted-java.el ends here
