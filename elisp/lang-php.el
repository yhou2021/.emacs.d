(use-package ac-php
  :ensure t
  :config
  (add-hook 'php-mode-hook
          '(lambda ()
             ;; Enable auto-complete-mode
             (auto-complete-mode t)

             (require 'ac-php)
             (setq ac-sources '(ac-source-php))

             ;; As an example (optional)
             (yas-global-mode 1)

             ;; Enable ElDoc support (optional)
             (ac-php-core-eldoc-setup)

             ;; Jump to definition (optional)
             (define-key php-mode-map (kbd "M-]")
               'ac-php-find-symbol-at-point)

             ;; Return back (optional)
             (define-key php-mode-map (kbd "M-[")
               'ac-php-location-stack-back))))

(use-package company
  :init)

(use-package company-php
  :ensure t)

;; PHPactor LSP configuration
(use-package company-phpactor
  :ensure t)

(use-package lsp-mode
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-idle-delay 0.3)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :hook (php-mode . lsp)
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :requires lsp-mode flycheck
  :hook (php-mode . lsp-ui-mode))

(use-package phpactor
  :ensure t)

;; some configurations are disabled ffor now, but should be revisted someday in the future.
;; Known LSP that works: phpactor,
(use-package php-mode
  :ensure t
  :mode "\\.php\\'"
  :config

  (add-hook 'php-mode-hook
            '(lambda()
               (require 'company-php)
               (company-mode t)
               (lsp-mode t)
               (add-to-list 'company-backends 'company-ac-php-backend)))

  ;; Configuration - PHP Language Server
  ;; (setq lsp-clients-php-server-command (quote ("php" "~/.config/composer/vendor/bin/php-language-server.php" "--memory-limit=512M" "--tcp=127.0.0.1:20211")))
  ;; (setq lsp-php-composer-dir "~/.config/composer/")
  ;; (add-to-list 'lsp-enabled-clients 'php-ls)

  ;; Configuration - Intelephense
  (add-to-list 'lsp-enabled-clients 'iph)

  ;; Configuration - Serenata
  ;; (setq lsp-serenata-php-version 7.4)
  ;; (setq lsp-serenata-server-path "~/.emacs.d/bin/serenata-5.4.0.phar")
  ;; (add-to-list 'lsp-enabled-clients 'serenata)

  ;; Configuration - PHP Actor
  ;; (add-to-list 'lsp-enabled-clients 'phpactor)
  ;; (setq lsp-phpactor-path "/usr/local/bin/phpactor")
  ;; :hook ((php-mode . (lambda () (set (make-local-variable 'company-backends) '(company-phpactor company-files)))))
  )
;; eldoc integration
;; (add-hook 'php-mode-hook
;;           (lambda ()
;;             (make-local-variable 'eldoc-documentation-function)
;;             (setq eldoc-documentation-function
;;                   'phpactor-hover)))
;; Smartjump (go to definition
(with-eval-after-load 'php-mode
  (phpactor-smart-jump-register))

(provide 'lang-php)
