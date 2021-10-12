;; Personal Info - Used by Git, Org Mode, etc
(setq user-full-name "Yubing Hou")

;; Load customizations
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'base) ;; base Emacs configurations
(require 'base-theme) ;; theme settings
(require 'base-extensions) ;; extensions used by all modes
(require 'base-global-keys) ;; custom key set

(require 'lang-go) ;; golang mode
(require 'lang-javascript) ;; javascript mode development
(require 'lang-php) ;; PHP mode
(require 'lang-python) ;; python mode
(require 'lang-web) ;; general web development
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Extensions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package bash-completion)

(use-package docker
  :defer t)

(use-package dockerfile-mode
  :after docker)

(use-package dumb-jump
  :config
  (dumb-jump-mode))

(use-package emacsql)

(use-package json-mode
  :mode "\\.json\\'")

(use-package json-reformat)

(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-prefer-flymake nil) ;; do not add go mode here
  :hook (go-mode . lsp-deferred)
  :hook (php-mode . lsp-deferred)
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :defer t
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
	lsp-ui-sideline-enable nil)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package markdown-mode
  :mode "\\.md\\'")

(defun tsfmt ()
  "Format Typescript code on save"
  (when (eq major-mode 'typescript-mode)
    (shell-command-to-string (format "tsfmt %s" buffer-file-name))))

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :config
  (add-hook 'before-save-hook 'tsfmt))

(with-eval-after-load 'typescript-mode (add-hook 'typescript-mode-hook 'lsp-deferred))

(use-package web-beautify
  :ensure t)
