# Terdbox

A degenerate fork of termbox. The most notable difference in the API is that 
support for mouse and the mod1 (ALT) modifiers is absent, and so there is only 
one input mode.

### Why? 

Because mouse input in a terminal is goofy, nobody needs 400 hotkeys, and
the way handling of the ALT modifier worked lead to inconsistent and sensless
overlap between hotkeys i don't need and bare escape.

## Getting started
Terdbox's interface only consists of ~~12~~ 11 functions:
```c
tb_init() // initialization
tb_shutdown() // shutdown

tb_width() // width of the terminal screen
tb_height() // height of the terminal screen

tb_clear() // clear buffer
tb_present() // sync internal buffer with terminal

tb_put_cell()
tb_change_cell()
tb_blit() // drawing functions

tb_peek_event() // peek a keyboard event
tb_poll_event() // wait for a keyboard event
```
See src/terdbox.h header file for full detail.

## TL;DR

`make` to build a static version of the lib under lib/libterdbox.a

`make install` with sufficient privileges to install header and library in `$PREFIX`
