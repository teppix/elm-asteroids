module Types where

type Sfx = NoSfx | LaserSfx | HitSfx | CrashSfx | SpawnSfx

type alias Vector = (Float, Float)

type alias Point = { x: Int, y: Int }


type alias Input =
    { dir : Point -- arrow key status
    , dt  : Float -- delta time
    }


type Event = EvNone | EvSound Sfx


type alias Gamestate =
    { particles : List Particle
    , lasers    : List Particle
    , asteroids : List Asteroid
    , player    : Player
    , events    : List Event
    }


type alias Player =
    { position : Vector
    , speed    : Vector
    , angle    : Float
    }


type alias Particle =
    { position : Vector
    , speed    : Vector
    , life     : Float
    }


type alias Asteroid =
    { position : Vector
    , speed    : Vector
    , angle    : Float
    }
