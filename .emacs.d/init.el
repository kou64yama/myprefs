;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/coffee-mode")
(load "~/.emacs.d/site-lisp/tomorrow-theme/tomorrow-night-theme.el")

;;
(custom-set-variables
 '(backup-inhibited t)
 '(inhibit-startup-screen t)
 '(indent-tabs-mode nil)
 '(column-number-mode t)
 '(menu-bar-mode nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil)
 '(visible-bell t)
 )

;;
(custom-set-faces
 '(default ((t :family "Droid Sans Mono" :height 120)))
)

;;
(global-set-key "\C-h" 'delete-backward-char)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; mozc
(when (require 'mozc nil t)
  (custom-set-variables
   '(default-input-method "japanese-mozc"))
  )

;; eshell
(when (require 'eshell nil t)
  (add-hook 'eshell-mode-hook
            '(lambda ()
               (local-set-key "\C-a" 'eshell-bol)
               (local-set-key "\C-p" 'eshell-previous-matching-input-from-input)
               (local-set-key "\C-n" 'eshell-next-matching-input-from-input)))
  )

;; twittering-mode
(when (require 'twittering-mode nil t)
  (custom-set-variables
   '(twittering-auth-method 'xauth)
   '(twittering-username "kou64yama")
   '(twittering-icon-mode t))
  )

;; haskell-mode
(when (require 'haskell-mode nil t)
  (add-hook 'haskell-mode-hook
            '(lambda ()
               (haskell-indentation-mode)))
  )

;; coffee-mode.
(when (require 'coffee-mode nil t)
  (add-hook 'coffee-mode-hook
            '(lambda ()
               (set (make-local-variable 'tab-width) 4)
               (setq coffee-tab-width 4)))
  )

;; markdown-mode.
(when (require 'markdown-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  )

(add-to-list 'auto-mode-alist '("\\.rc\\'" . shell-script-mode))
