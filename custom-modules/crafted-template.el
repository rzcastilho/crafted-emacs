;;;; crafted-template.el --- Template configuration  -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'yasnippet)
(crafted-package-install-package 'yasnippet-snippets)
(require 'yasnippet)

(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

(provide 'crafted-template)
;;; crafted-template.el ends here
