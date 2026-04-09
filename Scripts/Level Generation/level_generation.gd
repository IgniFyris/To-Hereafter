extends Node2D

@export var tilemap : TileMapLayer

const LEVEL_WIDTH = 100
const LEVEL_HEIGHT = 100

enum TileType { EMPTY, FLOOR, WALL }

var levelGrid = []

func _ready():
	create_level()

func generate_level():
	levelGrid = []
	
	for y in LEVEL_HEIGHT:
		levelGrid.append( [] )
		for x in LEVEL_WIDTH:
			levelGrid[y].append( TileType.EMPTY )
			
	var rooms : Array[Rect2] = []
	var max_attempts = 100
	var tries = 0
	
	while rooms.size() < 10 and tries < max_attempts:
		var w =  randi_range(5, 20)
		var h =  randi_range(5, 20)
		var x =  randi_range(1, LEVEL_WIDTH - w - 1)
		var y =  randi_range(1, LEVEL_HEIGHT - h - 1)
		var room = Rect2(x, y, w, h)
		
		var overlaps = false
		for other in rooms:
			if room.grow(1).intersection(other):
				overlaps = true
				break
				
		if !overlaps:
			rooms.append(room)
			for iy in range(y, y + h):
				for ix in range(x, x + w):
					levelGrid[iy][ix] = TileType.FLOOR
		tries += 1
		
func render_level():
	tilemap.clear()
	
	for y in range(LEVEL_HEIGHT):
		for x in range(LEVEL_WIDTH):
			var tile = levelGrid[y][x]
			
			match tile:
				TileType.FLOOR: tilemap.set_cell(Vector2i(x, y), 0, Vector2i(7,5))
				TileType.WALL: tilemap.set_cell(Vector2i(x, y), 0, Vector2i(7,4))
				
func create_level():
	generate_level()
	render_level()
