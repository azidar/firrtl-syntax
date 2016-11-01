# firrtl-syntax
Vim syntax highlighting for Firrtl files.

To install, first clone this repository:
```
git clone git@github.com:azidar/firrtl-syntax.git
```

Then, link the syntax and ftdetect files into your `~/.vim` directory:
```
cd firrtl-syntax
mkdir -p ~/.vim/syntax
mkdir -p ~/.vim/ftdetect
ln syntax/firrtl.vim ~/.vim/syntax/firrtl.vim
ln ftdetect/firrtl.vim ~/.vim/ftdetect/firrtl.vim
```
You will need to restart vim to see the changes.
