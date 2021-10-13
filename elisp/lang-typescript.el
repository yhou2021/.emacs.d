(use-package lsp-mode
  :hook (typescript-mode . lsp-deferred))

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (add-to-list 'lsp-enabled-clients 'ts-ls)
  (setq lsp-clients-angular-language-server-command
      '("node"
        "/usr/local/bin/ngserver")))
(with-eval-after-load 'typescript-mode (add-hook 'typescript-mode-hook #'lsp))

(provide 'lang-typescript)
