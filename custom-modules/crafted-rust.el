;;;; crafted-rust.el --- Rust configuration          -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'rustic)

(setq rustic-lsp-client 'eglot)

(provide 'crafted-rust)
;;; crafted-rust.el ends here
