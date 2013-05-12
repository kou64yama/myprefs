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
 '(backup-inhibited t t)
 '(column-number-mode t)
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(linum-number-mode t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(visible-bell nil)
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t :family "Ubuntu Mono" :height 140)))
 )

;; theme
(load-theme 'wombat t)

;; before-save-hook
(add-hook 'before-save-hook
          '(lambda ()
             "Before Save Hook"
             (delete-trailing-whitespace)
             ))

;; keybind
(define-key global-map (kbd "C-h") 'delete-backward-char)


(defun require-install (p)
  (or (require p nil t) (not (package-install p)))
  )

(when (require 'server nil t)
  (unless (server-running-p) (server-start))
  )

(when (require 'package nil t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize)
  )

(when (require-install 'popwin))

(when (require-install 'helm)
  (require 'helm-config nil t)
  ;;(define-key global-map (kbd "M-x") 'helm-M-x)
  ;;(define-key global-map (kbd "C-x C-f") 'helm-find-files)
  )

(when (require-install 'whitespace)
  (custom-set-variables
   '(global-whitespace-mode t)
   '(whitespace-style '(face tabs tab-mark spaces space-mark))
   )
  (custom-set-faces
   '(whitespace-space ((((class color) (background dark))
                        :foreground "#444"
                        :background nil
                        )))
   '(whitespace-tab ((((class color) (background dark))
                      :foreground "#444"
                      :background "#c00"
                      )))
   )
  )

(when (require-install 'auto-complete)
  (custom-set-variables '(global-auto-complete-mode t))
  )

(when (require-install 'yasnippet)
  (yas-global-mode 1)
  )

(when (require-install 'mark-multiple)
  (define-key global-map (kbd "C-<") 'mark-previous-like-this)
  (define-key global-map (kbd "C->") 'mark-next-like-this)
  (define-key global-map (kbd "C-*") 'mark-all-like-this)
  )

(when (require-install 'expand-region)
  (define-key global-map (kbd "C-@") 'er/expand-region)
  (define-key global-map (kbd "C-M-@") 'er/contract-region)
  )

(when (require-install 'coffee-mode)
  (custom-set-variables '(coffee-tab-width 2))
  )

(when (require-install 'markdown-mode)
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
  )

(require-install 'rainbow-mode)
(require-install 'apache-mode)
(require-install 'php-mode)
(require-install 'haskell-mode)
(require-install 'sass-mode)
(require-install 'scss-mode)
(require-install 'git-commit-mode)
(require-install 'gitconfig-mode)
(require-install 'magit)
