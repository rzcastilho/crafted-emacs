;;;; crafted-elixir.el --- Elixir configuration      -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'elixir-mode)
(crafted-package-install-package 'mix)

(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'elixir-mode-hook 'mix-minor-mode)

(provide 'crafted-elixir)
;;; crafted-elixir.el ends here
