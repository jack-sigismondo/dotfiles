;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;
;; DEPENDENCIES ;;
;;;;;;;;;;;;;;;;;;
;; Iosevka
;; ripgrep
;; git


;;;;;;;;;;;;;;
;; PACKAGES ;;
;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
			 '("elpa" . "https://elpa.gnu.org/packages/"))
(package-initialize)
(package-refresh-contents)


;;;;;;;;;;;;;;;;
;; APPEARANCE ;;
;;;;;;;;;;;;;;;;
;; Prevents "customize" options from changing this file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(add-to-list 'default-frame-alist `(font . "Iosevka-14"))

(setq inhibit-splash-screen t)

;; Client decorations
(menu-bar-mode -1)
(tool-bar-mode -1)
(window-divider-mode t)
(scroll-bar-mode -1)

(visual-line-mode t)
(global-display-line-numbers-mode t)

(use-package moe-theme
  :ensure t
  :config
  (moe-light))


;;;;;;;;;;;;;;;;;
;; PROGRAMMING ;;
;;;;;;;;;;;;;;;;;
(setq compilation-ask-about-save nil)

;; Generic tags (T/ODO, H/ACK, etc.)
(use-package hl-todo
  :ensure t
  :config
  (global-hl-todo-mode t))

(use-package magit
  :ensure t
  :config
  (setq magit-status-show-untracked-files 'all))

;; Barebones integration
;; See https://emacs-lsp.github.io/lsp-mode/page/installation/ for more
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-enable-on-type-formatting nil)
  :hook ((prog-mode . lsp))
  :commands
  lsp)
(use-package lsp-ui
  :ensure t
  :commands
  lsp-ui-mode)
;; TODO debugger support?

(keymap-global-set "C-," (lambda () (interactive)
						   (duplicate-line)
						   (next-line)))

;; C
(setq c-default-style "bsd"
      c-basic-offset 4
      indent-tabs-mode nil
      tab-width 4)
;; Automatic newlines, tab insertion and hungry delete
;; TODO doesn't seem to work really
(add-hook 'cmode-common-hook #'c-toggle-auto-hungry-state)


;;;;;;;;;;;;;;;;;
;; COMPLETIONS ;;
;;;;;;;;;;;;;;;;;
(setq read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t
      bookmark-completion-ignore-case t)

;; Useful if vertico isn't available
;; (fido-vertical-mode t) 
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  ;; Default config from github
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring


(use-package consult
  :ensure t
  :bind (("M-C-s" . consult-ripgrep) ;; Overwriting isearch-forward-regexp
		 ("C-x b" . consult-buffer)
		 ("C-x 4 b" . consult-buffer-other-window)
		 ("C-x C-r" . consult-recent-file) ;; Overwriting find-file-read-only
		 ("M-y" . consult-yank-pop)))


;;;;;;;;;;;
;; DIRED ;;
;;;;;;;;;;;
;; Required for some more advanced features
(require 'dired-x)

(setq
 dired-listing-switches "-laAhF"
 dired-recursive-copies 'always
 ;; Two dired buffers in the same frame talk to each other
 dired-dwim-target t
 dired-kill-when-opening-new-dired-buffer t)


;;;;;;;;;;;
;; SAVES ;;
;;;;;;;;;;;
;; Keeps #files# and ~files~ from occupying their respective directories
(make-directory (expand-file-name "~/.emacs.d/save/" user-emacs-directory) t)
(make-directory (expand-file-name "~/.emacs.d/auto-save/" user-emacs-directory) t)
(setq
 backup-by-copying t
 backup-directory-alist `(("." . ,(expand-file-name "~/.emacs.d/save/" user-emacs-directory)))
 auto-save-list-file-prefix (expand-file-name "~/.emacs.d/auto-save/sessions/" user-emacs-directory)
 auto-save-file-name-transforms `((".*" ,(expand-file-name "~/.emacs.d/auto-save/" user-emacs-directory) t))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)


;;;;;;;;;
;; ORG ;;
;;;;;;;;;
(setq
 org-startup-with-inline-images t
 ;; org-image-actual-width 200
 org-hide-emphasis-markers t
 org-export-preserve-breaks t)

(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-agenda-files '("~/Notes/org"))
(keymap-global-set "C-c a" #'org-agenda)


;;;;;;;;;;
;; MISC ;;
;;;;;;;;;;
;; Return to a file where you left off
(save-place-mode t)

(recentf-mode t)
(setq recentf-max-saved-items 50)

;; If a file has been altered elsewhere TODO ???
(global-auto-revert-mode t)
(setq sentence-end-double-space nil)

;; I like these binding a lot for switching windows
(keymap-global-set "M-o" #'other-window)
(keymap-global-set "M-O" #'window-swap-states)

(keymap-global-set "C-c e" #'eshell)

(message "Initialized.")

;;;;;;;;;;;;;;;;;;;;;
;; CONSIDER ADDING ;;
;;;;;;;;;;;;;;;;;;;;;

;; Startup junk probably unneeded
;;
;; (setq gc-cons-threshold most-positive-fixnum)
;; (add-hook 'emacs-start-hook
;; 	  (lambda () (setq gc-cons-threshold (* 100 1024 1024))))
;; (setq max-lisp-eval-depth 999)
