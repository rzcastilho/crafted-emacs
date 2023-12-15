3(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(load "~/crafted-emacs/modules/crafted-init-config")

;; Select packages to install
(require 'crafted-ui-packages)
(require 'crafted-completion-packages)
(require 'crafted-ide-packages)
(require 'crafted-org-packages)

;; Custom
(require 'crafted-programming-packages)
(require 'crafted-my-org-packages)

;; Install packages
(package-install-selected-packages :noconfirm)

;; Load crafted-updates configuration
(require 'crafted-defaults-config)
(require 'crafted-startup-config)
(require 'crafted-ui-config)
(require 'crafted-completion-config)
(require 'crafted-ide-config)
(require 'crafted-org-config)

;; Custom
(require 'crafted-programming-config)
(require 'crafted-my-org-config)

(customize-set-variable 'crafted-ui-display-line-numbers t)

;; Hide unused interface itens
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)


;; Auto save files
;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

;; Disable backup files
(setq make-backup-files nil)

;; UTF-8 support
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-language-environment   'utf-8)
(set-keyboard-coding-system 'utf-8-unix)

