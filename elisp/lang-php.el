(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (php-mode . lsp-deferred))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package php-mode
  :ensure t
  :mode "\\.php\\'")

(provide 'lang-php)
