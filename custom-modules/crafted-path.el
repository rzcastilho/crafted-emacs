;;;; crafted-path.el --- Path configuration          -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'exec-path-from-shell)

(exec-path-from-shell-initialize)

(provide 'crafted-path)
;;; crafted-path.el ends here
