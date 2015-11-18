module Content where

import Array exposing (Array)
import Graphics.Element exposing (image, tiledImage)


locations = 
    { top = (0,230)
    , bot = (0,-230)
    , botText = (0, -300)
    }

images =
    { models = 
        { goodie = image 32 32 "img/models/goodie.gif"
        , baddie = image 32 32 "img/models/baddie.png"
        , goon   = image 32 32 "img/models/goon.png"
        , arrow  = image 22 6 "img/models/arrow.png"
        , fireball = image 32 32 "img/models/fireball.png"
        }
    , backgrounds = 
        { start = image 600 800 "img/backgrounds/baddie.jpg"
        , gamePlay = image 512 512 "img/backgrounds/arena.jpg"
        , end = image 600 800 "img/backgrounds/goodie.jpg"
        , death = image 600 800 "img/backgrounds/death.jpg"
        }
    }

speech : {start: Array String, gamePlay: Array String, end: Array String, death: Array String}
speech =  
    { start = Array.fromList
        [ "\nBah! You Little Endians and your so-called 'relativism'. Your degenerate philosophy clouds not only your reasoning but also your morality!\n \n[SPACE] to continue."
        , "\nDid you really think you could sneak into my lair, steal one of my crystals of magical power and escape alive? Let alone that the colonies would condone such a crime as morally defensible?"
        , "\nWell, now you see the folly of your ways."
        , "\nSoon our philosophers will perfect the universal grammar, and with the explosion of knowledge that results we will drive you corrupt, relativist, Little Endians into the ground."
        , "\nYou think you can use that stolen spell crystal against me?\n How will you manage that, when you don't know any magical invocations?"
        , "\nThink you can dodge my slaves' arrows? It's going to be pretty hard to control your own legs after I cast this confusion spell on you."
        , "\n~~ V ~ I ~ M ~~"
        , "\nSlaves, fire!\n Big Endia shall triumph!"
        ]
    , gamePlay = Array.fromList
        [ "\nCurse you grand vizier!\n\n I need to figure out how to use my legs again..."
        , "\nPhew! I'm moving! But how can I hurt the vizier from within this cage?"
        , "\nWhat was that spell he just invoked? I've got to pay attention!"
        , "\nflavour"
        , "\nflavour1"
        , "\nflavour2"
        , "\nflavour3"
        ]
    , end = Array.fromList
        [ "\nThe vizier is dead!\n Now to gain his power by feasting on his desecrated corpse."
        , "\nWith the vizier's magic crystals in our hands, we will wipe the puny Big Endians from the face of history.\n\nTheir blasphemous experiments with 'Republic' and 'Science' shall die with them."
        , "\nThe whole world shall witness the glory the gods bestow upon us as we toss the shrieking Big Endian bodies into the flame."
        ]
    , death = Array.fromList
        [ "\nPathetic."
        , "\nSlaves, clean up this mess."
        , "\n[Refresh page to restart]"
        ]
    }

spells = 
    [ ("a", "Shield")
    , ("a", "Fireball")
    , ("a", "ShieldBreaker")
    , ("a", "Slow")
    , ("a", "Haste")
    , ("a", "Teleport")
    , ("a", "Bind")
    , ("a", "Spiral")
    ]
         
