;; Personal Info - Used by Git, Org Mode, etc
(setq user-full-name "Yubing Hou")

;; Emacs Base Confiugrations
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("gnu" . "https://elpa.gnu.org/packages/"))

;; refresh packages if missing
(when (not package-archive-contents)
  (package-refresh-contents))

;; if use-package is not installed, install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; define private and temporary files storage directories
(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories")

;; Fundamentals - Text Encoding
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Editor UI
(column-number-mode 1) ;; show current column in status bar
(set-face-attribute 'default nil ;; use jetbrains font
		    :family "JetBrains Mono"
		    :height 100)
(transient-mark-mode 1) ;; enable transient mark mode for org mode
;; show file path in frame title
(setq frame-title-format
      `((buffer-file-name "%f" "%b")
        ,(format " - 異想天開，腳踏實地")))

;; Emacs basic operations
(setq confirm-kill-emacs                     'y-or-n-p
      confirm-nonexistent-file-or-buffer     t
      save-interprogram-paste-before-kill    t
      require-final-newline                  t
      visible-bell                           t ;; turn on visual notification
      ring-bell-function                     'ignore ;; turn off sound notification
      custom-file                            "~/.emacs.d/custom.el"
      ;; additional user-installed binaries
      exec-path (append exec-path '("/usr/local/bin"))
      ;; go-specific binaries
      exec-path (append exec-path '("~/go/bin"))
      ;; hide the default start up screen
      inhibit-startup-message                t
      inhibit-startup-screen                 t
      ;; Editor Customization
      x-select-enable-clipboard              t
      indent-tabs-mode                       t
      ;; always check if packages are installed
      use-package-always-ensure t)

;; Bookmarks
(setq bookmark-save-flag t ;; persistent bookmarks
      bookmark-default-file (concat temporary-file-directory "/bookmarks"))

;; Backing up files
(setq
 history-length                     1000
 backup-inhibited                   nil
 make-backup-files                  t
 auto-save-default                  t
 auto-save-list-file-name           (concat temp-dir "/autosave")
 create-lockfiles                   nil
 backup-directory-alist            `((".*" . ,(concat temp-dir "/backup/")))
 auto-save-file-name-transforms    `((".*" ,(concat temp-dir "/auto-save-list/") t)))
(unless (file-exists-p (concat temp-dir "/auto-save-list"))
		       (make-directory (concat temp-dir "/auto-save-list") :parents))

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)

;; Disable Menu Bar
(menu-bar-mode -1)

;; Disable Tool Bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Disable Scroll Bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Show matching parenthesis
(show-paren-mode 1)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package material-theme
  :defer t
  :init
  (load-theme 'material t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Extensions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ace-window
  :config
  (global-set-key (kbd "M-o") 'ace-window))

(use-package anaconda-mode
  :defer t)

(use-package avy
  :bind
  ("C-c SPC" . avy-goto-char))

(use-package bash-completion)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'prog-mode-hook 'company-mode)
  (global-set-key (kbd "M-i") 'company-complete)
  (setq company-idle-delay 0.2)
  (global-set-key (kbd "C-<tab>") 'company-complete)
  (setq company-minimum-prefix-length 1))

(use-package company-web
  :after company
  :defer t)

(use-package counsel
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-m" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x c k" . counsel-yank-pop))

(use-package counsel-projectile
  :bind
  ("C-x v" . counsel-projectile)
  ("C-x c p" . counsel-projectile-ag)
  :config
  (counsel-projectile-on))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package docker
  :defer t)

(use-package dockerfile-mode
  :after docker)

(use-package dumb-jump
  :config
  (dumb-jump-mode))

(use-package elpy
  :ensure t
  :defer t
  :init
  :after (flycheck)
  :config
  (setq elpy-rpc-python-command "python3")
  :hook (elpy-mode . flycheck-mode))

(use-package emacsql)

;; ensure that environment variables in Emacs is the same as shell
(use-package exec-path-from-shell
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))

(use-package flycheck)

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :config
  (add-hook 'go-mode-hook 'gofmt-before-save))

(use-package go-projectile
  :ensure t)

(use-package goto-chg)

;; highlight current line number
(use-package hlinum
  :config
  (hlinum-activate))

;; ivy mode
(use-package ivy
  :init (ivy-mode 1) ;; globally
  :bind
  ("C-x s" . swiper)
  ("C-x C-r" . ivy-resume)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 20)
  (setq ivy-count-format "%d/%d ")
  (setq enable-recursive-minibuffers t))

(use-package json-mode
  :mode "\\.json\\'")

(use-package json-reformat)

(use-package js2-mode
  :mode "\\.js\\'"
  :defer t
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode))

;; line number utility
(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode t))

(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-prefer-flymake nil)
  :hook (go-mode . lsp-deferred)
  :hook (php-mode . lsp)
  :commands (lsp lsp-deferred))

(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mod . (lambda()
			(require 'lsp-python-ms)
			(lsp))))

(use-package lsp-ui
  :defer t
  :requires (lsp-mode flycheck)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
	lsp-ui-doc-use-childframe t
	lsp-ui-doc-position ‘top
	lsp-ui-doc-include-signature t
	lsp-ui-sideline-enable nil
	lsp-ui-flycheck-enable t
	lsp-ui-flycheck-list-position ‘right
	lsp-ui-flycheck-live-reporting t
	lsp-ui-peek-enable t
	lsp-ui-peek-list-width 60
	lsp-ui-peek-peek-height 25
	lsp-ui-sideline-enable nil)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package magit
  :config
  (setq magit-completing-read-function 'ivy-completing-read)
  :bind
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

(use-package magit-popup)


(use-package markdown-mode
  :mode "\\.md\\'")

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this))

(use-package multi-term
  :config
  (setq multi-term-program "/bin/bash")
  (bind-key "C-c m t" 'multi-term))

(use-package origami)

(use-package org
  :config
  (setq org-directory "~/org"
	org-default-notes-file (concat org-directory "/todo.org"))
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda))

;; Show bullets in org-mode as UTF-8 characters
(use-package org-bullets
  :config
  (setq org-hide-leading-stars t)
  (add-hook 'org-mode-hook
            (lambda ()
              (org-bullets-mode t))))

(use-package org-projectile
  :config
  (org-projectile-per-project)
  (setq org-projectile-per-project-filepath "todo.org"
	org-agenda-files (append org-agenda-files (org-projectile-todo-files))))

(use-package page-break-lines)

(use-package prettier-js)

(use-package projectile
  :config
  (setq projectile-known-projects-file
	(expand-file-name "projectile-bookmarks.eld" temp-dir))
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  (projectile-global-mode)
  (setq projectile-mode-line
	'(:eval (format " Projectile[%s]"
			(projectile-project-name)))))

(use-package python
  :mode ("\\.py" . python-mode)
  :config
  (use-package elpy
    :init
    (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
    :config
    (setq elpy-rpc-backend "jedi")
    :bind (:map elpy-mode-map
		("M-." . elpy-goto-definition)
		("M-," . pop-tag-mark)))
  (elpy-enable))


;; save recent files
(use-package recentf
  :config
  (setq recentf-save-file
	(recentf-expand-file-name"~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

(use-package smartparens
  :config
  (setq smartparens-strict-mode t))

(use-package smex)

(use-package treemacs
  :init
  :config
  (bind-key "C-c t" 'treemacs))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'")

(use-package web-beautify
  :ensure t)

(use-package web-mode
  :ensure t
  :mode ( "\\.ts\\'")
  :config
  (add-hook 'web-mode-hook 'prettier-js-mode))

;; show key bindings in popup
(use-package which-key
  :config
  (which-key-mode))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after (yasnippet)
  :defer t)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
