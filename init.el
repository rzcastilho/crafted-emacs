(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil 'nomessage))

;; It crashes the configuration if not initialized here
(setq package-selected-packages nil)

(load "~/crafted-emacs/modules/crafted-init-config")

;; Select packages to install
(require 'crafted-completion-packages)
(require 'crafted-ide-packages)
(require 'crafted-org-packages)
(require 'crafted-ui-packages)

;; Custom
(require 'crafted-programming-packages)
(require 'crafted-my-org-packages)
(require 'crafted-theme-packages)

;; Install packages
(package-install-selected-packages :noconfirm)

;; Load crafted-updates configuration
(require 'crafted-defaults-config)
(require 'crafted-osx-config)
(require 'crafted-startup-config)
(require 'crafted-ide-config)
(require 'crafted-org-config)
(require 'crafted-ui-config)
(require 'crafted-completion-config)

;; Custom
(require 'crafted-programming-config)
(require 'crafted-my-org-config)

;; Automatically register `eglot-ensure` hooks for relevant major modes
(crafted-ide-eglot-auto-ensure-all)

;; The first time you run Emacs with this enabled, the
;; tree sitter parser will be installed for you automatically.
(crafted-ide-configure-tree-sitter)

;; Profile emacs startup
(defun crafted-startup-example/display-startup-time ()
  "Display the startup time after Emacs is fully initialized."
  (message "Crafted Emacs loaded in %s."
           (emacs-init-time)))
(add-hook 'emacs-startup-hook #'crafted-startup-example/display-startup-time)

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

;; Show column number
(setq column-number-mode t)

;; Load theme
(load-theme 'zenburn t)

;; Set font size
(set-face-attribute 'default nil :height 160)
