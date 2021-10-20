;; Personal Info - Used by Git, Org Mode, etc
(setq user-full-name "Yubing Hou")

;; Load customizations
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

;; base configurations
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("gnu" . "https://elpa.gnu.org/packages/"))

;; refresh packages if missing
(unless package-archive-contents
  (package-refresh-contents))

;; package management setup
;; if use-package is not installed, install use-package. Useful on non-Linux platform
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; define private and temporary files storage directories
(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories")

;; Fundamentals - Text Encoding
(set-charset-priority        'unicode)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system        'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Garbage collection threshold
(setq gc-cons-threshold (* 512 1000 1000)) ;; 512 MB, why not?
(setq read-process-output-max (* 4096 1024)) ;; 4 Mbit

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

;; Base UI
;; Maximize frame on every start up
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; Disable Menu Bar
(menu-bar-mode -1)

;; Disable Tool Bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Disable Scroll Bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Update frindge, have some extra space
(set-fringe-mode 10)

;; Show matching parenthesis
(show-paren-mode 1)

;; [Editing] Tab width
(setq-default tab-width 4)

;; [Editing] use space instead of tabs
(setq-default indent-tabs-mode nil)

;; [Editing]  Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; load custom file here
(load custom-file)

;; Theme configurations
(use-package dracula-theme
  :defer t
  :init
  (load-theme 'dracula t))


;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package ac-php
  :ensure t
  :config
  (add-hook 'php-mode-hook
          '(lambda ()
             ;; Enable auto-complete-mode
             (auto-complete-mode t)

             (require 'ac-php)
             (setq ac-sources '(ac-source-php))

             ;; As an example (optional)
             (yas-global-mode 1)

             ;; Enable ElDoc support (optional)
             (ac-php-core-eldoc-setup)

             ;; Jump to definition (optional)
             (define-key php-mode-map (kbd "M-]")
               'ac-php-find-symbol-at-point)

             ;; Return back (optional)
             (define-key php-mode-map (kbd "M-[")
               'ac-php-location-stack-back))))


;; ace-window: makes window switching easy
(use-package ace-window
  :config
  (global-set-key (kbd "M-o") 'ace-window))

;; ag - fast searching string within project (multi-threaded)
(use-package ag
  :ensure t
  :config
  (setq ag-highlight-search t))

;; additional icons
(use-package all-the-icons)

;; automatic update packages
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))


;; avy - jumpoing to an arbitrary position quickly
(use-package avy
  :bind
  ("C-c SPC" . avy-goto-char))

;; company - string completion (COMPlete ANYthing)
(use-package company
  :ensure t
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'prog-mode-hook 'company-mode)
  (global-set-key (kbd "M-i") 'company-complete)
  (setq company-idle-delay 0.0)
  (global-set-key (kbd "C-<tab>") 'company-complete)
  (setq company-minimum-prefix-length 1)) ;; do not hint until 1 characters

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package company-php
  :ensure t)

;; PHPactor LSP configuration
(use-package company-phpactor
  :ensure t)

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
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-set-footer nil)
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-startup-banner "~/.emacs.d/assets/chillhop-airplane-mode.gif")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title ""))

;; Mode-line for Doom, but works without Doom. Make modeline cleaner
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package elpy
  :ensure t
  :init
  :after (flycheck)
  :config
  (setq elpy-rpc-python-command "python3")
  :hook (elpy-mode . flycheck-mode))

;; ensure that environment variables in Emacs is the same as shell
(use-package exec-path-from-shell
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))

(use-package flycheck)

;; go-mode related hooks
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :hook (go-mode-hook . gofmt-before-save)) ;; Golang LSP server

(use-package go-projectile
  :ensure t)

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

;; line number utility
(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode t))


;; LSP mode set up. Do no add language dependency here. Instead, configure each
;; language in its own package `lang-<name>.el`
(use-package lsp-mode
  :pin melpa
  :ensure t
  :hook (go-mode . lsp-deferred)
  :hook (php-mode . lsp-deferred)
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-idle-delay 0.382)
  (setq lsp-log-io t) ;; for troubleshooting purpose only
  (lsp-enable-which-key-integration t)
  (add-to-list 'lsp-enabled-clients 'gopls)
  (add-to-list 'lsp-enabled-clients 'php-ls)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :commands (lsp lsp-deferred))

;; Provide quick symbol searching
(use-package lsp-ivy)

(use-package lsp-pyright
  :ensure t
  :config
  (add-to-list 'lsp-enabled-clients 'pyright)
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

;; Provide better ui with lsp-mode and treemacs
(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ui
  :requires (lsp-mode flycheck)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
	lsp-ui-doc-use-childframe t
	lsp-ui-doc-position 'top
	lsp-ui-doc-include-signature t
	lsp-ui-sideline-enable nil
	lsp-ui-flycheck-enable t
	lsp-ui-flycheck-list-position 'right
	lsp-ui-flycheck-live-reporting t
	lsp-ui-peek-enable t
	lsp-ui-peek-list-width 60
	lsp-ui-peek-peek-height 25
	lsp-ui-sideline-enable nil
    lsp-ui-sideline-show-hover nil)
  :hook (lsp-mode-hook . lsp-ui-mode))

;; magit - magic Git
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

;; origami - flexible text folding
(use-package origami)

;; Org mode
(use-package org
  :config
  (setq org-directory "~/org"
 	    org-default-notes-file (concat org-directory "/todo.org"))
  (setq org-agenda-files
        '("~/org/Tasks.org"))
  (setq global-linum-mode nil)
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda))

(with-eval-after-load 'org
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))


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

;; some configurations are disabled for now, but should be revisted someday in the future.
;; Known LSP that works: phpactor,
(use-package php-mode
  :ensure t
  :mode "\\.php\\'"
  :config
  (add-hook 'php-mode-hook
            '(lambda()
               (require 'company-php)
               (company-mode t)
               (lsp-mode t)
               (add-to-list 'company-backends 'company-ac-php-backend)))

  ;; Configuration - Intelephense
  (add-to-list 'lsp-enabled-clients 'iph))
;; eldoc integration
;; (add-hook 'php-mode-hook
;;           (lambda ()
;;             (make-local-variable 'eldoc-documentation-function)
;;             (setq eldoc-documentation-function
;;                   'phpactor-hover)))
;; Smartjump (go to definition
(with-eval-after-load 'php-mode
  (phpactor-smart-jump-register))

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

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

;; save recent files
(use-package recentf
  :config
  (setq recentf-save-file
	(recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

;; Smart jumping into defintion
(use-package smart-jump
  :ensure t)

;; smartparens - smart parenthesis & quote matching
(use-package smartparens
  :ensure t)

;; smex - fuzzy matching in M-x mode
(use-package smex)

;; treemacs - view projects in directory tree structure
(use-package treemacs
  :init
  :config
  (bind-key "C-c t" 'treemacs))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package treemacs-projectile
  :after (treemacs projectile))

;; Org visual fill - make org mode editing like Google Doc
(defun yhou/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))
(use-package visual-fill-column
  :ensure t
  :hook (org-mode . yhou/org-mode-visual-fill))

;; show key bindings in popup
(use-package which-key
  :config
  (which-key-mode))

(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode)
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after (yasnippet)
  :defer t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Use C-c C-d to duplicate line
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")
