module Helpers where

import Types exposing (Point, Vector)


tovec : Point -> Vector
tovec pt = (toFloat pt.x, toFloat pt.y)


addvec : Vector -> Vector -> Vector
addvec (x1, y1) (x2, y2) = (x1+x2, y1+y2)


mulvec : Vector -> Float -> Vector
mulvec (x, y) s = (x*s, y*s)


rotvec : Float -> Vector -> Vector
rotvec a (x, y) =
    ( x*(cos a) - y*(sin a)
    , x*(sin a) + y*(cos a)
    )

distance : Vector -> Vector -> Float
distance (x1, y1) (x2, y2) = sqrt( (x1-x2)^2 + (y1-y2)^2 )


collide : Float -> Vector -> Vector -> Bool
collide threshold v1 v2 = distance v1 v2 < threshold


wrapAround : Vector -> Vector
wrapAround (x, y) =
    let wrapAxis v =
        if v > 200 then v-400
           else if v < -200 then v + 400
                   else v

    in
       (wrapAxis x, wrapAxis y)
