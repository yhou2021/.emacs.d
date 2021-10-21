;; Personal Info - Used by Git, OrgMode, etc
(setq user-full-name "Yubing Hou")

;; base configurations
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                        ("melpa-stable" . "https://stable.melpa.org/packages/")
                        ("org" . "https://orgmode.org/elpa/")
                        ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)


;; refresh packages if missing
(unless package-archive-contents
  (package-refresh-contents))

;; package management setup
;; if use-package is not installed, install use-package. Useful on non-Linux platform
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-alaways-ensure t)

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
(set-face-attribute 'default nil :font "JetBrains Mono" :height 100)
(set-face-attribute 'fixed-pitch nil :font "JetBrains Mono" :height 100)
(set-face-attribute 'variable-pitch nil :font "Lato" :height 100 :weight 'regular)
(transient-mark-mode 1) ;; enable transient mark mode for org mode
;; show file path in frame title
(setq frame-title-format
      `((buffer-file-name "%f" "%b")
        ,(format " - Emacs")))

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
      x-select-enable-clipboard              t)

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
(setq scroll-preserve-screen-position 1) ;; scrolling while keeping the postion of cursor

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
  :ensure t
  :pin melpa
  :init
  (load-theme 'dracula t))


;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; ace-window: makes window switching easy
(use-package ace-window
  :init
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window))

;; ag - fast searching string within project (multi-threaded)
(use-package ag
  :ensure t
  :config
  (setq ag-highlight-search t))

;; additional icons
(use-package all-the-icons
  :ensure t)

;; automatic update packages
(use-package auto-package-update
  :ensure t
  :pin melpa
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

;; avy - jumping to an arbitrary position quickly
(use-package avy
  :ensure t)

;; company - string completion (COMPlete ANYthing)
(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode) ;; only activate company mode if I am writing a program
  :config
  (add-hook 'prog-mode-hook 'company-mode)
  (setq company-idle-delay 0.4)
  (setq company-minimum-prefix-length 3)) ;; do not hint until 1 characters

;; (use-package company-php
;;   :ensure t)

;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

(use-package counsel
  :ensure t
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-m" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x c k" . counsel-yank-pop))

(use-package counsel-projectile
  :ensure t
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
  (setq dashboard-set-heading-icons t)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title ""))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom
  ((dired-listing-switches "-agho --group-directories-first")))

(use-package docker
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

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
  :pin melpa
  :ensure t
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))

;; syntax check
(use-package flycheck
  :ensure t)

(use-package golden-ratio
  :ensure t
  :init
  :config
  (setq golden-ratio-auto-scale t))

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
  :ensure t
  :config
  (hlinum-activate))

;; ivy mode
(use-package ivy
  :pin melpa
  :ensure t
  :init (ivy-mode 1)
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
  :ensure t
  :config
  (setq linum-format " %3d ")
  (add-hook 'prog-mode-hook 'linum-mode))

;; LSP mode set up. Do no add language dependency here. Instead, configure each
;; language in its own package `lang-<name>.el`
(use-package lsp-mode
  :pin melpa
  :ensure t
  :hook (go-mode . lsp-deferred)
  :hook (php-mode . lsp-deferred)
  :hook (python-mode . lsp-deferred)
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-idle-delay 0.3)
  (setq lsp-log-io t) ;; for troubleshooting purpose only
  (setq lsp-eslint-enable t)
  (setq lsp-eslint-auto-fix-on-save t) ;; auto fix js/ts code on save
  (add-to-list 'lsp-enabled-clients 'gopls) ;; golang
  (add-to-list 'lsp-enabled-clients 'iph) ;; php
  (add-to-list 'lsp-enabled-clients 'pyright) ;; python
  (add-to-list 'lsp-enabled-clients 'ts-ls) ;; typescript
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :commands (lsp lsp-deferred))

;; Provide quick symbol searching
(use-package lsp-ivy
  :ensure t)

(use-package lsp-pyright
  :ensure t
  :config
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

;; Provide better ui with lsp-mode and treemacs
(use-package lsp-treemacs
  :after lsp)

;; (use-package lsp-ui
;;   :pin melpa-stable
;;   :ensure t
;;   :requires (lsp-mode flycheck)
;;   :commands lsp-ui-mode
;;   :config
;;   (setq lsp-ui-doc-enable t
;; 	lsp-ui-doc-use-childframe t
;; 	lsp-ui-doc-position 'top
;; 	lsp-ui-doc-include-signature t
;; 	lsp-ui-sideline-enable nil
;; 	lsp-ui-flycheck-enable t
;; 	lsp-ui-flycheck-list-position 'right
;; 	lsp-ui-flycheck-live-reporting t
;; 	lsp-ui-peek-enable t
;; 	lsp-ui-peek-list-width 60
;; 	lsp-ui-peek-peek-height 25
;; 	lsp-ui-sideline-enable nil
;;     lsp-ui-sideline-show-hover nil)
;;   :hook (lsp-mode-hook . lsp-ui-mode))

;; magit - magic Git
(use-package magit
  :ensure t
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

(use-package magit-popup
  :ensure t)

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this))

(use-package no-littering
  :pin melpa
  :ensure t)

;; origami - flexible text folding
(use-package origami
  :ensure t)

;; org mode customizations
(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Lato" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow
  fixed-pitch)) (set-face-attribute 'org-special-keyword nil :inherit
  '(font-lock-comment-face fixed-pitch)) (set-face-attribute
  'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit
  'fixed-pitch))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 0))

;; Org mode
(use-package org
  :ensure t
  :commands (org-capture org-agenda)
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-directory "~/org" org-default-notes-file (concat org-directory "/Todo.org"))
  (setq org-agenda-files '("~/org/Tasks.org"))
  (setq org-agenda-diary-file '("~/org/Agenda.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("publish" . ?P)
       ("batch" . ?b)
       ("note" . ?n)
       ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  (efs/org-font-setup))

(with-eval-after-load 'org
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))


;; Show bullets in org-mode as UTF-8 characters
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org-projectile
  :ensure t
  :config
  (org-projectile-per-project)
  (setq org-projectile-per-project-filepath "todo.org"
	org-agenda-files (append org-agenda-files (org-projectile-todo-files))))

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

(use-package popwin
  :ensure t
  :init)

(use-package projectile
  :ensure t
  :config
  (setq projectile-known-projects-file
	(expand-file-name "projectile-bookmarks.eld" temp-dir))
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line
	'(:eval (format " Projectile[%s]"
			        (projectile-project-name)))))

;; python mode base configuration
(use-package python-mode
  :ensure t
  :custom
  (python-shell-interpreter "python3"))

(use-package pyvenv
  :ensure t
  :after python-mode
  :config
  (pyvenv-mode 1))

;; save recent files
(use-package recentf
  :ensure t
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
(use-package smex
  :ensure t)

;; treemacs - view projects in directory tree structure
(use-package treemacs
  :ensure t
  :init
  :config
  (bind-key "C-c t" 'treemacs))

(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile))

;; typescript/angular mode
(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq lsp-clients-angular-language-server-command
      '("node"
        "/usr/local/bin/ngserver")))
(with-eval-after-load 'typescript-mode (add-hook 'typescript-mode-hook #'lsp))

;; yaml file
(use-package yaml-mode
  :ensure t)

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
  :ensure t
  :config
  (which-key-mode))

(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after (yasnippet)
  :defer t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Use C-c C-d to duplicate line
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")
