;;
(custom-set-variables
 '(backup-inhibited t)
 '(inhibit-startup-screen t)
 '(indent-tabs-mode nil)
 '(column-number-mode t)
 '(menu-bar-mode nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil)
 '(comment-auto-fill-only-comments t)
)

;;
(custom-set-faces
 '(default ((t :family "Droid Sans Mono Slashed")))
 )

;; load
(load "~/.emacs.d/tomorrow-theme/tomorrow-night-theme.el")
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; key bind
(global-set-key "\C-h" 'delete-backward-char)

;; before-save-hook
(add-hook
 'before-save-hook
 '(lambda ()
    (delete-trailing-whitespace)
    ))

;; setting for auto-install
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/site-lisp")
  ;; (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
)

;; setting for mozc
(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc")
  )

;;
(when (require 'anything nil t)
)

;; yasnippet
(when (require 'yasnippet nil t)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/snippets")
)

;; for auto-complete
(when (require 'auto-complete nil t)
  (setq ac-auto-start 1)
  (global-auto-complete-mode)
  (add-to-list 'ac-modes 'coffee-mode)
  ;; (define-key ac-mode-map (kbd "M-/") 'auto-complete)
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

;; setting for scss
(when (require 'scss-mode nil t)
  ;; (setq scss-compile-at-save nil)
)
