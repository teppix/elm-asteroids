module Asteroids where

import Types exposing (..)
import Graphics.Collage exposing (..)
import Color exposing (..)


-- INIT

defaultAsteroid =
  { position = ()
  , speed = (0,0)
  , angle = 0
  }

init : List Asteroid
init =
  [ { defaultAsteroid | position <- (-120, 80) }
  , { defaultAsteroid | position <- ( -65, 110) }
  , { defaultAsteroid | position <- (   0, 120) }
  , { defaultAsteroid | position <- (  65, 110) }
  , { defaultAsteroid | position <- ( 120, 80) }
  ]


-- UPDATE

update asteroids dt =
  let
      upd a = { a | angle <- a.angle + dt * 0.1 }
  in
     List.map upd asteroids


-- GRAPHICS

asteroidStyle = solid white -- { defaultLine | color = white }

draw : List Asteroid -> Form
draw asteroids =
  let
    dr a = move a.position <| rotate a.angle <| traced asteroidStyle <| ngon 5 13
  in
    group <| List.map dr asteroids
