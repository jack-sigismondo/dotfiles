;; Init  -*- lexical-binding: t; -*-
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Startup
;;
;; (setq gc-cons-threshold most-positive-fixnum)
;; (add-hook 'emacs-start-hook
;; 	  (lambda () (setq gc-cons-threshold (* 100 1024 1024))))
;; (setq max-lisp-eval-depth 999)


;; Variables/Misc
;;



(save-place-mode t)
(fido-vertical-mode t)
(global-auto-revert-mode t)

(menu-bar-mode -1)
(window-divider-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq sentence-end-double-space nil
      display-buffer-base-action '((display-buffer-reuse-window ; C-x 4 etc
				    display-buffer-use-some-window))
      ;; mac-option-modifier 'meta
      read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t
      bookmark-completion-ignore-case t
      compilation-ask-about-save nil)

;; Recentf
(recentf-mode t)
(setq recentf-max-saved-items 50)
(add-to-list 'recentf-exclude
	     (recentf-expand-file-name "~/Notes/*"))

;; Repeat Mode
(repeat-mode t)
(put 'other-window 'repeat-map nil)
(put 'other-window-backward 'repeat-map nil)


;; Programming 
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(global-visual-line-mode t)

(setq c-default-style "stroustrup")

(add-hook 'eshell-mode-hook
	  (lambda () (setenv "TERM" "xterm-256color")))

(with-eval-after-load 'files ; Ignore Mac OS files
  (add-to-list 'completion-ignored-extensions ".DS_Store")
  (add-to-list 'completion-ignored-extensions "/\\._"))
  ;; (add-to-list 'completion-ignored-extensions ".pch")


;; Dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\.DS_Store$\\|^\\._"))
(add-hook 'dired-mode-hook #'dired-omit-mode)

(setq
 dired-listing-switches "-lahF"
 dired-recursive-copies 'always
 dired-dwim-target t
 dired-kill-when-opening-new-dired-buffer t)

;; Saves
(make-directory (expand-file-name "~/.config/emacs/saves/" user-emacs-directory) t)
(make-directory (expand-file-name "~/.config/emacs/auto-saves/" user-emacs-directory) t)
(setq
 backup-by-copying t
 backup-directory-alist `(("." . ,(expand-file-name "~/.config/emacs/saves" user-emacs-directory)))
 auto-save-list-file-prefix (expand-file-name "~/.config/emacs/auto-saves/sessions" user-emacs-directory)
 auto-save-file-name-transforms `((".*" ,(expand-file-name "~/.config/emacs/auto-saves/" user-emacs-directory) t))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

;; Org-mode
(setq
 org-startup-with-inline-images t
 org-image-actual-width 200
 org-hide-emphasis-markers t
 org-indent-mode t)


;; Binds
(keymap-global-set "<wheel-down>" #'next-line)
(keymap-global-set "<wheel-up>" #'previous-line)

(keymap-global-set "C-c e" #'eshell)
(keymap-global-set "M-o" #'other-window)
(keymap-global-set "M-o" #'window-swap-states)
(keymap-global-set "<f8>" #'global-font-lock-mode)
(keymap-global-set "C-c i" (lambda () (interactive)
			     (find-file (expand-file-name "~/.config/emacs/init.el"))))


;; Packages
(require 'package)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(use-package kkp
  :ensure t
  :hook (tty-setup . global-kkp-mode)
  :config
  ;; NOTE C-g blocking ??? 
  ;; NOTE (setq kpp-restore-legacy-keys-around-subprocesses t) ???
  )

(use-package hl-todo
  :ensure t
  :config
  (global-hl-todo-mode t))

(use-package magit
  :ensure t
  :config
  (setq magit-status-show-untracked-files 'all))

;; TODO Flycheck?

;; TODO lsp-mode/and the like

;; Vertico, orderless, consult, corfu, marginalia, embark,

(use-package consult
  :ensure t
  :bind (("M-C-s" . consult-ripgrep)
	 ("M-C-r" . consult-line-multi)
	 ("C-x b" . consult-buffer)
	 ("C-x 4 b" . consult-buffer-other-window)
	 ("C-x C-r" . consult-recent-file)
	 ("M-y" . consult-yank-pop)))


(use-package consult-org-roam
  :ensure t)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (expand-file-name "~/Notes/org-roam/"))

  :config
  (defun my/org-toggle-emphasis ()
    "Hide **, ~~, // etc or show them if already seen."
    (interactive)
    (if org-hide-emphasis-markers
        (setq org-hide-emphasis-markers nil)
      (setq org-hide-emphasis-markers t))
    (org-mode-restart))
    
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode 1)

  ;; If using org-roam-protocol
  (require 'org-roam-protocol)

  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n g" . org-roam-graph)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n c" . org-roam-capture)
	 ("C-c n j" . org-roam-dailies-capture-today)
	 ("C-c n e" . my/org-toggle-emphasis)
	 ("C-c n s" . consult-org-roam-search)))




;;; Start:
;; (add-to-list 'default-frame-alist '(width . 120))
;; (add-to-list 'default-frame-alist '(height . 60))
(defun my/start-screen ()
  "Custom Emacs splash screen with rotating ASCI art."
  
  (let ((start (get-buffer-create "*Welcome*")))
    (with-current-buffer start
      (erase-buffer)
      (let* ((file-idx 0)
	     (art-dir (expand-file-name "~/.config/emacs/start-art/"))
	     (art-list (directory-files art-dir)))

	(while (< file-idx 2)
	  (setq file-idx
		(random (length art-list))))

	(insert-file-contents
	 (expand-file-name
	  (concat art-dir
		  (nth file-idx art-list)))))
	  


      ;; (face-remap-add-relative 'default :family "monospace" :height 150)
      (goto-char (point-min))
      ;; (insert-button "Open init.el"
               ;; 'action (lambda (_) (find-file user-init-file)))
    start)))


(if (file-directory-p (expand-file-name "~/.config/emacs/start-art/"))
      (setq initial-buffer-choice #'my/start-screen)
    (message "Missing start-art in .config/emacs"))


(message "Initialized.")
;; End of init

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(deeper-blue))
 '(package-selected-packages nil))
  
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
