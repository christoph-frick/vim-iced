# vim-iced
[![CircleCI](https://circleci.com/gh/liquidz/vim-iced.svg?style=svg)](https://circleci.com/gh/liquidz/vim-iced)
[![Powered by vital.vim](https://img.shields.io/badge/powered%20by-vital.vim-80273f.svg)](https://github.com/vim-jp/vital.vim)

Clojure Interactive Development Environment for Vim8.

**WARN**: This project is work in progress.

## Requirements

 * Vim 8.1 or later
 * Clojure & Java
 * [vim-sexp](https://github.com/guns/vim-sexp)
 * No python!

## Features

 * Asynchronous evaluation
   * powered by `channel` in Vim8
 * Rich functions
   * powered by [cider-nrepl](https://github.com/clojure-emacs/cider-nrepl), [refactor-nrepl](https://github.com/clojure-emacs/refactor-nrepl)
 * ClojureScript support
   * `figwheel` and `nashorn` is supported currently

## Installation

### vim-plug

```
Plug 'ctrlpvim/ctrlp.vim'
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}
```

[ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) is required when selecting multiple candidates.

### key mappings

vim-iced is providing default key mappings.
To enable default key mappings, add folow line to your `.vimrc`.

```
let g:iced_enable_default_key_mappings = v:true
```

See [vim-iced.txt](./doc/vim-iced.txt) for actual mappings.

### configuration

* ~/.lein/profile.clj
```clj
{{{lein-profile}}}
```

[Boot](https://github.com/boot-clj/boot) configuration is also described in [vim-iced.txt](./doc/vim-iced.txt).

**WARN** `cider.nrepl/wrap-trace` will cause vim's freezing.

## Usage

  1. Start repl
     - `lein repl`
     - `boot repl`
     - `clojure -Sdeps '{:deps {iced-repl {:git/url "https://github.com/liquidz/vim-iced" :sha "3dadf3c32473cdf9419dbbe10764b6d5c4fbcecc"}}}' -m iced-repl`
  2. Open source file
  3. Evaluate forms (If not connected, vim-iced will connect automatically)

## Document

  * See [vim-iced.txt](./doc/vim-iced.txt).

## License

Copyright (c) 2018 [Masashi Iizuka](http://twitter.com/uochan)

Distributed under the MIT License.
