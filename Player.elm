module Player where

import Types exposing (Player, Input)

import Helpers exposing (..)
import Color exposing (..)

import Graphics.Collage exposing (LineStyle, Shape, Form, traced, polygon, move, rotate, defaultLine)


-- CONSTANTS

playerAcceleration : Float
playerAcceleration = 0.15


playerRotationSpeed : Float
playerRotationSpeed = 0.07



-- INIT

init : Player
init =
    { position = (0,0)
    , speed = (0,0)
    , angle = 0.0
    }


-- UPDATE

update : Player -> Input -> Player
update player input =
    let newSpeed =
        if input.dir.y > 0
        then (0, playerAcceleration) |> rotvec player.angle |> addvec player.speed
        else player.speed
    in
        { player | angle <- player.angle - (toFloat input.dir.x)*playerRotationSpeed*input.dt
            , position <- addvec player.position newSpeed |> wrapAround
            , speed <- newSpeed
        }


-- GRAPHICS

playerLineStyle : LineStyle
playerLineStyle =
    { defaultLine | color <- white
                  , width <- 1
    }


playerShape : Shape
playerShape =
    polygon [ (0, 9), (7, -9), (0, -5), (-7, -9), (0, 9) ]


draw : Player -> Form
draw p =
  playerShape
    |> traced playerLineStyle
    |> rotate p.angle
    |> move p.position

