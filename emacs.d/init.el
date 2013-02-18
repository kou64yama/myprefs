;; ~/.emacs.d/init.el  -*- emacs-lisp -*-
;;
;; Copyright (c) 2013 Koji Yamada
;;
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

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
 '(default ((t :foreground "White" :background "Black")))
 )

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
