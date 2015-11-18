module Update where

import Keys exposing (getDirection, anyKey, newKeys, spaceKey)
import Array exposing (Array)
import Model exposing (..)
import Set exposing (Set)
import Time exposing (Time)
import Keyboard exposing (KeyCode)
import Content exposing (images,speech,locations)
import Graphics.Element exposing (image)


-- UPDATE

update : (Time, (Set KeyCode)) -> GameState -> GameState
update (delta, keys) state =
    let 
        gs = processInput keys state
    in 
        case gs.phase of
        (GamePlay x) -> if x < 0 then initialiseGame gs else gs 
--        (GamePlay x) -> if x < 0 then initialiseGame gs else gs 
--          |> moveEntities delta gs
--          |> detectCollisions gs
          |> processEffects delta  
        otherwise -> processEffects delta gs --process any time-dependent special effects 


-- init game

initialiseGame : GameState -> GameState
initialiseGame gs = --note: we use the initial data structures here. 
    let e = gs.entities
        g = e.goodie
        b = e.baddie
    in
        { gs  
        | phase <- GamePlay 0
        , entities <- {e
            |goodie <- {g 
                | display <- True
                , image <- images.models.goodie 
                }
            , baddie <- {b
                | display <- True
                , image <- images.models.baddie
                , position <- locations.top
                }
            }
        } 
        |> setBackgroundImage
        |> updateSpeech
        






-- processEffects: make spell particles happen, blow up anyone who got in a collision, etc.

processEffects : Time -> GameState -> GameState -- update any effects that change with time. Special effects, delays, etc.
processEffects t gs =
    setBackgroundImage gs
    |> updateSpeech
-- NOTE: For efficiency, any effect/projectile/etc/ that isn't in use should simply be moved off the screen... Search for existing invisible elements and reuse before creating a new one.

-- Set Background, make sure it's an Element

setBackgroundImage : GameState -> GameState
setBackgroundImage gs =
    case gs.phase of
        (Start x) -> {gs | background <- images.backgrounds.start}
        (GamePlay x) -> {gs | background <- images.backgrounds.gamePlay}
        (End x) -> {gs | background <- images.backgrounds.end}
        (Death x) -> {gs | background <- images.backgrounds.death}

-- Set text



updateSpeech : GameState -> GameState
updateSpeech gs  = 
    let s = getSpeechContext gs.phase
    in case s of
        Just a -> {gs | speech <- a}
        Nothing -> {gs | speech <- ""}

getSpeechContext : Phase -> Maybe String
getSpeechContext phase = 
    case phase of
        (Start a) -> (flip Array.get speech.start a)
        (GamePlay a) -> (flip Array.get speech.gamePlay a)
        (End a) -> (flip Array.get speech.end a)
        (Death a) -> (flip Array.get speech.death a)





-- process Keyboard input
processInput : (Set KeyCode) -> GameState -> GameState
processInput keys gs = 
    let 
        k = newKeys keys gs.keys -- diff the keys and keep only the new ones, so you need to repeatedly press them, not just hold them down.
    in
    if not <| anyKey k then -- if no new keys were pressed since the last update
       if Set.isEmpty gs.keys then gs else setDirection (getDirection keys) {gs | keys <- keys} -- we still need to remove old keys no longer in the set
    else let 
        p = if spaceKey keys then nextPhase gs.phase else gs.phase
        d = getDirection keys --note, we use the undiffed keys here, so you can keep holding down the directionkeys
        s = { gs | keys <- keys}
    in
    case p of
        (GamePlay x) -> setDirection d {s | phase <- p}
        (Start x)  -> { s | phase <- p}
        (End x) -> if x == 0 then {gameState | phase <- p } else  { s | phase <- p} -- reset to intial gamestate if we just finished play
        (Death x) -> if x == 0 then {gameState | phase <- p } else  { s | phase <- p} -- reset to intial gamestate if we just finished play


setDirection : Direction -> GameState -> GameState
setDirection d s = 
    let e = s.entities
        g = e.goodie
    in
        {s | entities <- { e | goodie <- { g | direction <- d}}}


-- Move to next phase

nextPhase : Phase -> Phase 
nextPhase phase =
    case phase of
         (GamePlay x) -> if (Array.length speech.gamePlay) <= (x+1) then End 0 else GamePlay (x+1) 
         (Start x)  -> if (Array.length speech.start) <= (x+1) then GamePlay -1 else Start (x+1)
         (End x) -> if (Array.length speech.end) <= (x+1) then Death 0 else End (x+1)
         (Death x) -> if (Array.length speech.death) <= (x+1) then Start 0  else Death (x+1)
