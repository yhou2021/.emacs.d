(use-package elpy
  :ensure t
  :defer t
  :init
  :after (flycheck)
  :config
  (setq elpy-rpc-python-command "python3")
  :hook (elpy-mode . flycheck-mode))

(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mod . (lambda()
			(require 'lsp-python-ms)
			(lsp))))

(use-package python
  :mode ("\\.py" . python-mode)
  :config
  (use-package elpy
    :init
    (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
    :config
    (setq elpy-rpc-backend "jedi")
    :bind (:map elpy-mode-map
		("M-." . elpy-goto-definition)
		("M-," . pop-tag-mark)))
  (elpy-enable))

(provide 'lang-python)
