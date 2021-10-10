# My Emacs Configuration

This repository documents my jounery back to becoming a regular Emacs user.

## Edit

### Code Formatter

#### Javascript
Install Prettier: `$ sudo npm i -g prettier`

## Search
Several tools need to be installed to allow fast project traversal and string search.

### `Ag`
* Install
  * On Linux: `$ sudo apt install silversearcher-ag`
  * On Mac: `$ brew install the_silver_searcher`
* Configurations
  * Set up the `.agignore` file, or a global `$HOME/.agignore` file
  * Install `ag` melpa


## Language/Framework Server Protocols

### Angular
Run: `$ sudo npm install -g @angular/language-service@next typescript @angular/language-server`

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
