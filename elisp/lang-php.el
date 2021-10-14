(use-package ac-php
  :ensure t)

(use-package lsp-mode
  :config
  (setq lsp-prefer-flymake nil)

 ; (setq lsp-php-composer-dir "~/.config/composer/")
  (setq lsp-idle-delay 0.0)
  :hook (php-mode . lsp)
  :commands (lsp lsp-deferred))

(use-package php-mode
  :ensure t
  :mode "\\.php\\'"
  :config
  (setq lsp-clients-php-server-command "~/.config/composer/vendor/felixfbecker/language-server/bin/php-language-server.php")
  (add-to-list 'lsp-enabled-clients 'php-ls)
  (add-to-list 'company-backends 'company-ac-php-backend))

(provide 'lang-php)
