(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; maximize window on start up
(setq inhibit-startup-screen t);; hide the start up screen
(menu-bar-mode 0) ;; disable menu bar
(tool-bar-mode -1) ;; disable toolbar
(toggle-scroll-bar -1) ;; disable scroll bar
(transient-mark-mode 1) ;; enabled for org mode
(setq frame-title-format ;; change window title
      '(buffer-file-name "%f"
			 (dired-directory dired-directory "%b")))
(setq line-number-mode t) ;; show line number
(column-number-mode 1) ;; show current column in status bar
(global-hl-line-mode 1) ;; highlight current line
(global-visual-line-mode 1) ;; enable line wrap
;; (global-whitespace-mode 1) ;; enable whitespace handling by default
(show-paren-mode 1) ;; highlight matched parenthesis
(setq show-paren-delay 0)
(set-face-attribute 'default nil ;; use jetbrains font
		    :family "JetBrains Mono"
		    :height 100
		    :weight 'normal
		    :width 'normal)
(setq visible-bell t) ;; turn on visual notification
(setq ring-bell-function 'ignore) ;; turn off sound notification
;; always show line number
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
(setq
   whitespace-style
   '(face ; viz via faces
     trailing ; trailing blanks visualized
     lines-tail ; lines beyond  whitespace-line-column
     space-before-tab
     space-after-tab
     newline ; lines with only blanks
     indentation ; spaces used for indent when config wants tabs
     empty ; empty lines at beginning or end
     )
   whitespace-line-column 120 ; column at which whitespace-mode says the line is too long
   )