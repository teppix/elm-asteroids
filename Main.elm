import Graphics.Element exposing (Element)
import Graphics.Collage exposing (collage)

import Types exposing (Gamestate, Player, Particle, Asteroid, Input)
import Helpers exposing (collide)
import Input exposing (input)

import Background
import Particles
import Asteroids
import Player


initialGamestate : Gamestate
initialGamestate =
  { particles = Particles.init
  , lasers    = Particles.init
  , asteroids = Asteroids.init
  , player    = Player.init
  }

spawnParticles : Gamestate -> List Particle
spawnParticles gs =
  if (List.length gs.particles) < 60
    then Particles.explosion gs.player.position
    else []

spawnLasers : Gamestate -> Input -> List Particle
spawnLasers gs input = []

update : Input -> Gamestate -> Gamestate
update input gs =
  let
      -- extract all asteroid positions
      asteroidPositions = List.map .position gs.asteroids

      -- check if player collide with any asteroids
      collided          = List.any (collide 15 gs.player.position) asteroidPositions

      -- generate particles for player explosion (if needed)
      playerExplosion   = if collided
                             then Particles.explosion gs.player.position
                             else [] 

      -- simulate existing particles
      updatedParticles = Particles.update gs.particles input.dt

  in
    { gs | particles <- playerExplosion ++ updatedParticles
         , asteroids <- Asteroids.update gs.asteroids input.dt
         , lasers <- Particles.update gs.lasers input.dt
         , player <- if collided
                        then Player.init
                        else Player.update gs.player input
    }


-- GRAPHICS --

view : Gamestate -> Element
view gamestate =
    collage 400 400
        [ Background.draw
        , Particles.draw gamestate.particles
        , Asteroids.draw gamestate.asteroids
        , Player.draw gamestate.player
        ]

-- SIGNALS --

main : Signal Element
main = Signal.map view <| Signal.foldp update initialGamestate input

