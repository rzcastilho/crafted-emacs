;; Set up custom.el file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

;; Bootstrap crafted-emacs in init.el
(load "~/crafted-emacs/modules/crafted-init-config")

;; Function to load crafted-emacs pair file modules
;; and install selected packages
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
(customize-set-variable 'package-selected-packages '(combobulate
                                                     copilot
                                                     copilot-chat
                                                     dockerfile-mode
                                                     dockerfile-ts-mode
                                                     docker-compose-mode
                                                     eat
                                                     elixir-mode
                                                     elixir-ts-mode
                                                     go-mode
                                                     go-ts-mode
                                                     gotest
                                                     gotest-ts
                                                     go-gen-test
                                                     js-mode
                                                     js-ts-mode
                                                     tsx-ts-mode
                                                     typescript-mode
                                                     typescript-ts-mode
                                                     javascript-mode
                                                     javascript-ts-mode
                                                     dap-mode
                                                     dap-ui-mode
                                                     dap-dlv-go
                                                     dap-elixir
                                                     python-mode
                                                     python-ts-mode
                                                     mise
                                                     exec-path-from-shell
                                                     vterm
                                                     yaml-mode
                                                     yaml-ts-mode
                                                     yasnippet
                                                     yasnippet-snippets))

(crafted-emacs-load-modules '(startup defaults completion ui ide))

(customize-set-variable 'crafted-startup-module-list '(crafted-startup-projects crafted-startup-recentf))

;; Custom configuration for eglot-server-programs
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((elixir-mode elixir-ts-mode heex-ts-mode) . ("elixir-ls"))))

;; Automatically register `eglot-ensure` hooks for relevant major modes
(crafted-ide-eglot-auto-ensure-all)

(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'elixir-mode-hook #'eglot-ensure)
(add-hook 'python-mode-hook #'eglot-ensure)

;; Configure sources for custom language grammars
(setq treesit-language-source-alist
      '((gomod . ("https://github.com/camdencheek/tree-sitter-go-mod" nil nil nil))))

;; Install selected language grammars
(crafted-ide-configure-tree-sitter '(elixir go gomod javascript typescript tsx python))

;; --------------------------------------------------------------------------------
;; non crafted-emacs configurations
;; --------------------------------------------------------------------------------

;; Dev tools configuration
(exec-path-from-shell-initialize)
(add-hook 'after-init-hook #'global-mise-mode)
(setq mise-update-on-eshell-directory-change t)

;; install claude-code.el
(use-package claude-code :ensure t
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))

;; Load yasnippets globally
(yas-global-mode 1)

;; gptel: A simple LLM client for Emacs
;; Register backend
;; Github Models offers an OpenAI compatible API
(gptel-make-openai "Github Models"
  :host "models.inference.ai.azure.com"
  :endpoint "/chat/completions?api-version=2024-05-01-preview"
  :stream t
  :key (or (getenv "GITHUB_TOKEN") 
           (error "GITHUB_TOKEN environment variable not set"))
  :models '(gpt-4o))
;;
;; (gptel-make-gh-copilot "Copilot")

;; OPTIONAL configuration
(setq gptel-model  'gpt-4o
      gptel-backend
      (gptel-make-openai "Github Models" ;Any name you want
        :host "models.inference.ai.azure.com"
        :endpoint "/chat/completions?api-version=2024-05-01-preview"
        :stream t
        :key (or (getenv "GITHUB_TOKEN") 
                 (error "GITHUB_TOKEN environment variable not set"))
        :models '(gpt-4o)))
;;
;; (setq gptel-model 'claude-3.7-sonnet
;;       gptel-backend (gptel-make-gh-copilot "Copilot"))

;; dap-mode configurations

(require 'dap-mode)
(require 'dap-ui)
(require 'dap-dlv-go)
(require 'dap-elixir)

;; Enabling only some features
(setq dap-auto-configure-features '(sessions locals controls tooltip))

(setq major-mode-remap-alist
      '((elixir-mode . elixir-ts-mode)
        (go-mode . go-ts-mode)
        (yaml-mode . yaml-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (javascript-mode . javascript-ts-mode)))

;; (add-hook 'elixir-mode-hook #'dap-mode)
;; (add-hook 'elixir-mode-hook #'dap-ui-mode)
;; (add-hook 'elixir-mode-hook #'dap-tooltip-mode)

(add-hook 'go-mode-hook #'dap-mode)
(add-hook 'go-mode-hook #'dap-ui-mode)
(add-hook 'go-mode-hook #'dap-tooltip-mode)

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
(set-face-attribute 'default nil :family "Fira Code" :height 105 :weight 'regular)

;; Set transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))