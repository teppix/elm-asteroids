module Particles where

import Graphics.Collage exposing (LineStyle, Form, defaultLine, segment, traced, group)
import Color exposing (..)

import Types exposing (Particle, Vector)
import Helpers exposing (..)


particleLife : Float
particleLife = 40


particleLifeDelta : Float
particleLifeDelta = 30


particleCount : Int
particleCount = 80


particleColor : Color
particleColor = white


init : List Particle
init = []


explosion : Vector -> List Particle
explosion (px, py) = List.map
    (\i -> 
        let x = (cos (i*0.2)) + (cos (i*3.13)*0.15)
            y = (sin (i*0.2)) + (sin (i*3.13)*0.2)
        in
            { position = (px + x * 10, py + y * 10)
            , speed = (x*3, y*3)
            , life = particleLife + particleLifeDelta * (cos (i*1.42))
            })
    [0..(toFloat particleCount)]


particleStyle : Float -> LineStyle
particleStyle life =
    { defaultLine | color <- (particleFade particleColor life)
    , width <- 1
    }


particleFade : Color -> Float -> Color
particleFade col life =
    let
        c = toRgb col
        fade x = round <| ((toFloat x)*life)/particleLife
    in
        rgb (fade c.red) (fade c.green) (fade c.blue)


draw : List Particle -> Form
draw particles =
    let
        drawp p = segment p.position (addvec p.position (mulvec p.speed 3))
                |> traced (particleStyle p.life)
    in
        List.map drawp particles |> group


update : List Particle -> Float -> List Particle
update particles dt =
    let
      filter p = p.life > 0
      step p = { p | position <- mulvec p.speed dt |> addvec p.position
                   , life <- p.life - 1
               }
    in
      particles |> List.filter filter |> List.map step
