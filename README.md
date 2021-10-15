# My Emacs Configuration

This repository documents my jounery back to becoming a regular Emacs user.

## Edit

### Code Formatter

#### Javascript
Install Prettier: `$ sudo npm i -g js-beautify`

#### TypeScript
Install TS-Formatter: `$ sudo npm i -g typescript-formatter`

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

### PHP (language server not aways working)

First, make sure `composer` and `php-curl`, `php7.4-sqlite3` are installed.

Install Jetbrains PHP Subs: `$ composer global require jetbrains/phpstorm-stubs:dev-master`

Install Felix Becker's PHP Language Server: `$ composer global require felixfbecker/language-server --update-with-all-dependencies`

Download `serenata` version `5.4.0`. [link](https://gitlab.com/Serenata/Serenata/-/releases)

Move the downloaded binary to `~/.emacs.d/vendor/bin/` and rename it to `serenata-v5.4.0.phar`.

Make it executable `$ chmod +x serenata-v5.4.0.phar`.

If running into issue `LSP :: example_file_name no in project or it is blacklisted`, add project root
to LSP workspace or remove it from the blacklist:
`M-x lsp-workspace-blacklist-remove` or `M-s lsp-workspace-folders-add`.

#### PHP Actor
Install PHP Actor, follow this [instruction](https://phpactor.readthedocs.io/en/master/usage/standalone.html).

Update Emacs plug in:
```lisp
(use-package phpactor :ensure t)
(use-package company-phpactor :ensure t)
```

```
M-x phpactor-install-or-update RET
```

### Python3
After `elpy` is added to emacs, also install addtional system requirements:
`$ sudo apt install python3-jedi black python3-autopep8 yapf3 python3-yapf`

Then restart Emacs.

### TypeScript
Install TypeScript language server:
`$ sudo npm i -g typescript-language-server`

Then in Emacs, install LSP server:
`M-x lsp-install-server RET jsts-ls RET`
