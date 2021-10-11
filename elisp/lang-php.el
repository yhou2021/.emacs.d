(use-package ac-php
  :ensure t)

(use-package company
  :init)

(use-package company-php
  :ensure t)

(use-package php-mode
  :mode
  (("\\.php\\'" . php-mode))
  :config
  (add-hook 'php-mode-hook
	    '(lambda ()
	       (require 'company-php)
	       (company-mode t)
	       (add-to-list 'company-backends 'company-ac-php-backend))))

(provide 'lang-php)
