let s:VERSION = '1.0.0'

if v:version < 700
    echoerr "The Chronos plugin requires vim >= 7."
    finish
endif

if exists("g:loaded_chronos")
    finish
endif
let g:loaded_chronos = 1

let s:old_cpo = &cpo
set cpo&vim

let s:wildignore = &wildignore
if s:wildignore != ""
    set wildignore=""
endif

let s:heartbeats = []

if !exists("g:chronos_Url")
    let g:chronos_Url = "http://localhost:10203/heartbeats/editor"
endif

if !exists("g:chronos_SamplingInterval")
    let g:chronos_SamplingInterval = 5
endif

if !exists("g:chronos_FlushInterval")
    let g:chronos_FlushInterval = 30
endif

function! s:GetCurrentFile()
    return expand("%:p")
endfunction

function! s:RecordActivity()
    let heartbeat = {}
    let heartbeat['timestamp'] = localtime() * 1000
    let heartbeat['file'] = s:GetCurrentFile()

    if len(s:heartbeats) > 0
        if s:heartbeats[-1]['file'] == heartbeat['file'] && localtime() - s:heartbeats[-1]['timestamp'] < g:chronos_SamplingInterval
            return
        endif
    endif

    let s:heartbeats = add(s:heartbeats, heartbeat)
endfunction

function! s:FlushHeartbeats(timer_id)
    if len(s:heartbeats) > 0
        let body = json_encode(s:heartbeats)
        let job = job_start(['curl', '--silent', '--max-time', '5', '-H', 'Content-Type: application/json', '-d', body, g:chronos_Url])

        let s:heartbeats = []
    endif
endfunction

augroup Chronos
    autocmd BufEnter,VimEnter * call s:RecordActivity()
    autocmd CursorMoved,CursorMovedI * call s:RecordActivity()
    autocmd BufWritePost * call s:RecordActivity()
    if exists('##QuitPre')
        autocmd QuitPre * call s:FlushHeartbeats()
    endif
augroup END

call timer_start(g:chronos_FlushInterval * 1000, function('s:FlushHeartbeats'), {'repeat': -1})

if s:wildignore != ""
    let &wildignore = s:wildignore
endif

let &cpo = s:old_cpo