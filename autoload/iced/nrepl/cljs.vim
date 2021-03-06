let s:save_cpo = &cpo
set cpo&vim

function! s:switch_session(resp) abort
  let session = iced#nrepl#repl_session()
  let cljs_session = iced#nrepl#sync#clone(session)
  call iced#nrepl#set_session('cljs', cljs_session)
  call iced#nrepl#change_current_session('cljs')
  echom iced#message#get('started_cljs_repl')
endfunction

let g:iced#nrepl#cljs#default_env = get(g:, 'iced#nrepl#cljs#default_env', 'figwheel')
let s:using_env_key = v:none

let s:env = {
    \ 'figwheel': {-> iced#nrepl#cljs#figwheel#get_env()},
    \ 'nashorn': {-> iced#nrepl#cljs#nashorn#get_env()},
    \ 'custom': {-> iced#nrepl#cljs#custom#get_env()},
    \ }

function! iced#nrepl#cljs#repl(env_key) abort
  let env_key = trim(empty(a:env_key) ? g:iced#nrepl#cljs#default_env : a:env_key)
  if !has_key(s:env, env_key)
    echom iced#message#get('invalid_cljs_env')
    return
  endif

  if iced#nrepl#current_session_key() ==# 'clj' && empty(s:using_env_key)
    let s:using_env_key = env_key
    let env = s:env[s:using_env_key]()
    call env['start'](funcref('s:switch_session'))
  endif
endfunction

function! iced#nrepl#cljs#quit() abort
  if iced#nrepl#current_session_key() ==# 'cljs' && !empty(s:using_env_key)
    call iced#nrepl#sync#send({
        \ 'id': iced#nrepl#eval#id(),
        \ 'op': 'eval',
        \ 'code': ':cljs/quit',
        \ 'session': iced#nrepl#repl_session(),
        \ })

    let env = s:env[s:using_env_key]()
    call env['stop']()
    let s:using_env_key = v:none

    call iced#nrepl#sync#close(iced#nrepl#current_session())
    call iced#nrepl#change_current_session('clj')
    echom iced#message#get('quitted_cljs_repl')
  endif
endfunction

" c.f. :h :command-completion-custom
function! iced#nrepl#cljs#env_complete(arg_lead, cmd_line, cursor_pos) abort
  return join(keys(s:env), "\n")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
