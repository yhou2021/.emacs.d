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
  (setq company-idle-delay 0.300)
  (global-set-key (kbd "C-<tab>") 'company-complete)
  (setq company-minimum-prefix-length 1)) ;; do not hint until 1 characters

(use-package company-box
  :hook (company-mode . company-box-mode))

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



;; ensure that environment variables in Emacs is the same as shell
(use-package exec-path-from-shell
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))

(use-package flycheck)

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
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-idle-delay 0.382)
  (setq lsp-log-io t) ;; for troubleshooting purpose only
  (lsp-enable-which-key-integration t)
  :commands (lsp lsp-deferred))

;; Provide quick symbol searching
(use-package lsp-ivy)

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
;; save recent files
(use-package recentf
  :config
  (setq recentf-save-file
	(recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

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

(provide 'base-extensions)
