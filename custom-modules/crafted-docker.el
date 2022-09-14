;;;; crafted-docker.el --- Docker tools config       -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'dockerfile-mode)
(crafted-package-install-package 'docker-compose-mode)
(crafted-package-install-package 'docker)

(provide 'crafted-docker)
;;; crafted-docker.el ends here
