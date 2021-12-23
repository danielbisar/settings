i           insert
a           append
o           open new line under cursor
c motion    change (delete everything from cursor until where the cursor would 
            move based on the value of motion and place you in insert mode)

u           undo
U           Undo a whole line
ctrl-r      redo

ctrl-o      move to last position
ctrl-i      move to next position

x           delete letter
d motion    delete with motion
dd          delete whole line
p           put (with dd pressed before, the line will be inserted under the current line)

motions
=========

h,l         left, right
j,k         down, up

w           beginning of next word
e           end of word (or of next word, if cursor is already at the end of a word)
b           beginning of word
0           beginning of line
$           end of line
gg          move to beginning of file
G           move to end of file
n G         move to line (n=number)

n motion    n=number, execute motion n times, can be combined with operators

search
=========

/PATTERN    search forward
?PATTERN    search backward
n           next
N           previous (search backward)
..\c        search case insensitive
..\C        search case sensitive


