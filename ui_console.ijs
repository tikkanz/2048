NB. =========================================================
NB. Console user interface for 2048 game
NB. Should work in all J front ends.

Note 'Example command to run'
  grd=: g2048Con ''
)
g2048Con_z_=: conew&'g2048con'

loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
AddonPath=. fpath_j_ loc ''

require AddonPath,'/engine.ijs'
coclass 'g2048con'
coinsert 'g2048'

create=: {{
  echo Instructions
  startNew y
}}

destroy=: codestroy
quit=: destroy

Left=: {{ left Grid }}
Right=: {{ right Grid }}
Up=: {{ up Grid }}
Down=: {{ down Grid }}

startNew=: update@new2048
endGame=: destroy@('' [ echo)

Instructions=: {{)n
=== 2048 ===
Object:
   Create the number 2048 by merging numbers.

How to play:
  When 2 numbers the same touch they merge.
  - move numbers using the commands below:
       Right__grd ''
       Left__grd ''
       Up__grd ''
       Down__grd ''
  - quit a game:
       quit__grd ''
  - start a new game:
       grd=: g2048Con ''
}}

NB. Auto-run UI
NB. =========================================================
cocurrent 'base'
grd=: g2048Con ''
