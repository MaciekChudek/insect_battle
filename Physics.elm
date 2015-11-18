module Physics where

import Model exposing (..) 




constants =
    { airdrag = 1
    , gnddrag = 1
    }

updatePhysics : GameState -> GameState

updateAcceleration : Entity -> Entity

updatePlayerAcceleration : Hero -> Hero

updateVelocities : GameState -> GameState

updateVelocity : Entity (Mobile a) -> Entity (Mobile a) 

updatePositions : GameState -> GameState

updatePosition : Entity (Mobile a) -> Entity (Mobile a)

updateCollisions : GameState -> GameState

-- moveEntities, by adding their velocity to their position

moveMobile : Entity (Mobile a)  -> (Float, Float) 
moveMobile {position, velocity} = 
    let (px, py) = position
        (vx, vy) = velocity
    in (px+vx, py+vy)


-- updateVelocities, arrows slow down, fireballs home in but steer badly, the user controls his guy
-- add an acceleration coefficient to projectiles
-- add a global air-drag component, which decreases acceleration so arrows start slowing down by about half way across the field
-- add logic to kill arrow when it stops (or leaves screen)
-- fireballs have constant speed, use polar coords, give them shitty steering
-- player has ground drag that stops them quickly if not running, decent steering but still some momentum
-- define steering in radians per tick
-- define drag as constant added to acceleration is direction opposite of velocity. applied before player control so helps with changing direction (skid)
-- set up walls for player...
-- define max speed, and speed multiplier for haste/slow spell.



-- detectCollisions, check if anyone's come within anyone else's collision radius. If so, switch both their collision indicators to true. 
