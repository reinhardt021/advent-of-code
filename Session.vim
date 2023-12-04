let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Downloads/misc/ADVENT-OF-CODE
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 README.md
badd +0 create-aoc-dirs.sh
badd +1 mk-files.sh
badd +1 2022-1201/README.md
badd +1 2022-1201/main.rb
badd +1 2022-1213/README_13.md
badd +1 2022-1213/main_13a.rb
badd +1 2022-1212/README_12.md
badd +1 2022-1212/main_12a.rb
badd +1 2022-1212/input_12a.txt
badd +0 2022-1212/input_12b.txt
badd +2 2022-1212/main_12b.rb
badd +0 .gitignore
badd +1 2023-1201/README_01.md
badd +1 2023-1201/main_01a.rb
badd +1 2023-1201/input_01a.txt
badd +0 2023-1201/input_01b.txt
argglobal
%argdel
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit README.md
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 1resize ' . ((&columns * 50 + 75) / 150)
exe '2resize ' . ((&lines * 18 + 20) / 41)
exe 'vert 2resize ' . ((&columns * 50 + 75) / 150)
exe 'vert 3resize ' . ((&columns * 49 + 75) / 150)
exe 'vert 4resize ' . ((&columns * 49 + 75) / 150)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 18 - ((16 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 18
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify(".gitignore", ":p")) | buffer .gitignore | else | edit .gitignore | endif
if &buftype ==# 'terminal'
  silent file .gitignore
endif
balt README.md
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("create-aoc-dirs.sh", ":p")) | buffer create-aoc-dirs.sh | else | edit create-aoc-dirs.sh | endif
if &buftype ==# 'terminal'
  silent file create-aoc-dirs.sh
endif
balt mk-files.sh
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 12 - ((11 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 12
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("mk-files.sh", ":p")) | buffer mk-files.sh | else | edit mk-files.sh | endif
if &buftype ==# 'terminal'
  silent file mk-files.sh
endif
balt create-aoc-dirs.sh
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe '1resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 1resize ' . ((&columns * 50 + 75) / 150)
exe '2resize ' . ((&lines * 18 + 20) / 41)
exe 'vert 2resize ' . ((&columns * 50 + 75) / 150)
exe 'vert 3resize ' . ((&columns * 49 + 75) / 150)
exe 'vert 4resize ' . ((&columns * 49 + 75) / 150)
tabnext
edit 2022-1212/README_12.md
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 50 + 75) / 150)
exe '2resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 2resize ' . ((&columns * 49 + 75) / 150)
exe '3resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 3resize ' . ((&columns * 49 + 75) / 150)
exe '4resize ' . ((&lines * 18 + 20) / 41)
exe 'vert 4resize ' . ((&columns * 99 + 75) / 150)
argglobal
balt 2022-1213/main_13a.rb
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 120 - ((15 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 120
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("2022-1212/input_12a.txt", ":p")) | buffer 2022-1212/input_12a.txt | else | edit 2022-1212/input_12a.txt | endif
if &buftype ==# 'terminal'
  silent file 2022-1212/input_12a.txt
endif
balt 2022-1212/main_12a.rb
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 2 - ((1 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("2022-1212/input_12b.txt", ":p")) | buffer 2022-1212/input_12b.txt | else | edit 2022-1212/input_12b.txt | endif
if &buftype ==# 'terminal'
  silent file 2022-1212/input_12b.txt
endif
balt 2022-1212/input_12a.txt
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("2022-1212/main_12a.rb", ":p")) | buffer 2022-1212/main_12a.rb | else | edit 2022-1212/main_12a.rb | endif
if &buftype ==# 'terminal'
  silent file 2022-1212/main_12a.rb
endif
balt 2022-1212/main_12b.rb
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 50 + 75) / 150)
exe '2resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 2resize ' . ((&columns * 49 + 75) / 150)
exe '3resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 3resize ' . ((&columns * 49 + 75) / 150)
exe '4resize ' . ((&lines * 18 + 20) / 41)
exe 'vert 4resize ' . ((&columns * 99 + 75) / 150)
tabnext
edit 2023-1201/README_01.md
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 50 + 75) / 150)
exe '2resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 2resize ' . ((&columns * 49 + 75) / 150)
exe '3resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 3resize ' . ((&columns * 49 + 75) / 150)
exe '4resize ' . ((&lines * 18 + 20) / 41)
exe 'vert 4resize ' . ((&columns * 99 + 75) / 150)
argglobal
balt 2022-1212/README_12.md
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("2023-1201/input_01a.txt", ":p")) | buffer 2023-1201/input_01a.txt | else | edit 2023-1201/input_01a.txt | endif
if &buftype ==# 'terminal'
  silent file 2023-1201/input_01a.txt
endif
balt 2023-1201/main_01a.rb
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("2023-1201/input_01b.txt", ":p")) | buffer 2023-1201/input_01b.txt | else | edit 2023-1201/input_01b.txt | endif
if &buftype ==# 'terminal'
  silent file 2023-1201/input_01b.txt
endif
balt 2023-1201/input_01a.txt
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("2023-1201/main_01a.rb", ":p")) | buffer 2023-1201/main_01a.rb | else | edit 2023-1201/main_01a.rb | endif
if &buftype ==# 'terminal'
  silent file 2023-1201/main_01a.rb
endif
balt 2023-1201/README_01.md
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 50 + 75) / 150)
exe '2resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 2resize ' . ((&columns * 49 + 75) / 150)
exe '3resize ' . ((&lines * 19 + 20) / 41)
exe 'vert 3resize ' . ((&columns * 49 + 75) / 150)
exe '4resize ' . ((&lines * 18 + 20) / 41)
exe 'vert 4resize ' . ((&columns * 99 + 75) / 150)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
