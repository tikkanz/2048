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

BColors=: <;.1 , ];._2 noun define
#cdc1b4#ffe4c3#fff4d3#ffdac3
#e7b08e#e7bf8e#ffc4c3#e7948e
#be7e56#be5e56#9c3931#701710
)
FColor=: <'#333333'
Tblsz=: 400

NB. Form definitions
NB. =========================================================
MSWD=: 0 : 0
pc mswd nosize escclose closeok;pn "2048";
menupop "&Game";
menu new "&New Game";
menusep;
menu exit "&Quit";
menupopz;
menupop "&Direction";
menu leftm "Left" "Ctrl+a";
menu rightm "Right" "Ctrl+d";
menu upm "Up" "Ctrl+w";
menu downm "Down" "Ctrl+s";
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
  startnew y
  wd 'pshow'
)

destroy=: 3 : 0
  wd 'pclose'
  codestroy ''
)

mswd_exit_button=: destroy
mswd_close=: destroy
mswd_cancel=: destroy

fmt_table=: 3 :0
  wd 'set g shape ',": Gridsz
  wd 'set g type ',":, 0 $~ Gridsz
  wd 'set g align ', ": 1 $~ {: Gridsz
  wd 'set g font SansSerif 20 bold'
  wd 'set g protect ',":, 1 $~ Gridsz
  wd 'set g nofocus'
  showGrid''
  Grid
)

showGrid=: 3 :0
  wd 'psel ', MSWD_hwnd
  tbl=. (Grid=0)} (8!:0 Grid) ,: <'""'
  wd 'set g data *', ' ' joinstring ,tbl
  bkgrd=. BColors {~ (* __&~:)@(%&^. 2:) ,Grid
  wd 'set g color ', ' ' joinstring , bkgrd ,. FColor
  wd 'set g colwidth ',": <.4 %~ Tblsz - 1
  wd 'set g rowheight ',": <.4 %~ Tblsz - 1
)

startnew=: update@fmt_table@new2048

update=: 3 : 0
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
  wd 'psel ', MSWD_hwnd
  wd 'set g minwh ',": 2#Tblsz
)

mswd_left_button=: 3 :'mergerow toLeft move (scorerow toLeft)'
mswd_right_button=: 3 :'mergerow toRight move (scorerow toRight)'
mswd_up_button=: 3 :'mergerow toUp move (scorerow toUp)'
mswd_down_button=: 3 :'mergerow toDown move (scorerow toDown)'

mswd_leftm_button=: mswd_left_button
mswd_rightm_button=: mswd_right_button
mswd_upm_button=: mswd_up_button
mswd_downm_button=: mswd_down_button

mswd_new_button=: startnew
mswd_about_button=: sminfo bind ('About 2048';About)
mswd_help_button=: sminfo bind ('Minesweeper Instructions';Instructions)

NB. Text Nouns
NB. =========================================================

Instructions=: noun define
=== 2048 ===
Object:
   Create the number 2048 by merging numbers.

How to play:
  When 2 numbers the same touch, they merge.
  Continue merging until you create the number
  2048, or you cannot move any more.
  Move numbers in a direction using the buttons,
  or the commands on the Direction menu.
)

About=: noun define
2048 Game
Author: Ric Sherlock

Uses Qt Window Driver for GUI
)

NB. Auto-run UI
NB. =========================================================
cocurrent 'base'
g2048Wd ''