NB. =========================================================
NB. Console user interface for 2048 game
NB. Should work in all J front ends.

Note 'Example command to run'
  grd=: g2048Con ''
)
g2048Con_z_=: conew&'g2048con'

loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
AddonPath=: fpath_j_ loc ''

require AddonPath,'/engine.ijs'
coclass 'g2048con'
coinsert 'g2048'

create=: verb define
  echo Instructions
  startNew y
)

destroy=: codestroy
quit=: destroy

startNew=: update@new2048

left=: 3 :'mergerow toLeft move (scorerow toLeft)'
right=: 3 :'mergerow toRight move (scorerow toRight)'
up=: 3 :'mergerow toUp move (scorerow toUp)'
down=: 3 :'mergerow toDown move (scorerow toDown)'

update=: verb define
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