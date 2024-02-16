;;;; crafted-programming-packages.el -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(add-to-list 'package-selected-packages 'exec-path-from-shell)
(add-to-list 'package-selected-packages 'prettify-symbols-mode)

(add-to-list 'package-selected-packages 'yasnippet)
(add-to-list 'package-selected-packages 'yasnippet-snippets)

;;; Web
(add-to-list 'package-selected-packages 'emmet-mode)

;;; Elixir
(add-to-list 'package-selected-packages 'elixir-mode)
(add-to-list 'package-selected-packages 'elixir-ts-mode)
(add-to-list 'package-selected-packages 'mix)
(add-to-list 'package-selected-packages 'ob-elixir)

;;; Rust
(add-to-list 'package-selected-packages 'rustic)

;;; Containers
(add-to-list 'package-selected-packages 'docker)
(add-to-list 'package-selected-packages 'dockerfile-mode)
(add-to-list 'package-selected-packages 'docker-compose-mode)
(add-to-list 'package-selected-packages 'earthfile-mode)

(provide 'crafted-programming-packages)
;;; crafted-programming-packages.el ends here
