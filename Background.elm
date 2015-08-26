module Background where

import Color exposing (rgb)
import Graphics.Collage exposing (rect, filled)

-- TODO: starfields and stuff!
draw = rect 400 400 |> filled (rgb 0 0 20)
