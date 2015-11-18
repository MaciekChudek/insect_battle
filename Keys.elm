module Keys where

import Set exposing (Set, isEmpty)
import Keyboard exposing (KeyCode)
import Model exposing (..) 

-- Keyboard Input

directionKeys : {west:Int, south:Int, north:Int, east:Int}
directionKeys = -- VIM bindings for direction control 
    { west = 72 -- h 
    , south = 74 -- j 
    , north = 75 -- k
    , east = 76 -- l 
    }

getDirection : (Set KeyCode) -> Direction
getDirection keys = 
    case 
     ( Set.member directionKeys.west keys
     , Set.member directionKeys.south keys
     , Set.member directionKeys.north keys
     , Set.member directionKeys.east keys
     ) of
        (True, False, False, False) -> West
        (False, True, False, False) -> South
        (False, False, True, False) -> North
        (False, False, False, True) -> East
        (True, False, True, False) -> NorthWest
        (False, False, True, True) -> NorthEast
        (True, True, False, False) -> SouthWest
        (False, True, False, True) -> SouthEast
        (False, False, False, False) -> NoDirection
        otherwise -> NoDirection

anyKey: (Set KeyCode) -> Bool
anyKey keys = not <| isEmpty keys

spaceKey : (Set KeyCode) -> Bool
spaceKey keys = Set.member 32 keys 

newKeys : (Set KeyCode) -> (Set KeyCode) -> (Set KeyCode)
newKeys new old = 
    Set.diff new old -- Get the difference between the first set and the second. Keeps values that do not appear in the second set.
