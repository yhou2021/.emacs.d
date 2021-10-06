;; Author: Yubing Hou
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Personal Info
(setq user-mail-address "houyubing24@gmail.com")
(setq user-full-name "Yubing Hou")

;; UI & Editor
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; maximize window on start up
(setq inhibit-startup-screen t);; hide the start up screen
(menu-bar-mode 0) ;; disable menu bar
(tool-bar-mode -1) ;; disable toolbar
(toggle-scroll-bar -1) ;; disable scroll bar
(transient-mark-mode 1) ;; enabled for org mode
(setq frame-title-format ;; change window title
      '(buffer-file-name "%f"
			 (dired-directory dired-directory "%b")))

;; Editor
(setq line-number-mode t) ;; show line number
(column-number-mode 1) ;; show current column in status bar
(global-hl-line-mode 1) ;; highlight current line
(global-visual-line-mode 1) ;; enable line wrap
;; (global-whitespace-mode 1) ;; enable whitespace handling by default
(show-paren-mode 1) ;; highlight matched parenthesis
(setq show-paren-delay 0)
(set-face-attribute 'default nil ;; use jetbrains font
		    :family "JetBrains Mono"
		    :height 100
		    :weight 'normal
		    :width 'normal)
(setq visible-bell t) ;; turn on visual notification
(setq ring-bell-function 'ignore) ;; turn off sound notification
;; always show line number
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
;; see the apropos entry for whitespace-style
;; (setq
;;    whitespace-style
;;    '(face ; viz via faces
;;      trailing ; trailing blanks visualized
;;      lines-tail ; lines beyond  whitespace-line-column
;;      space-before-tab
;;      space-after-tab
;;      newline ; lines with only blanks
;;      indentation ; spaces used for indent when config wants tabs
;;      empty ; empty lines at beginning or end
;;      )
;;    whitespace-line-column 120 ; column at which whitespace-mode says the line is too long
;;    )

(use-package ace-window
  :ensure t
  :init
  :config
  (global-set-key (kbd "M-o") 'ace-window))

(use-package anaconda-mode
  :ensure t)

(use-package avy
  :ensure t
  :init
  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2))

(use-package bash-completion
  :ensure t)

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package company-go
  :ensure t)

(use-package company-php
  :after (company)
  :ensure t)

(use-package company-web
  :after (company)
  :ensure t)

(use-package docker
  :ensure t)

(use-package dockerfile-mode
  :after (docker)
  :ensure t)

(use-package elpy
  :after (flycheck)
  :ensure t
  :init
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(use-package emacsql
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package git-commit
  :ensure t)

(use-package goto-chg
  :ensure t)

(use-package go-mode
  :ensure t
  :init
  :config
  (add-hook 'go-mode-hook 'lsp-deferred)
  (add-to-list 'exec-path "$HOME/go/bin")
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package go-projectile
  :after (projectile)
  :ensure t
  :init)

(use-package helm
  :ensure t
  :init)

(use-package helm-company
  :after (helm company)
  :ensure t)

(use-package helm-projectile
  :after (helm projectile)
  :ensure t
  :init
  :config
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

(use-package ivy
  :ensure t
  :init
  :config
  (setq ivy-use-virtual-buffers t))

(use-package json-mode
  :ensure t)

(use-package json-reformat
  :ensure t)

(use-package js2-mode
  :ensure t)

(use-package lsp-mode
  :ensure t)

(use-package lsp-ui
  :ensure t)

(use-package magit
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package material-theme
  :ensure t
  :init
  (load-theme 'material t))

(use-package multi-term
  :ensure t
  :config
  (setq multi-term-program "/bin/bash")
  (bind-key "C-c m t" 'multi-term))

(use-package origami
  :ensure t)

(use-package org
  :ensure t
  :init
  (bind-key "C-c o" 'org-mode))

(use-package php-mode
  :ensure t)

(use-package phpunit
  :ensure t)

(use-package prettier-js
  :ensure t)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :config
  (setq projectile-enable-caching t)
  (setq projectile-mode-line
	'(:eval (format " Projectile[%s]"
			(projectile-project-name))))
  :bind (:map projectile-mode-map
	      ("s-p" . projectile-command-map)
	      ("C-c p" . projectile-command-map)))

(use-package python-mode
  :ensure t)

(use-package restclient
  :ensure t)

(use-package smartparens
  :ensure t)

(use-package tide
  :ensure t
  :init
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (bind-key "C-c t" 'treemacs)
  :config
  (progn
    (setq treemacs-width 42)))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t
  :init)

(use-package typescript-mode
  :ensure t
  :init)

(use-package web-beautify
  :ensure t)

(use-package web-mode
  :ensure t)

(use-package yasnippet
  :ensure t
  :init
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after (yasnippet)
  :ensure t
  :init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(restclient material-theme origami smartparens yasnippet-snippets web-mode web-beautify use-package treemacs-projectile treemacs-magit tide python-mode python prettier-js phpunit org multi-term lsp-ui js2-mode ivy helm-projectile helm-company go-projectile emacsql dockerfile-mode docker company-web company-php company-go bash-completion atom-one-dark-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
