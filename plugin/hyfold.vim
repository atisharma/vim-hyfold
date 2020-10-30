if !exists('g:hy_foldwords')
  let g:hy_foldwords = "defn,defclass"
endif

function! CompareLispword(line)
  let fwc = split(g:hy_foldwords,",")

  for fw in fwc
    if a:line =~ '^\s*('.fw.'.*'
      return 1
    elseif a:line =~ '^\s*(\w*/'.fw.'.*'
      return 1
    endif
  endfor
endfunction

function! GetHyFold()
      if CompareLispword(getline(v:lnum))
        return ">1"
      elseif getline(v:lnum) =~ '^\s*$'
            let my_cljnum = v:lnum
            let my_cljmax = line("$")

            while (1)
                  let my_cljnum = my_cljnum + 1
                  if my_cljnum > my_cljmax
                        return "<1"
                  endif

                  let my_cljdata = getline(my_cljnum)

                  if my_cljdata =~ '^$'
                        return "<1"
                  else
                        return "="
                  endif
            endwhile
      else
            return "="
      endif
endfunction

function! StartHyFolding()
  setlocal foldexpr=GetHyFold()
  setlocal foldmethod=expr
endfunction

augroup ft_hy
    au!
    au BufNewFile,BufRead *.hy set filetype=hy
    au FileType hy silent! call StartHyFolding()
    au FileType hy setlocal report=100000
augroup END
