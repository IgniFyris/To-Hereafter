extends Node2D

var basicMonsterRes: PackedScene = preload("uid://dofox6h2j5foi")

@export var tilemap : TileMapLayer
@export var player : CharacterBody2D
@export var roomAmt : int
@export var maxRoomWidthRange : int
@export var maxRoomHeightRange : int
@export var minRoomWidthRange : int
@export var minRoomHeightRange : int
@export var bg = load("uid://vhge4lgu8juk")

@onready var BG = $Parallax2D/Background1
@onready var MonsSpawnTimer = $MonsterSpawn

var rooms : Array[Rect2] = []

const LEVEL_WIDTH = 400
const LEVEL_HEIGHT = 70

enum TileType { EMPTY, FLOOR, WALL }

var levelGrid = []
var monsters = 0
var randomRoom

var playerRoom

var spawned_monster_tiles : Array[Vector2i] = []

func _ready():
	spawned_monster_tiles.clear()
	create_level()

func generate_level():
	levelGrid = []
	
	for y in LEVEL_HEIGHT:
		levelGrid.append( [] )
		for x in LEVEL_WIDTH:
			levelGrid[y].append( TileType.EMPTY )
		
	var max_attempts = 100
	var tries = 0
	
	while rooms.size() < roomAmt and tries < max_attempts:
		var w =  randi_range(minRoomWidthRange, maxRoomWidthRange)
		var h =  randi_range(minRoomHeightRange, maxRoomHeightRange)
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
					
			if rooms.size() > 1:
				var prev = rooms[rooms.size() - 2].get_center()
				var curr = room.get_center()
				carve_corridor(prev, curr)
		tries += 1
		
	return rooms
		
func render_level():
	tilemap.clear()
	
	for y in range(LEVEL_HEIGHT):
		for x in range(LEVEL_WIDTH):
			var tile = levelGrid[y][x]
			
			match tile:
				TileType.FLOOR: tilemap.set_cell(Vector2i(x, y), 0, Vector2i(9,6))
				TileType.WALL: tilemap.set_cell(Vector2i(x, y), 0, Vector2i(7,6))

func add_walls():
	for y in range(LEVEL_HEIGHT):
		for x in range(LEVEL_WIDTH):
			if levelGrid[y][x] == TileType.FLOOR:
				for dy in range(-1, 2):
					for dx in range(-1, 2):
						var nx = x + dx
						var ny = y + dy
						if nx >= 0 and ny >= 0 and nx < LEVEL_WIDTH and ny < LEVEL_HEIGHT:
							if levelGrid[ny][nx] == TileType.EMPTY:
								levelGrid[ny][nx] = TileType.WALL
				
func create_level():
	var amt = 0
	
	configure_bg()
	generate_level()
	place_player()
	add_walls()
	render_level()
	
	while not player.is_on_floor():
		await get_tree().physics_frame
		if player.is_on_floor():
			break
			
	while amt < 15:
		create_monsters()
		amt += 1
	
func carve_corridor(from: Vector2, to: Vector2, width: int = 4):
	var min_width = -width/2
	var max_width = width/2
	
	if randf() < 0.5:
		for x in range(min(from.x, to.x), max(from.x, to.x) + 1):
			for offset in range(min_width, max_width + 1):
				var y = from.y + offset
				if is_in_bounds(x, y):
					levelGrid[y][x] = TileType.FLOOR
		for y in range(min(from.y, to.y), max(from.y, to.y) + 1):
			for offset in range(min_width, max_width + 1):
				var x = to.x + offset
				if is_in_bounds(x, y):
					levelGrid[y][x] = TileType.FLOOR
	else:
		for y in range(min(from.y, to.y), max(from.y, to.y) + 1):
			for offset in range(min_width, max_width + 1):
				var x = from.x + offset
				if is_in_bounds(x, y):
					levelGrid[y][x] = TileType.FLOOR
		for x in range(min(from.x, to.x), max(from.x, to.x) + 1):
			for offset in range(min_width, max_width + 1):
				var y = to.y + offset
				if is_in_bounds(x, y):
					levelGrid[y][x] = TileType.FLOOR
					
func place_player():
	playerRoom = rooms.pick_random()
	player.position = playerRoom.get_center() * 16
	
func configure_bg():
	BG.texture = bg
	BG.position = Vector2((LEVEL_WIDTH * 16)/2, (LEVEL_HEIGHT * 16)/2)
	
func is_in_bounds(x: int, y: int) -> bool:
	return x >= 0 and y >= 0 and x < LEVEL_WIDTH and y < LEVEL_HEIGHT
	
func create_monsters():
	const MIN_DISTANCE_TILES = 2.0  
	const MAX_ATTEMPTS = 50
	
	var attempts = 0
	var placed = false
	
	while not placed and attempts < MAX_ATTEMPTS:
		randomRoom = rooms.pick_random()
		
		if randomRoom != playerRoom:
			var tile_x = randf_range(randomRoom.position.x, randomRoom.position.x + randomRoom.size.x)
			var tile_y = randf_range(randomRoom.position.y, randomRoom.position.y + randomRoom.size.y)
			var desigTile = Vector2i(floor(tile_x), floor(tile_y))
			
			var too_close = false
			for other_tile in spawned_monster_tiles:
				if other_tile.distance_to(desigTile) < MIN_DISTANCE_TILES:
					too_close = true
					break
			
			var world_pos = Vector2(tile_x * 16, tile_y * 16)
			if not too_close and is_in_any_position_in_any_room(world_pos):
				var basicMonster = basicMonsterRes.instantiate()
				basicMonster.position = world_pos
				add_child(basicMonster)
				spawned_monster_tiles.append(desigTile)
				monsters += 1
				placed = true
		
		attempts += 1

func _on_monster_spawn_timeout() -> void:
	if monsters < 30:
		create_monsters()
	else:
		spawned_monster_tiles.clear()

func is_in_any_position_in_any_room(world_pos: Vector2) -> bool:
	for room in rooms:
		var pixel_room = Rect2(room.position * 16, room.size * 16)
		if pixel_room.has_point(world_pos):
			return true
	return false
