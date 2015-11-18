import Window
import Signal exposing ((<~),(~))
import Time exposing (Time, fps)
import Keyboard exposing (KeyCode)
import Graphics.Element exposing (..)
import Set exposing (Set)

import Model exposing (..)
import View exposing (..)
import Keys exposing (..)
import Update exposing (..)


-- SIGNALS

main : Signal Element
main =
    let z = (Signal.foldp update gameState input) in
        view <~ Window.dimensions ~ z
--  Signal.map2 view Window.dimensions (Signal.foldp update gameState input)
--    show <~ input
--    Signal.map (\(x,y) -> show <| getDirection y) input
--    Signal.map view Window.dimensions

input : Signal (Time, (Set KeyCode))
input =
  Signal.sampleOn delta (Signal.map2 (,) delta Keyboard.keysDown)


delta : Signal Time
delta =
  -- Signal.map (\t -> t / 20) (fps 25)
  fps 25

-- Temporary functions

showDirection : Signal (Time,(Set KeyCode)) -> Signal Element
showDirection s = 
    Signal.map (\(x,y) -> show <| getDirection y) s



{- RESOURCES

http://opengameart.org/content/dungeon-crawl-32x32-tiles
http://opengameart.org/content/700-rpg-icons
https://www.flickr.com/photos/87249144@N08/14435512968
http://demiourgorgon.deviantart.com/art/Insect-Creature-Female-1-366735375
http://jr19759.deviantart.com/art/Swarm-307933331




-}
