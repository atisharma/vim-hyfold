# vim-hyfold

Semantic folding for [Hy](https://hylang.org) code in Vim.

Folds code-blocks defined by `g:hy_foldwords`. The default foldwords are
`defn`, `defclass`, `defmacro`, `defreader`, `defmethod`, `deftest`,
`defmain`, `defn+`, `fn+`, `defmacro!`, `with-decorator`, `with`, `try`, and `match`.

Override in your vimrc:

    let g:hy_foldwords = "defn,defclass"

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):

    Plug 'atisharma/vim-hyfold'

Or use your preferred plugin manager.

## License

GPL v2 — see [LICENSE](LICENSE).

## Credits

Forked from [cljfold.vim](https://github.com/gberenfield/cljfold.vim) by
Greg Berenfield, which drew from Steve Losh and Meikel Brandmeyer
(VimClojure).
