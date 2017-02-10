" Vim syntax file
" Language: Weex
" Maintainer: Kevin Yue <yuezk001@gmail.com> 

if exists("b:current_syntax")
  finish
endif

" highlight weex build-in components
syn keyword htmlTagName contained template indicator switch text web image list cell refresh loading scroller slider container
" highlight custom element
syn match htmlTagName contained +\<[a-z][-.0-9_a-z]*\(-[-.0-9_a-z]*\)*\>+
syn region weexComponent start=+<+ end=+>+ contains=htmlString,htmlArg,htmlTagN fold 

" highlight template contents
syn include @HTML syntax/html.vim
unlet b:current_syntax
syn region html keepend start=+<template\_[^>]*>+ end=+</template>+ contains=@HTML,weexTag fold

" highlight script contents
syn include @JS syntax/javascript.vim
unlet b:current_syntax
syn region javascript keepend start=+<script\_[^>]*>+ end=+</script>+me=s-1 contains=@JS,weexTag fold

" highlight style contents
syn include @CSS syntax/css.vim
unlet b:current_syntax
syn region css keepend start=+<style\_[^>]*>+ end=+</style>+me=s-1 contains=@CSS,weexTag fold

" highlight weex template|script|style start tag
syn region weexTag contained start=+<\(template\|style\|script\)+ end=+>+ contains=htmlString,htmlArg,htmlTagN fold 
" highlight weex template|script|style end tag
syn match weexEndTag +</\(template\|script\|style\)>+ contains=htmlTagN

" {{ variable }} syntax
syn region weexNormalInside matchgroup=weexBraces start=+\({\)\@<!{{\([{!%]\)\@!\~\?+ end=+\~\?\([%}]\)\@<!}}\(}\)\@!+ contained containedin=html,htmlString,htmlValue,htmlEvent contains=@JS

command! -nargs=+ HtmlHiLink hi def link <args>

" highlight template script style tag use htmlTag
HtmlHiLink weexTag htmlTag
HtmlHiLink weexEndTag htmlTag
HtmlHiLink weexComponent htmlTag
" highlight {{ }}
HtmlHiLink weexBraces Special

let b:current_syntax = "weex"
delcommand HtmlHiLink
