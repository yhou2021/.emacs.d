;; Personal Info - Used by Git, Org Mode, etc
(setq user-full-name "Yubing Hou")

;; Load customizations
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'base) ;; base Emacs configurations
(require 'base-theme) ;; theme settings
(require 'base-extensions) ;; extensions used by all modes
(require 'base-global-keys) ;; custom key set

(require 'lang-go) ;; golang mode
(require 'lang-javascript) ;; javascript mode development
(require 'lang-php) ;; PHP mode
(require 'lang-python) ;; python mode
(require 'lang-typescript)
(require 'lang-web) ;; general web development
