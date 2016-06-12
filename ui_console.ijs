NB. =========================================================
NB. Console user interface for 2048 game
NB. Should work in all J front ends.

Note 'Example command to run'
  grd=: g2048Con ''
)
g2048Con_z_=: conew&'g2048con'

AddonPath=: jpath '~ProjectsGit/g2048/'

require AddonPath,'engine.ijs'
coclass 'g2048con'
coinsert 'g2048'

create=: verb define
  echo Instructions
  g2048_startnew y
)

destroy=: codestroy
quit=: destroy

g2048_startnew=: g2048con_update@new2048

move=: conjunction define
  Points=: v Grid
  g2048con_update newnum^:(Grid -.@-: ]) u Grid
)

left=: verb def 'mergeleft move scoreleft'
right=: verb def 'mergeright move scoreright'
up=: verb def 'mergeup move scoreup'
down=: verb def 'mergedown move scoredown'

g2048con_update=: verb define
  Grid=: y       NB. update global Grid
  'isend msg'=. eval Grid
  echo msg
  showGrid Grid
  if. isend do. destroy '' end.
  empty''
)

Instructions=: noun define
=== 2048 ===
Object:
   Create the number 2048 by merging numbers.

How to play:
  When 2 numbers the same touch they merge.
  - move numbers using the commands below:
       right__grd ''
       left__grd ''
       up__grd ''
       down__grd ''
  - quit a game:
       quit__grd ''
  - start a new game:
       grd=: g2048Con ''
)

NB. Auto-run UI
NB. =========================================================
cocurrent 'base'
grd=: g2048Con ''