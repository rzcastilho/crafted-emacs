;;;; crafted-typescript.el --- Typescript config     -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'typescript-mode)

(add-hook 'typescript-mode-hook 'eglot-ensure)

(provide 'crafted-typescript)
;;; crafted-typescript.el ends here
