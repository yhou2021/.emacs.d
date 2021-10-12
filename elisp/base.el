(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("gnu" . "https://elpa.gnu.org/packages/"))

;; refresh packages if missing
(unless package-archive-contents
  (package-refresh-contents))

;; package management setup
;; if use-package is not installed, install use-package. Useful on non-Linux platform
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; define private and temporary files storage directories
(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories")

;; Fundamentals - Text Encoding
(set-charset-priority        'unicode)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system        'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Garbage collection threshold
(setq gc-cons-threshold (* 512 1000 1000)) ;; 512 MB, why not?
(setq read-process-output-max (* 4096 1024)) ;; 4 Mbit

;; Editor UI
(column-number-mode 1) ;; show current column in status bar
(set-face-attribute 'default nil ;; use jetbrains font
		    :family "JetBrains Mono"
		    :height 100)
(transient-mark-mode 1) ;; enable transient mark mode for org mode
;; show file path in frame title
(setq frame-title-format
      `((buffer-file-name "%f" "%b")
        ,(format " - 異想天開，腳踏實地")))

;; Emacs basic operations
(setq confirm-kill-emacs                     'y-or-n-p
      confirm-nonexistent-file-or-buffer     t
      save-interprogram-paste-before-kill    t
      require-final-newline                  t
      visible-bell                           t ;; turn on visual notification
      ring-bell-function                     'ignore ;; turn off sound notification
      custom-file                            "~/.emacs.d/custom.el"
      ;; additional user-installed binaries
      exec-path (append exec-path '("/usr/local/bin"))
      ;; go-specific binaries
      exec-path (append exec-path '("~/go/bin"))
      ;; hide the default start up screen
      inhibit-startup-message                t
      inhibit-startup-screen                 t
      ;; Editor Customization
      x-select-enable-clipboard              t
      ;; always check if packages are installed
      use-package-always-ensure t)

;; Bookmarks
(setq bookmark-save-flag t ;; persistent bookmarks
      bookmark-default-file (concat temporary-file-directory "/bookmarks"))

;; Backing up files
(setq
 history-length                     1000
 backup-inhibited                   nil
 make-backup-files                  t
 auto-save-default                  t
 auto-save-list-file-name           (concat temp-dir "/autosave")
 create-lockfiles                   nil
 backup-directory-alist            `((".*" . ,(concat temp-dir "/backup/")))
 auto-save-file-name-transforms    `((".*" ,(concat temp-dir "/auto-save-list/") t)))
(unless (file-exists-p (concat temp-dir "/auto-save-list"))
		       (make-directory (concat temp-dir "/auto-save-list") :parents))

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)

;; Disable Menu Bar
(menu-bar-mode -1)

;; Disable Tool Bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Disable Scroll Bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Update frindge, have some extra space
(set-fringe-mode 10)

;; Show matching parenthesis
(show-paren-mode 1)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; [Editing] Tab width
(setq-default tab-width 4)

;; [Editing] use space instead of tabs
(setq-default indent-tabs-mode nil)


;; [Editing]  Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; load custom file here
(load custom-file)

(provide 'base)
