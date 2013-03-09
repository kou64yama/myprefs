;; Copyright (c) 2013 YAMADA Koji; Licensed MIT.

(require 'cl)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum-number-mode t)
 '(column-number-mode t)
 '(tool-bar-mode nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(visible-bell t)
 '(inhibit-startup-screen t)
 '(backup-inhibited t)
 '(indent-tabs-mode nil)
 '(size-indication-mode t)
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t :family "Droid Sans Mono Slashed" :height 120)))
 )

(defun* my-color-theme (&key (black "black") (red "red")
                             (green "green") (yellow "yellow")
                             (blue "blue") (magenta "magenta")
                             (cyan "cyan") (white "white"))
  (set-face-background 'default black)
  (set-face-foreground 'default white)
  (set-face-foreground 'font-lock-warning-face red)
  (set-face-foreground 'font-lock-function-name-face blue)
  (set-face-foreground 'font-lock-variable-name-face cyan)
  (set-face-foreground 'font-lock-keyword-face magenta)
  (set-face-foreground 'font-lock-comment-face yellow)
  (set-face-foreground 'font-lock-comment-delimiter-face yellow)
  (set-face-foreground 'font-lock-type-face green)
  (set-face-foreground 'font-lock-constant-face blue)
  (set-face-foreground 'font-lock-builtin-face magenta)
  (set-face-foreground 'font-lock-preprocessor-face blue)
  (set-face-foreground 'font-lock-string-face red)
  (set-face-foreground 'font-lock-doc-face yellow)
  (set-face-attribute 'font-lock-warning-face nil :underline t)
  (set-face-attribute 'font-lock-keyword-face nil :bold t)
  (set-face-attribute 'font-lock-comment-face nil :italic t)
  (set-face-attribute 'font-lock-comment-delimiter-face nil :italic t)
  (set-face-attribute 'font-lock-type-face nil :bold t)
  (set-face-attribute 'font-lock-constant-face nil :italic t :bold t)
  (set-face-attribute 'font-lock-builtin-face nil :bold t)
  (set-face-attribute 'font-lock-preprocessor-face nil :bold t)
  (set-face-attribute 'font-lock-doc-face nil :bold t)
  )

(if (not window-system) (my-color-theme)
  (my-color-theme :black "#222222" :red "#cc6666"
                  :green "#66cc66" :yellow "#cccc66"
                  :blue "#6666cc" :magenta "#cc66cc"
                  :cyan "#66cccc" :white "#cccccc"))

(global-set-key "\C-h" 'delete-backward-char)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(when (require 'eshell nil t)
  ;; Setup for eshell.
  (add-hook 'eshell-mode-hook
            '(lambda ()
               (local-set-key "\C-a" 'eshell-bol)
               (local-set-key "\C-p" 'eshell-previous-matching-input-from-input)
               (local-set-key "\C-n" 'eshell-next-matching-input-from-input)
               ))
  )

(when (require 'mozc nil t)
  ;; Setup for mozc.
  (custom-set-variables
   '(default-input-method "japanese-mozc"))
  )

(when (require 'haskell-mode nil t)
  ;; Setup for haskell-mode.
  (add-hook 'haskell-mode-hook
            '(lambda () (haskell-indentation-mode)))
  )

(when (require 'markdown-mode nil t)
  ;; Setup for markdown-mode.
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  )
