;;;; crafted-desktop.el --- Desktop configuration     -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: Rodrigo Zampieri Castilho

;;; Commentary:

;;

;;; Code:

(crafted-package-install-package 'exwm)
(crafted-package-install-package 'desktop-environment)
(crafted-package-install-package 'wallpaper)
(crafted-package-install-package 'rainbow-mode)
(crafted-package-install-package 'transpose-frame)

(setq wallpaper-static-wallpaper-list
      '("~/Pictures/wallpapers/guests-2018-russian-horror-movie-8h-1920x1080.jpg"
        "~/Pictures/wallpapers/wallpapersden.com_it-horror-movie-official-poster-2017_2560x1080.jpg"))

(defun efs/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

(defvar efs/polybar-process nil
  "Holds the process of the running Polybar instance, if any")

(defun efs/kill-panel ()
  (interactive)
  (when efs/polybar-process
    (ignore-errors
      (kill-process efs/polybar-process)))
  (setq efs/polybar-process nil))

(defun efs/start-panel ()
  (interactive)
  (efs/kill-panel)
  (setq efs/polybar-process (start-process-shell-command "polybar" nil "polybar panel")))

(defun efs/polybar-exwm-workspace ()
  (pcase exwm-workspace-current-index
    (0 "[0] ")
    (1 "[1] ")
    (2 "[2] ")
    (3 "[3] ")
    (4 "[4] ")
    (_ (format "[%s] " exwm-workspace-current-index))))

(defun efs/send-polybar-hook (module-name hook-index)
  (start-process-shell-command "polybar-msg" nil (format "polybar-msg hook %s %s" module-name hook-index)))

(defun efs/send-polybar-exwm-workspace ()
  (efs/send-polybar-hook "exwm-workspace" 1))

;; Update panel indicator when workspace changes
(add-hook 'exwm-workspace-switch-hook #'efs/send-polybar-exwm-workspace)

(defun efs/exwm-init-hook ()

  ;; Start the Polybar panel
  (efs/start-panel)

  (efs/run-in-background "nm-applet")
  (efs/run-in-background "pasystray")
  (efs/run-in-background "blueman-applet"))

(defun efs/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

(defun efs/exwm-update-title ()
  (pcase exwm-class-name
    (`nil "empty class name")
    (exwm-class-name (pcase (downcase exwm-class-name)
                       ("firefox" (exwm-workspace-rename-buffer (format "Firefox: %s" exwm-title)))
                       ("google-chrome" (exwm-workspace-rename-buffer (format "Chrome: %s" exwm-title)))))))

(defun efs/configure-window-by-class ()
  (interactive)
  (pcase exwm-class-name
    (`nil "empty class name")
    (exwm-class-name (pcase (downcase exwm-class-name)
                       ("spotify" (exwm-floating-toggle-floating)
                        (exwm-layout-toggle-mode-line))
                       ("pavucontrol" (exwm-floating-toggle-floating)
                        (exwm-layout-toggle-mode-line))))))

;; This function should be used only after configuring autorandr!
(defun efs/update-displays ()
  (efs/run-in-background "autorandr --change --force")
  (wallpaper-set-wallpaper)
  (message "Display config: %s"
           (string-trim (shell-command-to-string "autorandr --current"))))

;; Set the default number of workspaces
(setq exwm-workspace-number 5)

;; Automatically move EXWM buffer to current workspace when selected
(setq exwm-layout-show-all-buffers t)

;; Display all EXWM buffers in every workspace buffer list
(setq exwm-workspace-show-all-buffers t)

;; Warp cursor automatically after workspace switch
(setq exwm-workspace-warp-cursor t)

;; Window focus should follow the mouse pointer
(setq mouse-autoselect-window t
      focus-follows-mouse t)

;; When window "class" updates, use it to set the buffer name
(add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

;; When window title updates, use it to set the buffer name
(add-hook 'exwm-update-title-hook #'efs/exwm-update-title)

;; Configure windows as trey're created
(add-hook 'exwm-manage-finish-hook #'efs/configure-window-by-class)

;; When EXWM starts up, do some extra configuration
(add-hook 'exwm-init-hook #'efs/exwm-init-hook)

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Set the screen resolution (update this to be the correct resolution for your screen!)
(require 'exwm-randr)
;; This will need to be updated to the name of a display!  You can find
;; the names of your displays by looking at arandr or the output of xrandr
(setq exwm-randr-workspace-monitor-plist '(0 "eDP-1" 1 "eDP-1" 2 "HDMI-1-0" 3 "HDMI-1-0" 4 "HDMI-1-0"))
;; React to display connectivity changes, do initial display update
(add-hook 'exwm-randr-screen-change-hook #'efs/update-displays)
(exwm-randr-enable)

(efs/update-displays)

;; These keys should always pass through to Emacs
(setq exwm-input-prefix-keys
      '(?\C-x
        ?\C-u
        ?\C-h
        ?\M-x
        ?\M-`
        ?\M-&
        ?\M-:
        ?\C-\M-j  ;; Buffer list
        ?\C-\ ))  ;; Ctrl+Space

;; Ctrl+Q will enable the next key to be sent directly
(define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;; Set up global key bindings.  These always work, no matter the input state!
;; Keep in mind that changing this list after EXWM initializes has no effect.
(setq exwm-input-global-keys
      `(
        ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
        ([?\s-r] . exwm-reset)

        ;; Move between windows
        ([s-left] . windmove-left)
        ([s-right] . windmove-right)
        ([s-up] . windmove-up)
        ([s-down] . windmove-down)

        ;; Launch applications via shell command
        ([?\s-&] . (lambda (command)
                     (interactive (list (read-shell-command "$ ")))
                     (start-process-shell-command command nil command)))

        ;; Switch workspace
        ([?\s-w] . exwm-workspace-switch)
        ([?\s-`] . (lambda () (interactive) (exwm-workspace-switch-create 0)))

        ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))))

(exwm-enable)

(desktop-environment-mode)

;; Automatically kill buffer after exit term
(defadvice term-handle-exit
    (after term-kill-buffer-on-exit activate)
  (kill-buffer))

(provide 'crafted-desktop)
;;; crafted-desktop.el ends here
