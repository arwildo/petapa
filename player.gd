extends CharacterBody2D

const KECEPATAN = 130
var state: State
var states = {}
var vel = Vector2.ZERO
var arah_terakhir = Vector2.RIGHT

func _ready():
	# load states
	states["idle"] = load("res://states/IdleState.gd").new()
	states["jalan"] = load("res://states/JalanState.gd").new()
	states["serang"] = load("res://states/SerangState.gd").new()

	# kasih referensi player ke setiap state
	for s in states.values():
		s.player = self

	change_state("idle")
	
func get_animasi():
	return $AnimatedSprite2D
	
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
