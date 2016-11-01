" Vim syntax file
" Language:    Firrtl (http://www.github.com/ucb-bar/firrtl)
" Maintainers: Adam Izraelevitz
" Last Change: 2016 November 1

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" A node declaration, DefNode
" E.g.:   node x = y
syntax match firrtlNodeOperator "\v\=" contained
syntax keyword firrtlNodeKeyword node contained
syntax match firrtlNode "\v^\s+node\s+\w+\s+\=\s+.*$" contains=firrtlNodeKeyword,firrtlNodeOperator

" Both connection statements, Connect and PartialConnect
" E.g.:   x <= y
" E.g.:   x <- y
syntax match firrtlConnectOperator "\v\<[\=\-]" contained
syntax match firrtlConnect "\v^\s+.+\s+\<[\=\-]\s+.*$" contains=firrtlConnectOperator

" The invalidate statement, IsInvalid
" E.g.:   x is invalid
syntax match firrtlInvalidOperator "\vis\sinvalid" contained
syntax match firrtlInvalid "\v^\s+.+\s+is\sinvalid\s*.*$" contains=firrtlInvalidOperator

" Many statement/port declarations, as well as when/else
" E.g.:   wire x : UInt<1>
syntax keyword firrtlDecKeyword output input wire cmem smem when else contained
syntax match firrtlDec "\v^\s+(output|input|wire|cmem|smem|when|else)\s+\w+\s+\:\s+.*$" contains=firrtlDecKeyword,firrtlColon

" Register declaration, DefRegister
" E.g.:   reg x : UInt<1>, clock with : (reset => (r, i))
syntax match firrtlRegSpecialKeywords "\v(with|reset \=\>)" contained
syntax match firrtlRegSpecial "\v(with\s+\:|reset\s+\=\>)" contains=firrtlRegSpecialKeywords,firrtlColon containedin=firrtlReg
syntax keyword firrtlRegKeyword reg contained
syntax match firrtlReg "\v^\s+reg\s+\w+\s+\:\s+.*$" contains=firrtlDecKeyword,firrtlColon,firrtlRegSpecial,firrtlRegKeyword

" Memory port declarations, MPort
" E.g.:   infer mport x = mem[addr]
syntax keyword firrtlMPortDir infer read write rdwr contained
syntax keyword firrtlMPortKeyword mport contained
syntax match firrtlMPort "\v^\s+(infer|read|write|rdwr)\s+mport\s+\w+\s+\=\s+.*$" contains=firrtlMPortKeyword,firrtlNodeOperator,firrtlMPortDir

" Simulation statements, Print and Stop
" E.g.:   printf(clock, UInt<1>(1), "Assertion failed"
" E.g.:   stop(clock, UInt<1>(1), 1)
syntax keyword firrtlSim printf stop contained

" Empty statement, EmptyStmt
" E.g.:   skip
syntax keyword firrtlSkipKeyword skip contained
syntax match firrtlSkip "\v^\s+skip\s.*$" contains=firrtlSkipKeyword

" Circuit/module declarations
" E.g.: circuit Top :
" E.g.:   module Top :
syntax keyword firrtlCircuit circuit nextgroup=firrtlName skipwhite
syntax keyword firrtlModule module nextgroup=firrtlName skipwhite
syntax match firrtlName "[^ =:;([]\+" contained nextgroup=firrtlColon skipwhite

" Match colon
syntax match firrtlColon "\v\:" contained

"===== Primops ====
syntax keyword firrtlPrimOp    add sub mul div mod contained
syntax keyword firrtlPrimOp    eq neq geq gt leq lt contained
syntax keyword firrtlPrimOp    dshl dshr shl shr contained
syntax keyword firrtlPrimOp    not and or xor andr orr xorr contained
syntax keyword firrtlPrimOp    neg cvt contained
syntax keyword firrtlPrimOp    asUInt asSInt asClock contained
syntax keyword firrtlPrimOp    pad cat bits head tail contained
syntax keyword firrtlPrimOp    mux validif contained
syntax match firrtlDoPrim "\v[a-z][a-zA-Z]+\(" contains=firrtlPrimOp,firrtlSim containedin=firrtlConnect,firrtlInvalid,firrtlNode,firrtlDec,firrtlReg,firrtlSim

"===== Types ====
syntax keyword firrtlFlip flip contained
syntax match firrtlGroundType "\v[US]Int(\<[0-9]+\>)?(\[[0-9]+\])*" containedin=firrtlBundleType,firrtlDec,firrtlReg
syntax match firrtlGroundType "\v(Clock|Analog)(\[[0-9]+\])*" containedin=firrtlBundleType,firrtlDec,firrtlReg
syntax match firrtlVectorType "\v(\[[0-9]+\])+" contained containedin=firrtlDec,firrtlReg
syntax region firrtlBundleType matchgroup=Type start=/\v\{/ end=/\v\}/ contains=firrtlBundleType,firrtlFlip,firrtlGroundType,firrtlVectorType containedin=firrtlDec,firrtlReg
syntax region firrtlLiteral matchgroup=Identifier start=+[US]Int<[0-9]*>(+ start=+[US]Int(+ end=+)+ containedin=firrtlNode,firrtlConnect,firrtlInvalid,firrtlDec,firrtlReg,firrtlMPort

"===== Other Primitives =====
syntax match firrtlComment "\v;.*$" containedin=firrtlConnect,firrtlInvalid,firrtlNode,firrtlDec,firrtlReg,firrtlMPort,firrtlSim,firrtlSkip
syntax match firrtlInfo "\v\@\[\p+ [0-9]+\:[0-9]+\]" containedin=firrtlNode,firrtlInvalid,firrtlConnect,firrtlDec,firrtlReg,firrtlMPort,firrtlSim,firrtlSkip
syntax region firrtlString start=/\v"/ skip=/\v\\./ end=/\v"/ containedin=firrtlLiteral,firrtlPrintf,firrtlDec,firrtlReg,firrtlMPort,firrtlSim
syntax match firrtlNumber "\v<\d+>" containedin=firrtlConnect,firrtlInvalid,firrtlNode,firrtlDec,firrtlReg,firrtlMPort,firrtlSim,firrtlLiteral

"===== Links =====
" Types
highlight link firrtlGroundType Type
highlight link firrtlVectorType Type
highlight link firrtlBundleBraces Type
highlight link firrtlFlip Keyword

" Expressions, comments, info, number, string
highlight link firrtlPrimOp Function
highlight link firrtlComment Comment
highlight link firrtlInfo Comment
highlight link firrtlNumber Number
highlight link firrtlString String

" Statements and associated keywords
highlight link firrtlSkipKeyword Statement
highlight link firrtlSim Statement
highlight link firrtlMPortDir Special
highlight link firrtlMPortKeyword Keyword
highlight link firrtlRegSpecialKeywords Keyword
highlight link firrtlRegKeyword Keyword
highlight link firrtlColon Statement
highlight link firrtlDecKeyword Statement
highlight link firrtlInvalidOperator Statement
highlight link firrtlConnectOperator Statement
highlight link firrtlNodeKeyword Statement
highlight link firrtlNodeOperator Statement
highlight link firrtlCircuit Keyword
highlight link firrtlModule Keyword
highlight link firrtlName Special
