NB. 2048 game engine
NB. Used by the various User Interfaces (ui*.ijs) scripts

NB. When loaded the script should randomly set the random seed otherwise
NB. the same sequence of new numbers will result in each fresh J session.
3 : 0 ''
 try.
   require 'guid'
   tmp=. _2 (3!:4) , guids 1
 catch.             NB. general/misc/guid.ijs not available
   tmp=. >:<.0.8*0 60 60 24 31#.0 0 0 0 _1+|.<.}.6!:0 ''
 end.
 ([ 9!:1) tmp       NB. set random initial random seed
)

coclass 'g2048'

new2048=: verb define
  Points=: Score=: 0
  Grid=: newnum^:2 ] 4 4 $ 0
)

newnum=: verb define
  num=. ,/ 2 4 {~ 0.1 > ?0   NB. 10% chance of 4
  idx=. 4 $. $. 0 = y        NB. indicies of 0s
  if. #idx do.               NB. handle full grid
    idx=. ,/ ({~ 1 ? #) idx  NB. choose an index
    num (<idx)} y
  else. return. y
  end.
)

mskmerge=: [: >/\.&.|. 2 =/\ ,&_1
mergerow=: ((* >:) #~ _1 |. -.@]) mskmerge
scorerow=: +/@(+: #~ mskmerge)

compress=: -.&0
mergeleft=: 4&{.@(mergerow@compress&.|.)"1
mergeright=: _4&{.@(mergerow@compress)"1
mergeup=: (4&{.@(mergerow@compress&.|.)"1)&.|:
mergedown=: (_4&{.@(mergerow@compress)"1)&.|:

scoreleft=: [: +/ (scorerow@compress&.|.)"1
scoreright=: [: +/ (scorerow@compress)"1
scoreup=: [: +/ ((scorerow@compress&.|.)"1)&.|:
scoredown=: [: +/ ((scorerow@compress)"1)&.|:

noMoves=: (0 -.@e. ,)@(mergeright , mergeleft , mergeup ,: mergedown)
hasWon=: 2048 e. ,

eval=: verb define
  Score=: Score + Points
  isend=. (noMoves , hasWon) y
  msg=. isend # 'You lost!!';'You Won!!'
  if. -. isend=. +./ isend do.
    Points=: 0
    msg=. 'Score is ',(": Score)
  end.
  isend;msg
)

showGrid=: verb define
  echo y
)
