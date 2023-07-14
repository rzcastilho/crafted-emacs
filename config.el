;;; config.el -- Crafted Emacs user customization file -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Crafted Emacs supports user customization through a `config.el' file
;; similar to this one.  You can copy this file as `config.el' to your
;; Crafted Emacs configuration directory as an example.
;;
;; In your configuration you can set any Emacs configuration variable, face
;; attributes, themes, etc as you normally would.
;;
;; See the README.org file in this repository for additional information.

;;; Code:
;; At the moment, Crafted Emacs offers the following modules.
;; Comment out everything you don't want to use.
;; At the very least, you should decide whether or not you want to use
;; evil-mode, as it will greatly change how you interact with Emacs.
;; So, if you prefer Vim-style keybindings over vanilla Emacs keybindings
;; remove the comment in the line about `crafted-evil' below.
(require 'crafted-defaults)    ; Sensible default settings for Emacs
(require 'crafted-updates)     ; Tools to upgrade Crafted Emacs
(require 'crafted-completion)  ; selection framework based on `vertico`

;; Enable doom mode line
(setq crafted-ui-use-doom-modeline t)

(require 'crafted-ui)          ; Better UI experience (modeline etc.)

(require 'crafted-windows)     ; Window management configuration
(require 'crafted-editing)     ; Whitspace trimming, auto parens etc.
;(require 'crafted-evil)        ; An `evil-mode` configuration
(require 'crafted-org)         ; org-appear, clickable hyperlinks etc.
(require 'crafted-project)     ; built-in alternative to projectile
(require 'crafted-speedbar)    ; built-in file-tree
;(require 'crafted-screencast)  ; show current command and binding in modeline
(require 'crafted-compile)     ; automatically compile some emacs lisp files
(require 'crafted-startup)
(require 'crafted-ide)
(require 'crafted-erlang)
(require 'crafted-python)
(require 'crafted-lisp)

;; Require custom modules here
;;(require 'crafted-desktop)
(require 'crafted-path)
(require 'crafted-elixir)
(require 'crafted-java)
(require 'crafted-typescript)
(require 'crafted-kotlin)
(require 'crafted-http)
(require 'crafted-docker)
(require 'crafted-rust)
(require 'crafted-terraform)
(require 'crafted-diagram)
(require 'crafted-babel)
(require 'crafted-presentation)
(require 'crafted-template)

;; Configuring Org Source Block Templates
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("pl" . "src plantuml"))
(add-to-list 'org-structure-template-alist '("ex" . "src elixir"))
(add-to-list 'org-structure-template-alist '("mo" . "src mongo"))
(add-to-list 'org-structure-template-alist '("ht" . "src http"))
(add-to-list 'org-structure-template-alist '("jv" . "src java"))
(add-to-list 'org-structure-template-alist '("js" . "src js"))
(add-to-list 'org-structure-template-alist '("kt" . "src kotlin"))
(add-to-list 'org-structure-template-alist '("mm" . "src mermaid"))
(add-to-list 'org-structure-template-alist '("sq" . "src sql"))

;; `with-eval-after-load' macro was introduced in Emacs 24.x
;; In older Emacsen, you can do the same thing with `eval-after-load'
;; and '(progn ..) form.
(with-eval-after-load 'org
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

;; Org Babel Languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (sql . t)
   (emacs-lisp . t)
   (elixir . t)
   (plantuml . t)
   (mermaid . t)
   (java . t)
   (kotlin . t)
   (mongo . t)
   (http . t)
   (python . t)
   (js . t)))

;; Set the default face. The default face is the basis for most other
;; faces used in Emacs. A "face" is a configuration including font,
;; font size, foreground and background colors and other attributes.
;; The fixed-pitch and fixed-pitch-serif faces are monospace faces
;; generally used as the default face for code. The variable-pitch
;; face is used when `variable-pitch-mode' is turned on, generally
;; whenever a non-monospace face is preferred.
(add-hook 'emacs-startup-hook
          (lambda ()
            (custom-set-faces
             `(default ((t (:font "JetBrains Mono Light 12"))))
             `(fixed-pitch ((t (:inherit (default)))))
             `(fixed-pitch-serif ((t (:inherit (default)))))
             `(variable-pitch ((t (:font "Arial 12")))))))

;; Override crafted emacs to complete with 3 prefix keys
(customize-set-variable 'corfu-auto-prefix 3)

;; Themes are color customization packages which coordinate the
;; various colors, and in some cases, font-sizes for various aspects
;; of text editing within Emacs, toolbars, tabbars and
;; modeline. Several themes are built-in to Emacs, by default,
;; Crafted Emacs uses the `deeper-blue' theme. Here is an example of
;; loading a different theme from the venerable Doom Emacs project.
(crafted-package-install-package 'doom-themes)
(progn
  (disable-theme 'deeper-blue)          ; first turn off the deeper-blue theme
  (load-theme 'doom-acario-dark t))       ; load the doom-palenight theme

;; Backup files
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

;; Lock files
(setq create-lockfiles nil)

;; Auto save files
;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

(customize-set-variable 'crafted-startup-inhibit-splash t)
(customize-set-variable 'crafted-ui-display-line-numbers t)

(add-hook 'prog-mode-hook #'hl-line-mode)

;; Automatically kill buffer after exit term
(defadvice term-handle-exit
    (after term-kill-buffer-on-exit activate)
  (kill-buffer))

(setq column-number-mode t)

(setq js-indent-level 2)

(server-start)

;; To not load `custom.el' after `config.el', uncomment this line.
;; (setq crafted-load-custom-file nil)

;;; config.el ends here
