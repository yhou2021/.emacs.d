(use-package elpy
  :ensure t
  :init
  :after (flycheck)
  :config
  (setq elpy-rpc-python-command "python3")
  :hook (elpy-mode . flycheck-mode))

(use-package lsp-pyright
  :ensure t
  :config
  (add-to-list 'lsp-enabled-clients 'pyright)
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

(provide 'lang-python)
