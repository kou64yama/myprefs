;; (let* ((dir "~/.emacs.d/init.d")
;;        (el-suffix "\\.el\\'")
;;        (files (mapcar (lambda (path) (replace-regexp-in-string el-suffix "" path))
;;                       (directory-files dir t el-suffix))))
;;   (while files (load (car files)) (setq files (cdr files))))

;;
;; variables.
;;

(custom-set-variables
 '(visible-bell t)
 '(c-basic-offset 4)
 '(backup-inhibited t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(column-number-mode t)
 '(menu-bar-mode nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil)
 '(scroll-margin 0)
 '(scroll-step 1))

;;
;; faces.
;;

(cond
 ((not window-system)
  (custom-set-faces
   '(default ((t :foreground "white" :background "black")))
   '(fringe ((t :background "black")))
   '(minibuffer-prompt ((t :foreground "blue")))
   '(mode-line ((t :foreground "white" :background "blue")))
   '(mode-line-inactive ((t :foreground "black" :background "white")))
   '(mode-line-highlight ((t :foreground "white" :background "black" :bold t)))
   '(font-lock-preprocessor-face ((t :foreground "magenta")))
   '(font-lock-variable-name-face ((t :foreground "cyan")))
   '(font-lock-string-face ((t :foreground "red")))
   '(font-lock-type-face ((t :foreground "green")))
   '(font-lock-function-name-face ((t :foreground "white")))
   '(font-lock-keyword-face ((t :foreground "yellow")))
   '(font-lock-comment-face ((t :foreground "blue")))
   '(font-lock-comment-delimiter-face ((t :foreground "blue")))
   '(font-lock-doc-face ((t :foreground "blue")))
   '(font-lock-constant-face ((t :foreground "magenta")))
   '(font-lock-builtin-face ((t :foreground "magenta")))
   '(font-lock-warning ((t :foreground "red" :underline t)))
   '(eshell-prompt ((t :foreground "blue")))
   '(eshell-ls-directory ((t :foreground "blue" :bold t)))
   '(eshell-ls-archive ((t :foreground "red")))
   '(eshell-ls-symlink ((t :foreground "cyan")))
   '(eshell-prompt ((t :foreground "blue" :bold t)))
   '(eshell-ls-readonly ((t :underline t)))
   '(eshell-ls-unreadable ((t :underline t)))
   '(eshell-ls-directory ((t :foreground "blue" :bold t)))
   '(eshell-ls-executable ((t :foreground "green" :bold t)))
   '(eshell-ls-symlink ((t :foreground "cyan")))
   '(eshell-ls-special ((t :foreground "red" :bold t)))
   '(eshell-ls-archive ((t :foreground "red")))
   '(eshell-ls-product ((t :foreground "yellow")))
   '(eshell-ls-clutter ((t :foreground "yellow" :bold t)))
   '(eshell-ls-missing ((t :foreground "red" :bold t)))
   ))
 ((window-system)
  (custom-set-faces
   '(default ((t :foreground "#cfcfcf" :background "#303030" :family "Inconsolata" :height 140)))
   '(cursor ((t :foreground "#303030" :background "#cfcfcf")))
   '(fringe ((t :background "#303030")))
   '(minibuffer-prompt ((t :foreground "#6095c5")))
   '(mode-line ((t :foreground "#cfcfcf" :background "#6095c5")))
   '(mode-line-inactive ((t :foreground "#303030" :background "#cfcfcf")))
   '(mode-line-highlight ((t :foreground "#ffffff" :background "#303030" :bold t)))
   '(font-lock-preprocessor-face ((t :foreground "#ac7bde")))
   '(font-lock-variable-name-face ((t :foreground "#3ba275")))
   '(font-lock-string-face ((t :foreground "#d370a3")))
   '(font-lock-type-face ((t :foreground "#6d9e3f")))
   '(font-lock-function-name-face ((t :foreground "#cfcfcf")))
   '(font-lock-keyword-face ((t :foreground "#b58858")))
   '(font-lock-comment-face ((t :foreground "#6095c5")))
   '(font-lock-comment-delimiter-face ((t :foreground "#6095c5")))
   '(font-lock-doc-face ((t :foreground "#6095c5")))
   '(font-lock-constant-face ((t :foreground "#ac7bde" :bold t)))
   '(font-lock-builtin-face ((t :foreground "#ac7bde")))
   '(font-lock-warning ((t :foreground "#d370a3" :underline t)))
   '(eshell-prompt ((t :foreground "#6095c5")))
   '(eshell-ls-directory ((t :foreground "#98cbfe" :bold t)))
   '(eshell-ls-executable ((t :foreground "#a3d572" :bold t)))
   '(eshell-ls-symlink ((t :foreground "#3ba275")))
   '(eshell-ls-archive ((t :foreground "#d370a3" :bold t)))
   '(eshell-ls-product ((t :foreground "#6d9e3f")))
   '(eshell-ls-clutter ((t :foreground "#efbd8b" :bold t)))
   '(eshell-ls-missing ((t :foreground "#ffa7da" :bold t))))
  (set-fontset-font (frame-parameter nil 'font) 'japanese-jisx0208 '("Ricty" . "unicode-bmp"))))

;;
;; global key settings.
;;

(global-set-key "\C-h" 'delete-backward-char)

;;
;; add-hook
;;

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;
;; mozc settings.
;;

(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc"))

;;
;; auto-complete-mode settings.
;;

;; (when (require 'auto-complete nil t)
;;   (add-to-list 'ac-modes 'emacs-lisp)
;;   (add-to-list 'ac-modes 'c-mode)
;;   (add-to-list 'ac-modes 'c++-mode)
;;   (add-to-list 'ac-modes 'java-mode)
;;   (add-to-list 'ac-modes 'javascript-mode)
;;   (add-to-list 'ac-modes 'haskell-mode)
;;   (add-to-list 'ac-modes 'coffee-mode)
;;   (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
;;   (global-auto-complete-mode t))

;;
;; coffee-mode settings.
;;

(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(when (require 'coffee-mode nil t)
  (defun coffee-custom ()
    "coffee-mode-hook"
    (set (make-local-variable 'tab-width) 4)
    (setq coffee-tab-width 4))
  (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
  (add-hook 'coffee-mode-hook '(lambda () (coffee-custom))))

;;
;; eshell-mode settings.
;;

(add-hook 'eshell-mode-hook
          '(lambda ()
             (local-set-key "\C-a" 'eshell-bol)
             (local-set-key "\C-p" 'eshell-previous-matching-input-from-input)
             (local-set-key "\C-n" 'eshell-next-matching-input-from-input)))

;;
;; haskell-mode settings.
;;

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;;
;; twittering-mode settings.
;;

(add-to-list 'load-path "~/.emacs.d/vendor/twittering-mode")
(when (require 'twittering-mode nil t)
  (setq twittering-auth-method 'xauth)
  (setq twittering-username "kou64yama")
  (setq twittering-icon-mode t)
  )

;;
;; CEDET
;;
(setq semantic-default-submodes
      '(global-semantic-idle-scheduler-mode
        global-semantic-idle-completions-mode
        global-semanticdb-minor-mode
        global-semantic-decoration-mode
        global-semantic-highlight-func-mode
        global-semantic-stickyfunc-mode
        global-semantic-mru-bookmark-mode
        ))

;;
;; JDEE
;;

(setq jde-jdk-registry '(("1.7" . "/usr/lib/jvm/icedtea-7/")))
(setq jde-jdk '("1.7"))
