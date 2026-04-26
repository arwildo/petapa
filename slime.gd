extends CharacterBody2D
@onready var sprite := $AnimatedSprite2D
@onready var hitbox := $Hitbox
var sudah_mati = false

func _ready():
	sprite.play("idle")
	hitbox.area_entered.connect(kena_serang)

func kena_serang(area):
	if sudah_mati:
		return
	if area.name == "AttackBox" and area.monitoring:
		musuh_mati()

func musuh_mati():
	sudah_mati = true
	hitbox.set_deferred("monitoring", false)
	set_physics_process(false)
	set_process(false)
	sprite.play("mati")
	await get_tree().create_timer(0.4).timeout
	respawn()

func respawn():
	sudah_mati = false
	
	collision_layer = 0
	collision_mask = 0
	
	var tanah = get_parent().get_node("tanah") as TileMapLayer
	if tanah:
		var current_cell = tanah.local_to_map(position)
		for i in 20:
			var random_cell = Vector2i(
				current_cell.x + randi_range(-5, 5),
				current_cell.y + randi_range(-5, 5)
			)
			if tanah.get_cell_source_id(random_cell) != -1:
				global_position = tanah.map_to_local(random_cell)
				break
	
	await get_tree().create_timer(0.1).timeout
	collision_layer = 1
	collision_mask = 1
	
	hitbox.monitoring = true
	set_physics_process(true)
	set_process(true)
	sprite.play("idle")
