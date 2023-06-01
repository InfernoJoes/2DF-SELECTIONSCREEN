extends TextureRect
class_name SelectionInfo

@export var portrait : Texture2D
@export var _name : String

# needs some other stuff. probably wont be useful now than later, but whatever
@export var SPD : float # speed: how fast it can move
@export var DEF : float # defense: how much damage it blocks off when blocking
@export var ATK : float # attack: how much damage it does

# TODO: "combo info": stores all available inputs and combos for THAT specific character (should be stored in its own script)
# i'm getting some ideas, maybe a JSON file with all of the inputs and combos? which is supposed to innaccessible and break the game if changed in a known built version, so that other players cant cheat
# i dont know why i was thinking of this, but something with a file has to be enough to tell which character has that combo
