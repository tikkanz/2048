NB. 2048 game engine
NB. Used by the various User Interfaces (ui*.ijs) scripts

NB. When loaded the script should randomly set the random seed otherwise
NB. the same sequence of new numbers will result in each fresh J session.
verb define ''
 try.
   require 'guid'
   tmp=. _2 (3!:4) , guids 1
 catch.             NB. general/misc/guid.ijs not available
   tmp=. >:<.0.8*0 60 60 24 31#.0 0 0 0 _1+|.<.}.6!:0 ''
 end.
 ([ 9!:1) tmp       NB. set random initial random seed
)

coclass 'g2048'
Target=: 2048

new2048=: verb define
  Gridsz=: 4 4
  Score=: 0
  Grid=: newnum^:2 ] Gridsz $ 0
  Grid;0                     NB. return grid and points
)

newnum=: verb define
  num=. 2 4 {~ 0.1 > ?0      NB. 10% chance of 4
  idx=. 4 $. $. 0 = y        NB. indicies of 0s
  if. #idx do.               NB. handle full grid
    idx=. ,/ ({~ 1 ? #) idx  NB. choose an index
    num (<idx)} y
  else. return. y
  end.
)

compress=: -.&0
mskmerge=: [: >/\.&.|. 2 =/\ ,&_1
mergerow=: 4 {. (((* >:) #~ _1 |. -.@]) mskmerge)@compress
scorerow=: +/@(+: #~ mskmerge)@compress

byrow=: "1
toLeft=:  byrow
toRight=: byrow&.(|."1)
toUp=:    byrow&.|:
toDown=:  byrow&.(|.@|:@|.)

processMove=: {{ ((] spawn@]^:(-.@-:) u) ; [: +/@, v) }}
move=: update@processMove

NB. move=: {{
NB.   (grid , score) =. y
NB.   NewGrid =. (] spawn^:(-.@-:) u ) Grid
NB.   NewScore =. Score + ([: +.@, v) Grid
NB.   NewGrid ; NewScore
NB. }}

left=: (mergerow toLeft) move (scorerow toLeft)
right=: (mergerow toRight) move (scorerow toRight)
up=: (mergerow toUp) move (scorerow toUp)
down=: (mergerow toDown) move (scorerow toDown)

noMoves=: (0 -.@e. ,)@(mergerow toRight , mergerow toLeft , mergerow toUp ,: mergerow toDown)
hasWon=: Target e. ,

update=: verb define
  'grid points'=. y
  Grid=: grid              NB. update global Grid
  Score=: Score + points   NB. update global Score
  showGrid grid
  showScore 'Score: ',(": Score)
  if. +./ isend=. (noMoves , hasWon) grid do.
    endGame isend # 'You lost!!';'You Won!!'
  end.
  empty''
)

endGame=: showScore=: showGrid=: echo
