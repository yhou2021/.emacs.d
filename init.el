;; Personal Info - Used by Git, Org Mode, etc
(setq user-full-name "Yubing Hou")

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'base)
(require 'base-theme)
(require 'base-extensions)
(require 'lang-go)
(require 'lang-php)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ac-php yasnippet-snippets which-key web-mode web-beautify use-package treemacs-projectile treemacs-magit tide smex smartparens restclient python-mode python prettier-js phpunit origami org-projectile org-bullets multi-term material-theme magit-popup lsp-ui js2-mode ivy hlinum helm-projectile helm-company goto-chg go-projectile emacsql elpy dockerfile-mode docker dashboard company-web company-php company-go bash-completion atom-one-dark-theme anaconda-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
