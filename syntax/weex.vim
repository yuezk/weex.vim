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

" highlight weex template|script|style start tag
syn region weexStartTag start=+<\(template\|script\|style\)+ end=+>+ fold contains=htmlString,htmlArg,htmlTagN
" highlight weex template|script|style end tag
syn region weexEndTag start=+</\(template\|script\|style\)+ end=+>+ contains=htmlTagN

" highlight template contents
syn include @HTML syntax/html.vim
unlet b:current_syntax
syntax region template keepend start=+^<template\_[^>]*>+ end=+^</template>+ contains=@HTML fold

" highlight script contents
syntax include @JS syntax/javascript.vim
unlet b:current_syntax
syntax region script keepend start=+^<script\_[^>]*>+ end=+^</script>+me=s-1 contains=@JS,weexStartTag fold

" highlight style contents
syntax include @CSS syntax/css.vim
unlet b:current_syntax
syntax region style keepend start=+^<style\_[^>]*>+ end=+</style>+me=s-1 contains=@CSS,weexStartTag fold

"
" " {{}} syntax
" syntax region weexNormalInside matchgroup=weexBraces start=/\({\)\@<!{{\([{!%]\)\@!\~\?/ end=/\~\?\([%}]\)\@<!}}\(}\)\@!/ containedin=template,htmlString
" " 操作符
" syn match weexOperators '[-+*/=.><%,]' contained containedin=weexNormalInside
"
"

command! -nargs=+ HtmlHiLink hi def link <args>

" template script style 标签高亮
HtmlHiLink weexStartTag htmlTag
HtmlHiLink weexEndTag htmlTag
" 大括号部分高亮
" {{ }}
HtmlHiLink weexBraces Special
" 操作符高亮
HtmlHiLink weexOperators Operator

let b:current_syntax = "weex"
delcommand HtmlHiLink
