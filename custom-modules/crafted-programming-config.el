;;;; crafted-programming-config.el -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(exec-path-from-shell-initialize)

;;; Format code
(add-hook 'before-save-hook 'eglot-format)

;;; YASnippet
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook 'yas-minor-mode)

;;; Web
(add-hook 'sgml-mode-hook  'emmet-mode)
(add-hook 'css-mode-hook   'emmet-mode)
(add-hook 'mhtml-mode-hook 'emmet-mode)

;;; Elixir
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'elixir-mode-hook 'mix-minor-mode)
(add-hook 'elixir-mode-hook 'prettify-symbols-mode)
(add-hook 'elixir-mode-hook (lambda()
                              (push '(">="  . ?\u2265) prettify-symbols-alist)
                              (push '("<="  . ?\u2264) prettify-symbols-alist)
                              (push '("=~"  . ?\u2245) prettify-symbols-alist)
                              (push '("<-"  . ?\u2190) prettify-symbols-alist)
                              (push '("->"  . ?\u2192) prettify-symbols-alist)
                              (push '("|>"  . ?\u25B7) prettify-symbols-alist)))

;;; Rust
(setq rustic-lsp-client 'eglot)

(provide 'crafted-programming-config)
;;; crafted-programming-config.el ends here
