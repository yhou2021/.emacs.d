(use-package ac-php
  :ensure t)

(use-package company-php
  :ensure t)

;; (setq lsp-serenata-php-version 7.4)
;; (setq lsp-serenata-server-path "~/.emacs.d/vendor/bin/serenata-v5.4.0.phar")

;; (use-package lsp-mode
  ;; :config
  ;; (setq lsp--tcp-server-port 87654) ;; Cake runs at 8765
  ;; (setq lsp-serenata-php-version 7.4)
  ;; (setq lsp-serenata-server-path "~/.emacs.d/vendor/bin/serenata-v5.4.0.phar")
  ;; (add-to-list 'lsp-enabled-clients 'serenata)
 ;; (add-to-list 'lsp-disabled-clients '(php-ls, iph intelephense))
  ;; (setq lsp-idle-delay 0.300)
  ;; (setq lsp-log-io nil) ;; improve performance during development, useful for debugging though
  ;; :hook (php-mode . lsp)
  ;; :commands (lsp lsp-deferred))


(use-package php-mode
  :mode
  (("\\.php\\'" . php-mode))
  :config
  (add-hook 'php-mode-hook
	    '(lambda ()
	       (require 'company-php)
	       (company-mode t)
	       (lsp-mode t)
	       (add-to-list 'company-backends 'company-ac-php-backend)))
  (setq lsp-serenata-php-version 7.4)
  (setq lsp-serenata-server-path "~/.emacs.d/vendor/bin/serenata-v5.4.0.phar")
  (setq lsp--tcp-server-port 87654) ;; Cake runs at 8765
  (setq lsp-serenata-php-version 7.4)
  (setq lsp-serenata-server-path "~/.emacs.d/vendor/bin/serenata-v5.4.0.phar")
  (add-to-list 'lsp-enabled-clients 'serenata))

(add-hook 'php-mode-hook #'lsp-serenata)

(provide 'lang-php)
