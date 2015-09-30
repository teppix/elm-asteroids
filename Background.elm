module Background where

import Color exposing (rgb)
import Graphics.Collage exposing (Form, rect, filled)


draw : Form
draw = rect 400 400 |> filled (rgb 0 0 20)
