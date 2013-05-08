;; -*- mode: emacs-lisp; indent-tabs-mode: nil; -*-

;; Copyright (c) 2013 YAMADA Koji
;;
;; Permission  is  hereby  granted,  free of  charge,  to  any  person
;; obtaining  a copy  of  this software  and associated  documentation
;; files   (the  "Software"),   to  deal   in  the   Software  without
;; restriction, including without limitation  the rights to use, copy,
;; modify, merge, publish, distribute,  sublicense, and/or sell copies
;; of the  Software, and  to permit  persons to  whom the  Software is
;; furnished to do so, subject to the following conditions:
;;
;; The  above copyright  notice and  this permission  notice shall  be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE  IS PROVIDED  "AS IS", WITHOUT  WARRANTY OF  ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT  NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY,   FITNESS    FOR   A   PARTICULAR    PURPOSE   AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES  OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT,  TORT OR OTHERWISE, ARISING FROM, OUT  OF OR IN
;; CONNECTION WITH  THE SOFTWARE OR THE  USE OR OTHER DEALINGS  IN THE
;; SOFTWARE.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-linum-mode t)
 '(linum-number-mode t)
 '(column-number-mode t)
 '(size-indication-mode t)
 '(menu-bar-mode nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil)
 '(indent-tabs-mode nil)
 '(visible-bell nil)
 '(backup-inhibited t)
 '(inhibit-startup-screen t)
)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t :family "Droid Sans Mono Slashed" :height 120)))
 )

;; theme
(load-theme 'tango-dark t)

;; before-save-hook
(add-hook 'before-save-hook
          '(lambda ()
             "Before Save Hook"
             (delete-trailing-whitespace)
             ))

;; keybind
(define-key global-map (kbd "C-h") 'delete-backward-char)

;; package
(when (require 'package nil t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)
)

(when (require 'whitespace nil t)
  (custom-set-variables
   '(global-whitespace-mode t)
   '(whitespace-style '(face tabs tab-mark spaces space-mark))
   )
)


;; anything
;;
;; (package-install 'anything)
;; (package-install 'anything-config)
;; (package-install 'anything-match-plugin)
;; (package-install 'anything-complete)
(when (require 'anything nil t)
  (require 'anything-config nil t)
  (require 'anything-startup nil t)
  (anything-read-string-mode 1)
  )

;; auto-complete
;;
;; (package-install 'auto-complete)
(when (require 'auto-complete nil t)
  (custom-set-variables '(global-auto-complete-mode t))
  )

;; yasnippet
;;
;; (package-install 'yasnippet)
;; (package-install 'yasnippet-bundle)
(when (require 'yasnippet-config nil t)
  (yas-global-mode 1)
  )

;; screenshot
;;
;; (package-install 'screenshot)
(when (require 'screenshot nil t)
  (custom-set-variables
   '(screenshot-schemes '("local" :dir "~/"))
   '(screenshot-default-scheme "local"))
  )

;; (package-install 'rainbow-mode)
;; (package-install 'php-mode)
;; (package-install 'haskell-mode)
;; (package-install 'coffee-mode)
;; (package-install 'sass-mode)
;; (package-install 'scss-mode)
;; (package-install 'less-css-mode)
