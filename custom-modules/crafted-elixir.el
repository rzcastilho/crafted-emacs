;;;; crafted-elixir.el --- Elixir development configuration  -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'exec-path-from-shell)
(crafted-package-install-package 'elixir-mode)
(crafted-package-install-package 'mix)

(exec-path-from-shell-initialize)

(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'elixir-mode-hook 'mix-minor-mode)

(provide 'crafted-elixir)
;;; crafted-elixir.el ends here
