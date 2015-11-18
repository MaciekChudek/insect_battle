module View where

import Signal exposing ((<~),(~))
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Window
import Array
import Text exposing (fromString)
import Content exposing (speech,locations)
import Model exposing (..)
import List

view : (Int, Int) -> GameState -> Element
view (containerWidth,containerHeight) state =
    let 
        h = (round (toFloat containerHeight * 0.8))
        h2 =  (round (toFloat containerHeight * 0.1))
        bg = case state.phase of
            GamePlay a -> state.background-- don't scale the game board, we need precise coords...
            otherwise ->  scaleToHeight h state.background 
        w = widthOf bg
        s = getTextElement w h2 state.speech 
        forms =  
            case state.phase of
                GamePlay a -> 
                    [ toForm bg
                    , toForm s |> move locations.botText
                    ] ++ getEntitiesImages state
                otherwise -> 
                     [toForm (bg `above` s  `beside` show state.phase)]
    in 
       color white <| collage (scaleInt containerWidth 0.95) (scaleInt containerHeight 0.95) forms

getTextElement : Int -> Int -> String -> Element 
getTextElement w h t = 
    height h <| width w  <| centered <| Text.height 25 <| fromString <| t


scaleToHeight : Int -> Element -> Element
scaleToHeight h e =
    let 
        origW = toFloat <| widthOf e
        origH = toFloat <| heightOf e
        scale = (toFloat h) / origH
        w = round <| origW * scale
    in
        height h e |> width w

scaleInt : Int -> Float -> Int
scaleInt i s =
    round (s*(toFloat i))


getEntityImage : Entity a -> Form
getEntityImage e =
    if e.display then move e.position (toForm e.image) else toForm empty

getEntitiesImages : GameState -> List Form
getEntitiesImages s =
    let e = s.entities in
   List.concat 
    [ [getEntityImage e.goodie]
    , [getEntityImage e.baddie] 
    , List.map getEntityImage e.goons  
    , List.map getEntityImage e.projectiles 
    , List.map getEntityImage e.effects
    ]
