module Input where

import Keyboard
import Time exposing (fps)
import Signal exposing (map, map2, sampleOn)

import Types exposing (Input)


input : Signal Input
input =
    let
        packInput dt dir =
          { dir = dir
          , dt = dt
          }

        delta = map (\t -> t/20) (fps 60)

    in
        sampleOn delta (map2 packInput delta Keyboard.arrows)
