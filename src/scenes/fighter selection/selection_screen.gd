extends Control

# apparently i foud out you can't change the anchors
@onready var p1_cursor := %p1
@onready var p2_cursor := %p2

@onready var selection_grid := %selection_grid

var p1_active : bool = true
var p2_active : bool = false

#var _selected = 0 # position of the cursor within the chars[], helps know what kind of character we just selected

var chars = []

# GW = Greenwood
# SA = Steve Aleksei
# RTP = Rob the Painter
# DD = Dark Destroyer
# HB = Hustle-buster
# RB = Roxx Bloxx
# KB = Killbot
# GB = Goblin boy
# DP = Dr. Poop
# SM = Sgt. Mittens
# OF = Orange-face
# DB = Darkblade


# incase of a two-player system, wouldn't want each player to override selected characters 
var _p1_selected = 0 # current selected selection
var _p1_currColumn = 0 # current selected column spot
var _p1_currRow = 0 # current selected row spot

var _p2_selected = 0
var _p2_currColumn = 0
var _p2_currRow = 0

func _ready():
	for name_of_char in get_tree().get_nodes_in_group("Characters"):
		chars.append(name_of_char)
	
	p1_cursor.global_position = chars[0].global_position
	p2_cursor.global_position = chars[0].global_position

func _process(delta):
	if Input.is_action_just_pressed("quick_quit"):
		get_tree().quit()
	
	# dont do it the opposite way! the textures and texts are null, that's why they cant change
	
	$p1_portrait_pos/p1_portrait_sprite.texture = chars[_p1_selected].portrait
	$selection_panel/p1_name.text = chars[_p1_selected]._name
	
	$p2_portrait_pos/p2_portrait_sprite.texture = chars[_p2_selected].portrait
	$selection_panel/p2_name.text = chars[_p2_selected]._name
	
	#print("p1 selection: ", _p1_selected)
	#print("p2 selection: ", _p2_selected)
	
	# --PLAYER 1--
	
	# these values are weird
	# i have to do it this way so it doesn't break
	if _p1_selected < -1: # supposed to be 0
		_p1_selected = 10 # supposed to be 11
	if _p1_selected > 10:
		_p1_selected = -1
	
	# should be using max size of char array
	
	if Input.is_action_just_pressed("m_right") and p1_active == true:
		_p1_selected += 1
		p1_cursor.global_position = chars[_p1_selected].global_position
	if Input.is_action_just_pressed("m_left") and p1_active == true:
		_p1_selected -= 1
		p1_cursor.global_position = chars[_p1_selected].global_position
	
	# --PLAYER 2--
	
	if _p2_selected < -1:
		_p2_selected = 10
	if _p2_selected > 10:
		_p2_selected = -1
	
	if Input.is_action_just_pressed("m_right") and p2_active == true:
		_p2_selected += 1
		p2_cursor.global_position = chars[_p2_selected].global_position
	if Input.is_action_just_pressed("m_left") and p2_active == true:
		_p2_selected -= 1
		p2_cursor.global_position = chars[_p2_selected].global_position
	
	# --SELECTION MADE--
	if Input.is_action_just_pressed("m_select") and p1_active == true:
		p1_active = false
		p2_active = true
	
	# load fight scene with fighters that we selected
	elif Input.is_action_just_pressed("m_select") and p2_active == true:
		SelectionGlobalManager._p1_char_selected = chars[_p1_selected]
		SelectionGlobalManager._p2_char_selected = chars[_p2_selected]
		
		SelectionGlobalManager._p1_name = chars[_p1_selected]._name
		SelectionGlobalManager._p1_portrait = chars[_p1_selected].portrait
		#SelectionGlobalManager._p1_SPD = chars[_p1_selected].SPD
		#SelectionGlobalManager._p1_DEF = chars[_p1_selected].DEF
		#SelectionGlobalManager._p1_ATK = chars[_p1_selected].ATK
		
		SelectionGlobalManager._p2_name = chars[_p2_selected]._name
		SelectionGlobalManager._p2_portrait = chars[_p2_selected].portrait
		#SelectionGlobalManager._p2_SPD = chars[_p2_selected].SPD
		#SelectionGlobalManager._p2_DEF = chars[_p2_selected].DEF
		#SelectionGlobalManager._p2_ATK = chars[_p2_selected].ATK
		
		get_tree().change_scene_to_file("res://src/scenes/fight scene/fight_scene.tscn")
