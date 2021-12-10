;; Use Emacs Native
(setq package-native-compile t)
(setenv "LIBRARY_PATH" "/usr/local/opt/gcc/lib/gcc/11:/usr/local/opt/libgccjit/lib/gcc/11:/usr/local/opt/gcc/lib/gcc/11/gcc/x86_64-apple-darwin20/11.2.0")

;; Set up packaging system
(require 'package)

;; Package Management - sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                        ("melpa-stable" . "https://stable.melpa.org/packages/")
                        ("org" . "https://orgmode.org/elpa/")
                        ("elpa" . "https://elpa.gnu.org/packages/")
			("nongnu" . "https://elpa.nongnu.org/nongnu/")))
;; [note] some packages require melpa-stable, like lsp-ui

(package-initialize) ;; initialize package list
(unless package-archive-contents ;; useful when setting up a fresh new computer
  (package-refresh-contents))

;; Use use-package for package management
(unless (package-installed-p 'use-package) ;; if use-package is not installed
  (package-refresh-contents) ;; update package list before install use-package
  (package-install 'use-package)) ;; install use-package
(require 'use-package)
(setq use-package-alaways-ensure t)

;; Garbage collection threshold
(setq gc-cons-threshold (* 2 1024 1024 1024)) ;; 2 GB, why not?
(setq read-process-output-max (* 128 1024 1024)) ;; 128 Mbit

;; my customizations
(add-to-list 'load-path "~/.emacs.d/yhmacs/")

(require 'defaults) ;; base configuration for entire Emacs
(require 'dev) ;; common configuration for all code-writing task
(require 'ui)
(require 'custom-org)
(require 'custom-docker)
(require 'lang-go)
(require 'lang-javascript)
(require 'lang-json)
(require 'lang-php)
(require 'lang-sql)
(require 'lang-typescript)
(require 'lang-yaml)

;; package management setup
;; if use-package is not installed, install use-package. Useful on non-Linux platform
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; environments
(use-package no-littering
  :ensure t)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(setq exec-path (append exec-path '("~/go/bin")))
(setq exec-path (append exec-path '("/usr/local/bin")))


;; [Editing]  Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Fonts ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (set-face-attribute 'default nil :font "JetBrains Mono" :height 100)
;; (set-face-attribute 'fixed-pitch nil :font "JetBrains Mono" :height 100)
;;(set-face-attribute 'variable-pitch nil :font "Lato" :height 100 :weight 'regular)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;; END OF ABSOLUTE ESSENTIAL CONFIGURATION ;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;; START OF SEMI-ESSENTIAL CONFIGURATION ;;;;;;;;;;;;;;;;;;;;;

;; ag - fast searching string within project (multi-threaded)
;; (use-package ag
;;   :ensure t
;;   :config
;;   (setq ag-highlight-search t))

;; (use-package company
;;   :pin melpa
;;   :ensure t)

;; (use-package counsel
;;   :ensure t)

;; (use-package ivy
;;   :pin melpa
;;   :ensure t
;;   :init (ivy-mode 1)
;;   :config
;;   (setq ivy-height 20)
;;   (setq ivy-count-format "%d%d "))

;; (use-package ivy-rich
;;   :after ivy
;;   :init
;;   (ivy-rich-mode 1))

;; (use-package lsp-mode
;;   :pin melpa
;;   :ensure t
;;   :hook (go-mode . lsp-deferred)
;;   :hook (php-mode . lsp-deferred)
;;   :config
;;   (add-to-list 'lsp-enabled-clients 'gopls)
;;   (add-to-list 'lsp-enabled-clients 'iph)
;;   :commands (lsp lsp-deferred))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; save recent files
(use-package recentf
  :ensure t
  :config
  (setq recentf-save-file
	(recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

;;;; Language specific configurations
;; Golang
