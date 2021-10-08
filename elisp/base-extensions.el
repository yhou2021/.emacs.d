
(use-package ace-window
  :config
  (global-set-key (kbd "M-o") 'ace-window))

(use-package anaconda-mode
  :defer t)

(use-package avy
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2))

(use-package bash-completion)

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'prog-mode-hook 'company-mode)
  (global-set-key (kbd "M-i") 'company-complete)
  (setq company-idle-delay 0.2)
  (global-set-key (kbd "C-<tab>") 'company-complete)
  (setq company-minimum-prefix-length 1))

(use-package company-php
  :after company
  :defer t)


(use-package company-web
  :after (company)
  :defer t)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package docker

  :defer t)

(use-package dockerfile-mode
  :after (docker)
  )

(use-package elpy
  :after (flycheck)

  :defer t
  :hook (elpy-mode . flycheck-mode))

(use-package emacsql)

(use-package flycheck)

(use-package goto-chg
  )

(use-package go-projectile
  :after (projectile)
  )

(use-package helm

  :defer t)

(use-package helm-company
  :after (helm company)

  :defer t)

(use-package helm-projectile
  :after (helm projectile)

  :config
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

;; highlight current line number
(use-package hlinum
  :config
  (hlinum-activate))

;; ivy mode
(use-package ivy
  :init (ivy-mode 1) ;; globally
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
  :defer t)

;; line number utility
(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode t))

(use-package lsp-mode

  :config
  (setq lsp-prefer-flymake nil)
  :hook (php-mode . lsp)
  :commands lsp
  :defer t)

(use-package lsp-ui

  :defer t
  :requires lsp-mode flycheck
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

(add-hook ‘lsp-mode-hook ‘lsp-ui-mode))

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
  :mode "\\.md\\'"
  :defer t)

(use-package multi-term

  :config
  (setq multi-term-program "/bin/bash")
  (bind-key "C-c m t" 'multi-term))

(use-package origami
  )

(use-package org
  :config
  (setq org-directory "~/org"
	org-default-notes-file (concat org-directory "/todo.org"))
  :bind
  ("C-c o l" . org-store-link)
  ("C-c o a" . org-agenda))

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

(use-package php-mode
  :mode ("\\.php\\'" . php-mode)
  :defer t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(use-package phpunit

  :defer t)

(use-package prettier-js

  :defer t)

(use-package projectile
  :config
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  (projectile-global-mode)
  (setq projectile-mode-line
	'(:eval (format " Projectile[%s]"
			(projectile-project-name)))))


(use-package python-mode
  :mode "\\.py\\'"
  :defer t)

;; save recent files
(use-package recentf
  :config
  (setq recentf-save-file
	(recentf-expand-file-name"~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

(use-package smartparens)

(use-package smex)

(use-package tide

  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package treemacs

  :init
  :config
  (bind-key "C-c t" 'treemacs))

(use-package treemacs-magit
  :after (treemacs magit)
  )

(use-package treemacs-projectile
  :after (treemacs projectile)
  )

(use-package typescript-mode

  :mode "\\.ts\\'"
  :defer t)

(use-package web-beautify

  :defer t)

(use-package web-mode
  :defer t)

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

(provide 'base-extensions)
