;; Golang development mode
(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :hook (go-mode-hook . gofmt-before-save))


(use-package go-projectile
  :ensure t)

(use-package lsp-mode
  :config
  (add-to-list 'lsp-enabled-clients 'gopls) ;; Golang LSP server
  :hook (go-mode . lsp-deferred))


(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(provide 'lang-go)
