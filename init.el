;; Author: Yubing Hou
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-compute-statistics t)

;; Custom Variables
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Profile
(setq profile-file (expand-file-name "profile.el" user-emacs-directory))
(load profile-file)

;; Editor Configuration
(setq editor-file (expand-file-name "editor.el" user-emacs-directory))
(load editor-file)

;; Languages
(setq lang-dir
      (expand-file-name "./lang" user-emacs-directory))
(add-to-list 'load-path lang-dir)

;; my mostly used language modes 
(require 'go-init)

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window))

(use-package anaconda-mode
  :ensure t
  :defer t)

(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2))

(use-package bash-completion
  :ensure t)

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package company-go
  :ensure t
  :defer t)

(use-package company-php
  :after (company)
  :ensure t
  :defer t)

(use-package company-web
  :after (company)
  :ensure t
  :defer t)

(use-package docker
  :ensure t
  :defer t)

(use-package dockerfile-mode
  :after (docker)
  :ensure t)

(use-package elpy
  :after (flycheck)
  :ensure t
  :defer t
  :hook (elpy-mode . flycheck-mode))

(use-package emacsql
  :ensure t
  :defer t)

(use-package flycheck
  :ensure t
  :defer t)

(use-package goto-chg
  :ensure t)

(use-package go-projectile
  :after (projectile)
  :ensure t)

(use-package helm
  :ensure t
  :defer t)

(use-package helm-company
  :after (helm company)
  :ensure t
  :defer t)

(use-package helm-projectile
  :after (helm projectile)
  :ensure t
  :config
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

(use-package ivy
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t))

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

(use-package json-reformat
  :ensure t)

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :defer t)

(use-package lsp-mode
  :ensure t
  :defer t)

(use-package lsp-ui
  :ensure t
  :defer t)

(use-package magit
  :ensure t
  :defer t)

(use-package markdown-mode
  :ensure t
  :mode "\\.md\\'"
  :defer t)

(use-package material-theme
  :ensure t
  :init
  :config
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
  :mode "\\.org\\'"
  :defer t
  :config
  (bind-key "C-c o" 'org-mode))

(use-package php-mode
  :ensure t
  :mode "\\.php\\'"
  :defer t)

(use-package phpunit
  :ensure t
  :defer t)

(use-package prettier-js
  :ensure t
  :defer t)

(use-package projectile
  :ensure t
  :config
  (setq projectile-enable-caching t)
  (setq projectile-mode-line
	'(:eval (format " Projectile[%s]"
			(projectile-project-name))))
  :bind (:map projectile-mode-map
	      ("s-p" . projectile-command-map)
	      ("C-c p" . projectile-command-map)))

(use-package python-mode
  :ensure t
  :mode "\\.py\\'"
  :defer t)

(use-package restclient
  :ensure t
  :defer t)

(use-package smartparens
  :ensure t)

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package treemacs
  :ensure t
  :defer t
  :config
  (bind-key "C-c t" 'treemacs)
  (progn
    (setq treemacs-width 42)))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :defer t)

(use-package web-beautify
  :ensure t
  :defer t)

(use-package web-mode
  :ensure t
  :defer t)

(use-package yasnippet
  :ensure t
  :defer t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after (yasnippet)
  :ensure t
  :defer t)


