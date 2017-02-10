" Vim indent file
" Language: Weex
" Maintainer: Kevin Yue <yuezk001@gmail.com> 

if exists('b:did_indent')
    finish
endif

" Load indent files for required languages
for language in ['css', 'javascript', 'html']
    unlet! b:did_indent
    exe 'runtime! indent/' . language . '.vim'
    exe 'let s:' . language . '_indent = &indentexpr'
endfor

let b:did_indent = 1

setlocal indentexpr=GetWeexIndent()

if exists('*GetWeexIndent')
    finish
endif

function! GetWeexIndent()
    if searchpair('<style', '', '</style>', 'bWr')
        exe 'let indent = ' . s:css_indent
    elseif searchpair('<script', '', '</script>', 'bWr')
        exe 'let indent = ' . s:javascript_indent
    else
        exe 'let indent = ' . s:html_indent
    endif
    return indent > -1 ? indent : s:html_indent
endfunction
