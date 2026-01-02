extends CharacterBody2D

const KECEPATAN = 130

var state
var states = {}
var vel = Vector2.ZERO
var arah_terakhir = Vector2.RIGHT

@onready var sprite := $AnimatedSprite2D
@onready var attack_box := $AttackBox


func _ready():
	# load states
	states["idle"] = load("res://states/IdleState.gd").new()
	states["jalan"] = load("res://states/JalanState.gd").new()
	states["serang"] = load("res://states/SerangState.gd").new()

	# inject player ke state
	for s in states.values():
		s.player = self

	change_state("idle")

	# connect frame event
	sprite.frame_changed.connect(_on_frame_changed)

	# attack box default mati
	attack_box.monitoring = false


func _on_frame_changed():
	# aktifkan attack box hanya di frame pedang muncul
	if sprite.animation == "serang_samping":
		var f = sprite.frame

		# frame ke 2 dan 3 secara visual
		# index dimulai dari 0
		if f == 1 or f == 2:
			attack_box.monitoring = true
		else:
			attack_box.monitoring = false
	else:
		attack_box.monitoring = false


func change_state(new_state):
	if state:
		state.exit()
	state = states[new_state]
	state.enter()


func _input(event):
	state.handle_input(event)


func _process(delta):
	state.update(delta)


func _physics_process(delta):
	state.physics_update(delta)
	move_and_slide()


func get_animasi():
	return sprite
