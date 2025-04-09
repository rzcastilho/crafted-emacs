;; Set up custom.el file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

;; Bootstrap crafted-emacs in init.el
(load "~/crafted-emacs/modules/crafted-init-config")

(defun crafted-emacs-load-modules (modules)
  "Initialize crafted-emacs modules.

MODULES is a list of module names without the -packages or
-config suffixes.  Note that any user-provided packages should be
added to `package-selected-packages' before invoking this
function."
  (dolist (m modules)
    (require (intern (format "crafted-%s-packages" m)) nil :noerror))
  (package-install-selected-packages :noconfirm)
  (dolist (m modules)
    (require (intern (format "crafted-%s-config" m)) nil :noerror)))

;; Any extra packages in addition to the ones added by crafted-emacs
;; modules go here before we call `crafted-emacs-load-modules'.
(customize-set-variable 'package-selected-packages '(elixir-mode
                                                     elixir-ts-mode
                                                     go-mode
                                                     go-ts-mode
                                                     mise
                                                     exec-path-from-shell
                                                     yasnippet
                                                     yasnippet-snippets))

(crafted-emacs-load-modules '(defaults completion ui ide osx))

(yas-global-mode 1)

;; Dev tools configuration
(exec-path-from-shell-initialize)
(add-hook 'after-init-hook #'global-mise-mode)
(setq mise-update-on-eshell-directory-change t)

;; The first time you run Emacs with this enabled, the
;; tree sitter parser will be installed for you automatically.
(crafted-ide-configure-tree-sitter '(elixir go))

;; Automatically register `eglot-ensure` hooks for relevant major modes
(crafted-ide-eglot-auto-ensure-all)

(setq major-mode-remap-alist
      '((elixir-mode . elixir-ts-mode)
        (go-mode . go-ts-mode)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((elixir-mode elixir-ts-mode heex-ts-mode) . ("elixir-ls"))))

(add-hook 'elixir-ts-mode-hook 'eglot-ensure)

;; (add-hook 'prog-mode-hook #'aggressive-indent-mode)
(add-hook 'prog-mode-hook #'electric-indent-mode)
(add-hook 'prog-mode-hook #'electric-pair-mode)

;; Close buffer when ends buffer terminal
(defun term-handle-exit-func (&optional process-name msg)
  (message "%s | %s" process-name msg)
  (kill-buffer (current-buffer)))

(advice-add 'term-handle-exit :after 'term-handle-exit-func)

;; Auto save files
;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

;; Disable backup files
(setq make-backup-files nil)

;; Hide unused interface itens
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Show line numbers
(customize-set-variable 'crafted-ui-display-line-numbers t)

;; Load theme
(load-theme 'modus-vivendi-deuteranopia)

;; Font Settings
(set-face-attribute 'default nil :family "Fira Code" :height 180 :weight 'light)

;; Set transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))
