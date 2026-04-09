extends Node2D
class_name Room

@export var spU: Texture2D
@export var spD: Texture2D
@export var spR: Texture2D
@export var spL: Texture2D
@export var spUD: Texture2D
@export var spRL: Texture2D
@export var spUR: Texture2D
@export var spUL: Texture2D
@export var spDR: Texture2D
@export var spDL: Texture2D
@export var spULD: Texture2D
@export var spRUL: Texture2D
@export var spDRU: Texture2D
@export var spLDR: Texture2D
@export var spUDRL: Texture2D

# Room properties
var grid_pos: Vector2
var type: int

# Boolean properties to indicate which doors this room has
var door_top: bool
var door_bot: bool
var door_left: bool
var door_right: bool

@export var normal_color: Color = Color.CORNSILK # Default color for rooms
@export var enter_color: Color = Color.CHARTREUSE  # Default color for starting room
