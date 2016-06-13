NB. Qt wd GUI for 2048 game

Note 'Example commands to run'
  g2048Wd ''
)

g2048Wd_z_=: 3 : 0
  a=. conew 'g2048wd'
  create__a y
)

AddonPath=: jpath '~ProjectsGit/g2048/'

require AddonPath,'engine.ijs'
coclass 'g2048wd'
coinsert 'g2048'

NB. Form definitions
NB. =========================================================
MSWD=: 0 : 0
pc mswd nosize escclose closeok;pn "2048";
menupop "&Game";
menu new "&New Game";
menusep;
menu exit "&Quit";
menupopz;
menupop "&Help";
menu help "&Instructions";
menu about "&About";
menupopz;

cc g table;
bin vhs;
cc up button;cn Up;
bin szhs;
cc left button; cn Left;
cc right button; cn Right;
bin szhs;
cc down button;cn Down;
bin szz;
cc sbar statusbar;
)

NB. Methods
NB. =========================================================
create=: 3 : 0
  wd MSWD
  NB. need unique handle for mswd window to handle multiple instances of class
  MSWD_hwnd=: wd 'qhwndp'  NB. assign hwnd this for mswd in instance locale
  mswd_startnew y
  wd 'pshow'
)

destroy=: 3 : 0
  wd 'pclose'
  codestroy ''
)

mswd_exit_button=: destroy
mswd_close=: destroy
mswd_cancel=: destroy

mswd_g_fmttable=: 3 :0
  wd 'set g shape ',": Gridsz
  wd 'set g type ',":, 0 $~ Gridsz
  wd 'set g align ', ": 1 $~ {: Gridsz
  wd 'set g font Consolas 20'
  wd 'set g protect ',":, 1 $~ Gridsz
  wd 'set g nofocus'
  showGrid''
  Grid
)

showGrid=: 3 :0
  wd 'psel ', MSWD_hwnd
  tbl=. (Grid=0)} (8!:0 Grid) ,: <'""'
  wd 'set g data *', ' ' joinstring ,tbl
  wd 'set g colwidth ',": <.4 %~ 400 - 1
  wd 'set g rowheight ',": <.4 %~ 400 - 1
)

mswd_startnew=: mswd_update@mswd_fmttable@new2048

mswd_update=: 3 : 0
  Grid=: y       NB. update global Grid
  'isend msg'=. eval Grid
  mswd_resize''
  showGrid Grid
  if. isend do.
    wdinfo msg
  else.
    wd 'set sbar show "',msg,'"'
    empty''
  end.
)

mswd_resize=: 3 : 0
  isisz=. 400 400
  wd 'psel ', MSWD_hwnd
  wd 'set g minwh ',": isisz
)

move=: conjunction define
  Points=: v Grid
  mswd_update newnum^:(Grid -.@-: ]) u Grid
)

mswd_left_button=: verb def 'mergeleft move scoreleft'
mswd_right_button=: verb def 'mergeright move scoreright'
mswd_up_button=: verb def 'mergeup move scoreup'
mswd_down_button=: verb def 'mergedown move scoredown'

mswd_new_button=: 3 :0
  mswd_startnew ''
)

mswd_about_button=: 3 : 0
    sminfo 'About 2048';About
)

mswd_help_button=: 3 : 0
    sminfo 'Minesweeper Instructions';Instructions
)

NB. Text Nouns
NB. =========================================================

Instructions=: noun define
=== 2048 ===
Object:
   Create the number 2048 by merging numbers.

How to play:
  When 2 numbers the same touch they merge.
  Continue until you create the number 2048
  or you cannot move any more.
)

About=: 0 : 0
2048 Game
Author: Ric Sherlock

Uses Qt Window Driver for GUI
)

NB. Auto-run UI
NB. =========================================================
cocurrent 'base'
g2048Wd ''
  