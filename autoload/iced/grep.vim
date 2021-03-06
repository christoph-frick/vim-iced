let s:save_cpo = &cpo
set cpo&vim

let s:default_target = '{{user.dir}}{{separator}}**{{separator}}*.{clj,cljs,cljc}'
let g:iced#grep#target = get(g:, 'iced#grep#target', s:default_target)

function! iced#grep#exe(kw) abort
  if !iced#nrepl#is_connected()
    echom iced#message#get('not_connected')
    return
  endif

  let info = iced#nrepl#system#info()
  if !has_key(info, 'user_dir')
    return
  endif

  let kw = empty(a:kw) ? expand('<cword>') : a:kw
  let target = g:iced#grep#target
  let target = substitute(target, '{{user\.dir}}', info['user_dir'], 'g')
  let target = substitute(target, '{{separator}}', info['separator'], 'g')

  silent exe printf(':grep %s %s', kw, target)
  redraw!
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
