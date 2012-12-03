;;
(custom-set-variables
 '(backup-inhibited t)
 '(inhibit-startup-screen t)
 '(indent-tabs-mode nil)
 '(column-number-mode t)
 '(menu-bar-mode nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil)
)

;;
(custom-set-faces
 ;;'(default ((t :family "Dina")))
 )

;; load
(load "~/.emacs.d/tomorrow-theme/tomorrow-night-theme.el")
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; key bind
(global-set-key "\C-h" 'delete-backword-char)

;; before-save-hook
(add-hook
 'before-save-hook
 '(lambda ()
    (delete-trailing-whitespace)
    ))

;; setting for mozc
(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc")
  )

(when (require 'yasnippet nil t)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/snippets")
)

;; setting for eshell
(when (require 'eshell nil t)
  (add-hook
   'eshell-mode-hook
   '(lambda ()
      (local-set-key "\C-a" 'eshell-bol)
      (local-set-key "\C-p" 'eshell-previous-matching-input-from-input)
      (local-set-key "\C-n" 'eshell-next-matching-input-from-input)
      ))
  )

;; setting for haskell
(when (require 'haskell-mode nil t)
  (add-hook
   'haskell-mode-hook
   '(lambda ()
      (haskell-indentation-mode)
      ))
  )

;; setting for markdown
(when (require 'markdown-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  )

;; setting for coffee
(when (require 'coffee-mode nil t)
  (add-hook
   'coffee-mode-hook
   '(lambda ()
      (set (make-local-variable 'tab-width) 2)
      (setq coffee-tab-width 2)
      ))
  )
