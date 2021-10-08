;; Golang programming mode
(use-package company
  :ensure t)

(use-package go-projectile
  :ensure t)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package go-mode
  :ensure t
  :mode "\\.go\\'")

;; Before-save hooks to gofmt and goimport
(add-hook 'before-save-hook 'gofmt-before-save)

(provide 'lang-go)
