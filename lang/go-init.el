;; Go development configurations
;; 1. File formatting
;; 2. LSP server
;; 3. Auto-completion
;; 4. Build

;; automatically activate go mode when viewing a .go file
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

(add-hook 'before-save-hook 'gofmt-before-save)

(setq tab-width 4)

(setq indent-tabs-mode 1)

;; use custom lsp
(add-hook 'go-mode-hook 'lsp-deferred)

;; format .go files before save
(add-hook 'before-save-hook 'gofmt-before-save)

;; go tooling
;; add Go binaries to execution path, including LSP, gofmt, etc.
(add-to-list 'exec-path "$HOME/go/bin")

(provide 'go-init)
