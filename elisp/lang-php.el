(use-package ac-php
  :ensure t)

(use-package lsp-mode
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-idle-delay 0.0)
  :hook (php-mode . lsp)
  :commands (lsp lsp-deferred))

(use-package php-mode
  :ensure t
  :mode "\\.php\\'"
  :config
  (setq lsp-clients-php-server-command (quote ("php" "~/.config/composer/vendor/bin/php-language-server.php" "--memory-limit=512M")))
  (setq lsp-php-composer-dir "~/.config/composer/")
  (add-to-list 'lsp-enabled-clients 'php-ls)
  (add-to-list 'company-backends 'company-ac-php-backend))

(provide 'lang-php)
