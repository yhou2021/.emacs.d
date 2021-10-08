(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("gnu" . "https://elpa.gnu.org/packages/"))

;; refresh packages if missing
(when (not package-archive-contents)
  (package-refresh-contents))

;; if use-package is not installed, install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Fundamentals - Text Encoding
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Editor UI
(column-number-mode 1) ;; show current column in status bar
(set-face-attribute 'default nil ;; use jetbrains font
		    :family "JetBrains Mono"
		    :height 100)
(setq visible-bell t) ;; turn on visual notification
(setq ring-bell-function 'ignore) ;; turn off sound notification
(transient-mark-mode 1) ;; enable transient mark mode for org mode

;; Emacs basic operations
(setq confirm-kill-emacs 'y-or-n-p
      ;; additional user-installed binaries
      exec-path (append exec-path '("/usr/local/bin"))
      ;; go-specific binaries
      exec-path (append exec-path '("$HOME/go/bin"))
      ;; hide the default start up screen
      inhibit-startup-screen t
      ;; always check if packages are installed
      use-package-always-ensure t)

;; Bookmarks
(setq bookmark-save-flag t
      bookmark-default-file (concat temporary-file-directory "/bookmarks"))

;; Disable Menubar
(menu-bar-mode -1)

;; Disable Toolbar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
;; Disable Scrollbar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Show matching parenthesis
(show-paren-mode 1)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'base)
