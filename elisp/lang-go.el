;; Golang development mode
(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :config
  (add-hook 'go-mode-hook 'gofmt-before-save))

(use-package go-projectile
  :ensure t)

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package lsp-mode
  :config
  (add-to-list 'lsp-enabled-clients 'gopls)
  (setq lsp-idle-delay 0.300)
  :hook (go-mode . lsp)
  :commands (lsp lsp-deferred))

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(provide 'lang-go)
