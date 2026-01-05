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

	if area.name == "AttackBox":
		musuh_mati()

func musuh_mati():
	sudah_mati = true

	hitbox.monitoring = false
	set_physics_process(false)
	set_process(false)

	sprite.play("mati")

	await get_tree().create_timer(0.4).timeout
	queue_free()
