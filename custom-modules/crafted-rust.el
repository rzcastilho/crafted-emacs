;;;; crafted-rust.el --- rust configuration          -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'exec-path-from-shell)
(crafted-package-install-package 'rust-mode)

(exec-path-from-shell-initialize)

(add-hook 'rust-mode-hook 'eglot-ensure)

(provide 'crafted-rust)
;;; crafted-rust.el ends here
