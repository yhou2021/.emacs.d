# My Emacs Configuration

This repository documents my jounery back to becoming a regular Emacs user.

## Editing

### Code Formatter

#### Javascript
Install Prettier: `$ sudo npm i -g prettier`

## Language/Framework Server Protocols

### Angular
Run: `$ npm install -g @angular/language-service@next typescript @angular/language-server`

### Go
Make sure `gopls` is installed and `$GOPATH/bin` is in emacs' executable paths.

### Python3
After `elpy` is added to emacs, also install addtional system requirements:
`$ sudo apt install python3-jedi black python3-autopep8 yapf3 python3-yapf`

Then restart Emacs.

### TypeScript
Install TypeScript language server:
`$ sudo npm i -g typescript-language-server`

Then in Emacs, install LSP server:
`M-x lsp-install-server RET jsts-ls RET`
