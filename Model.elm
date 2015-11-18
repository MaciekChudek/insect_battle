module Model where

import Graphics.Element exposing (..)
import Set exposing (Set)
import Keyboard exposing (KeyCode)
-- MODELS

-- Enums
type Direction = 
    North | East | South | West | NorthEast | NorthWest | SouthEast | SouthWest | NoDirection

type Phase = Start Int | GamePlay Int | End Int | Death Int



-- Data structure types


type alias Entity a  =
    { a | 
    position : (Float, Float)
    , display : Bool
    , image    : Element
    }

type alias Effect a = 
    { a |
    duration : Float
    }

type alias Agent a  =
    { a |
    health   : Int
    , collided : Bool
    }

type alias Mobile a =
    { a |
    velocity : (Float, Float)
    , orientation : Float
    }

type alias Goodie a =
    { a |
    direction : Direction 
    }

type alias Entities =
    { goodie : Entity (Agent (Mobile (Goodie {})))
    , baddie : Entity (Agent {})
    , goons  : List (Entity (Agent ({})))
    , projectiles : List (Mobile (Entity {}))
    , effects : List (Entity (Effect {}))
    }

type alias GameState = 
    { phase : Phase 
    , background : Element
    , speech : String
    , delay : Float
    , keys : Set KeyCode
    , entities : Entities
    }




-- Initial Data

entity : Entity {}
entity = 
    { position = (0,0)
    , display = False
    , image = empty
    }

agent : Entity (Agent {})
agent = 
    { position = (0,0)
    , display = False
    , health = 0
    , image = empty
    , collided = False
    }

baddie = agent

mobile : Entity (Agent (Mobile {}))
mobile = 
    { position = (0,0)
    , display = False
    , health = 0
    , image = empty
    , collided = False
    , velocity = (0, 0)
    , orientation = 0
    }

goodie : Entity (Agent (Mobile (Goodie {})))
goodie = 
    { position = (0,0)
    , display = False
    , health = 0
    , image = empty
    , collided = False
    , velocity = (0, 0)
    , orientation = 0
    , direction = NoDirection
    }

effect : Entity (Effect {})
effect = 
    { position = (0,0)
    , display = False
    , duration = 0
    , image = empty
    }


entities : Entities 
entities = 
    { goodie = goodie 
    , baddie = agent 
    , goons  = [] 
    , projectiles = []
    , effects = [] 
    }

gameState : GameState
gameState =
    { phase = Start 0
    , background = empty
    , speech = ""
    , delay = 0
    , keys = Set.empty
    , entities = entities 
    }




{-


type alias Villain = Entity {}

type alias Projectile = Entity {}

type alias Hero a =  
    { a | velocity : (Float, Float)
    , direction : Direction
    }


type alias GameState a = 
    { hero : Hero a 
    , villains : List Villain  
    , projectiles : List Projectile 
    , phase : Phase
    , background : Element
    , effects : List Element 
    }

hero : Entity (Hero {}) 
hero = 
    {   position = (0,0)
    , health = 10
    , image = empty
    , collided = False
    , direction = None 
    , velocity = (0, 0)
    }

gameState : GameState a
gameState a =
    GameState { hero = hero 
              , villains = []
              , projectiles = []
              , phase = Start
              , background = empty
              , effects = [] 
              }

-}
