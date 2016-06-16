" Vim syntax file
" Language: Weex
" Maintainer: Kevin Yue <yuezk001@gmail.com> 

if exists("b:current_syntax")
  finish
endif

syntax include @HTML syntax/html.vim
unlet b:current_syntax
syntax region template matchgroup=weexTag keepend start=/^<template.\{-}>/ end=/^<\/template>/ contains=@HTML fold
" {{}} syntax
syntax region weexNormalInside matchgroup=weexBraces start=/\({\)\@<!{{\([{!%]\)\@!\~\?/ end=/\~\?\([%}]\)\@<!}}\(}\)\@!/ containedin=template,htmlString
" 操作符
syn match weexOperators '[-+*/=.><%,]' contained containedin=weexNormalInside

syntax include @JS syntax/javascript.vim
unlet b:current_syntax
syntax region script matchgroup=weexTag keepend start=/^<script>/ end=/<\/script>/ contains=@JS fold

syntax include @CSS syntax/css.vim
unlet b:current_syntax
syntax region style matchgroup=weexTag keepend start=/^<style>/ end=/<\/style>/ contains=@CSS fold

command! -nargs=+ HtmlHiLink hi def link <args>

" template script style 标签高亮
HtmlHiLink weexTag Keyword
" 大括号部分高亮
" {{ }}
HtmlHiLink weexBraces Special
" 操作符高亮
HtmlHiLink weexOperators Operator

let b:current_syntax = "weex"
delcommand HtmlHiLink
