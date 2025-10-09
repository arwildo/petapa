extends State

func enter():
	var animasi = player.get_animasi()
	player.velocity = Vector2.ZERO
	animasi.play("diam")

func physics_update(_delta):
	# kalau ada input, pindah ke JalanState
	if Input.is_action_pressed("ui_right") \
	or Input.is_action_pressed("ui_left") \
	or Input.is_action_pressed("ui_up") \
	or Input.is_action_pressed("ui_down"):
		player.change_state("jalan")
	if Input.is_action_pressed("tombol_serang"):
		player.change_state("serang")
