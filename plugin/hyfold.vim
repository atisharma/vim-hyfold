" vim-hyfold — Semantic folding for Hy
" Maintainer: Ati Sharma <ati@agalmic.ltd>
" License:    GPL v2 (see LICENSE)

if exists('g:loaded_hyfold') | finish | endif
let g:loaded_hyfold = 1

if !exists('g:hy_foldwords')
  let g:hy_foldwords = "defn,defclass,defmacro,defreader,defmethod,deftest,defmain,
                        \defn+,fn+,defmacro!,with-decorator,with,match"
endif

function! s:CompareLispword(line)
  let l:fwc = split(g:hy_foldwords, ",")

  for l:fw in l:fwc
    " \V = very-nomagic (foldword is literal), \m = back to magic mode
    let l:efw = '\V' . l:fw . '\m'

    " Top-level: (foldword followed by non-symbol char, ), or end-of-line
    if a:line =~ '^\s*(' . l:efw . '[^A-Za-z0-9_!?*+-]'
      return 1
    elseif a:line =~ '^\s*(' . l:efw . ')$'
      return 1
    elseif a:line =~ '^\s*(' . l:efw . '$'
      return 1

    " Namespaced: (module.foldword ...
    elseif a:line =~ '^\s*([A-Za-z0-9_-]\+\.' . l:efw . '[^A-Za-z0-9_!?*+-]'
      return 1
    elseif a:line =~ '^\s*([A-Za-z0-9_-]\+\.' . l:efw . ')$'
      return 1
    elseif a:line =~ '^\s*([A-Za-z0-9_-]\+\.' . l:efw . '$'
      return 1
    endif
  endfor
  return 0
endfunction

function! GetHyFold()
  if s:CompareLispword(getline(v:lnum))
    return ">1"
  elseif getline(v:lnum) =~ '^\s*$'
    let l:last_lnum = line("$")
    let l:next_lnum = v:lnum

    while l:next_lnum < l:last_lnum
      let l:next_lnum += 1
      let l:next_line = getline(l:next_lnum)

      if l:next_line !~ '^\s*$'
        return "="
      endif
    endwhile
    return "<1"
  else
    return "="
  endif
endfunction

function! s:StartHyFolding()
  setlocal foldexpr=GetHyFold()
  setlocal foldmethod=expr
endfunction

" Only handle folding, let vim-hy handle filetype detection
augroup hyfold
    au!
    au FileType hy call s:StartHyFolding()
    au FileType hy setlocal report=100000
augroup END
