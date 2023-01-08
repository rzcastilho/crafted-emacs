;;;; crafted-babel.el --- Org-Mode Babel configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'ob-mongo)
(crafted-package-install-package 'ob-http)
(crafted-package-install-package 'ob-kotlin)

(provide 'crafted-babel)
;;; crafted-babel.el ends here
