;; Default settings for Emacs that should be used everywhere

;; Font-size for each system
(defvar yhou/font-scale 100)

;; MacOS Specific Configurations - since mac are all on retina display
(if (eq system-type 'darwin)
	(progn
	  (setq insert-directory-program "gls" dired-use-ls-dired t) ;; MacOS built-in ls does not support group directory first)
	  (setq yhou/font-scale 140)))

(if (eq system-type 'gnu/linux)
	(setq yhou/font-scale 100))


;; System
;; Fundamentals - Text Encoding
(set-charset-priority        'unicode)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system        'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Application - Configuration File Locations
(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))

;; Application - temporary and private file directories
(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir))

;; Application - Binary execution paths
(setq exec-path (append exec-path '("/usr/local/bin"))
      exec-path (append exec-path '("~/go/bin")))
;; $PATH defintions
(use-package exec-path-from-shell
  :ensure t
  :init
  (exec-path-from-shell-initialize))

;; Application Behavior
(setq confirm-kill-emacs                     'y-or-n-p
      confirm-nonexistent-file-or-buffer     t
      require-final-newline                  t)

;; UI - Window sizing
(use-package golden-ratio
  :ensure t
  :init
  (golden-ratio-mode 1)
  :config
  (setq golden-ratio-auto-scale t))

;; UI - Disable default start-up message
(setq inhibit-startup-message t) ;; Disable start-up mesasge

;; UI - Disable default start-up scree
(setq inhibit-startup-screen t)

;; UI - Disable menu bar
(menu-bar-mode -1)

;; UI - Disable tool bar
(tool-bar-mode -1)

;; UI - Disable scroll bar
(scroll-bar-mode -1)

;; UI - Disable tool tips
(tooltip-mode -1)

;; UI - Enable visible bell
(setq visible-bell t)

;; UI -  Maximize frame on every start up
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable Menu Bar
(menu-bar-mode -1)

;; Editor frindge - some margin around text area
(set-fringe-mode 16)

;; Editor - font
(set-face-attribute 'default nil :font "JetBrains Mono" :height yhou/font-scale)
(set-face-attribute 'fixed-pitch nil :font "JetBrains Mono" :height yhou/font-scale)
(set-face-attribute 'variable-pitch nil :font "Ubuntu" :weight 'medium :height yhou/font-scale)

(setq inhibit-compacting-font-caches t) ;; do not compact font caches during GC

;; Editor - line mode and exceptions
(global-display-line-numbers-mode t) ;; show line number globally
(dolist (mode '(org-mode-hook ;; exceptions where line number shall not show
                term-mode-hook
				sql-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Editor - parenthesis matching
(show-paren-mode 1)

;; Editor - highlight cursor
(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

;; Editor - line highlight
(global-hl-line-mode t)

;; Editor - window navigation
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  (which-key-setup-minibuffer)
  :config
  (setq which-key-idle-delay 0.3))

;; Mode bar - show column number
(column-number-mode 1)

;; Prompt - ESC to leave
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Prompt - Use Y or N
(fset 'yes-or-no-p 'y-or-n-p)

;; dired - show less when looking up files, and group directories first
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom
  ((dired-listing-switches "-agho --group-directories-first")))

;; Notifications
(setq ring-bell-function 'ignore) ;; turn off sound notification

;; Bookmark
(setq bookmark-save-flag t ;; persistent bookmarks
      bookmark-default-file (concat temporary-file-directory "/bookmarks"))

;; File backups
(setq history-length            1000
      backup-inhibited          nil
      make-backup-files         t
      auto-save-default         t
      auto-save-list-file-name  (concat temp-dir "/autosave")
      create-lockfiles          nil
      backup-directory-alist    `((".*" . ,(concat temp-dir "/backup/")))
 auto-save-file-name-transforms    `((".*" ,(concat temp-dir "/auto-save-list/") t)))
(unless (file-exists-p (concat temp-dir "/auto-save-list"))
		       (make-directory (concat temp-dir "/auto-save-list") :parents))

(provide 'defaults)
