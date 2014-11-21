;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
(add-to-list 'load-path "~/.emacs.d")
(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'linum)
(require 'smooth-scrolling)
(require 'whitespace)
(require 'dired-x)
(require 'compile)
(ido-mode t)
(menu-bar-mode -1)
(normal-erase-is-backspace-mode 1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq save-abbrevs nil)
(setq show-trailing-whitespace t)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(column-marker-1 ((t (:background "red"))))
 '(diff-added ((t (:foreground "cyan"))))
 '(flymake-errline ((((class color) (background light)) (:background "Red"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))))
 '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
 '(linum ((t (:foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((((class color) (background light)) (:background "black"))))
 '(vertical-border ((t nil)))
)

;; ------------
;; -- Macros --
;; ------------
(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(global-set-key "\M-=" 'align-equals)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\M-n" 'next5)
(global-set-key "\M-p" 'prev5)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" 'back-window)
(global-set-key "\C-z" 'zap-to-char)
;(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'backward-delete-word)
(global-set-key "\M-u" 'zap-to-char)

;; ---------------------------
;; -- JS Mode configuration --
;; ---------------------------
(load "js-config.el")
(add-to-list 'load-path "~/.emacs.d/jade-mode") ;; github.com/brianc/jade-mode
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))



;; ------------------------------ 
;; -- my stuff: toggle comment --
;; ------------------------------
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key "\C-\\" 'toggle-comment-on-line)


;; ------------------------------ 
;; -- my stuff: never use tabs --
;; ------------------------------
;; I hate tabs!
(setq-default indent-tabs-mode nil)


;; ------------------------------ 
;; -- my stuff: show full path --
;; ------------------------------
;; show full path
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))


;; -------------------------------- 
;; -- my stuff: multiple cursors --
;; --------------------------------
(require 'multiple-cursors)

;; Then you have to set up your keybindings - multiple-cursors doesn't presume to
;; know how you'd like them laid out. Here are some examples:

;; When you have an active region that spans multiple lines, the following will
;; add a cursor to each line:

;;     (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; When you want to add multiple cursors not based on continuous lines, but based on
;; keywords in the buffer, use:

(global-set-key (kbd "M->") 'mc/mark-next-like-this)
(global-set-key (kbd "M-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "M-<") 'mc/mark-all-like-this)

;; --------------------------------
;; -- my stuff: autoload buffers --
;; --------------------------------
;; auto load all buffer in case of disk changes
;; (global-auto-revert-mode t)

(global-set-key [f5] (lambda () (interactive) (revert-buffer nil t)))


;; -----------------------
;; -- my stuff: phplint --
;; -----------------------
;; run php lint when press f8 key
;; php lint
(defun phplint-thisfile ()
(interactive)
(compile (format "php -l %s" (buffer-file-name))))
(add-hook 'php-mode-hook
'(lambda ()
(local-set-key [f8] 'phplint-thisfile)))
;; end of php lint


;; ---------------------
;; -- my stuff: theme --
;; ---------------------
;; (load-theme 'misterioso)

;; ------------------------
;; -- my stuff: add repo --
;; ------------------------
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)


(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; ---------------------------- 
;; -- my stuff: closed files --
;; ----------------------------
;; recent closed files
;; http://stackoverflow.com/questions/2227401/how-to-get-a-list-of-last-closed-files-in-emacs

(defvar closed-files (list))

(defun track-closed-file ()
  (message buffer-file-name)
  (and buffer-file-name
       (add-to-list 'closed-files buffer-file-name)))

(defun last-closed-files ()
  (interactive)
  (find-file (ido-completing-read "Last closed: " closed-files)))

(add-hook 'kill-buffer-hook 'track-closed-file)

;; -------------------------
;; -- my stuff: tree view --
;; -------------------------
(require 'tree-mode)
(require 'windata)
(require 'dirtree)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)
(global-set-key "\C-o" 'dirtree-show)


;; --------------------------------
;; -- my stuff: find in git repo --
;; --------------------------------
(global-set-key (kbd "C-x f") 'find-file-in-repository)
