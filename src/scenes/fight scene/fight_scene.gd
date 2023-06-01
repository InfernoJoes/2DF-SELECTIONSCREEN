extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$%p1_sprite.texture = SelectionGlobalManager._p1_portrait
	$%p2_sprite.texture = SelectionGlobalManager._p2_portrait


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
