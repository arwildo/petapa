extends State

func enter():
	var animasi = player.get_animasi()
	player.velocity = Vector2.ZERO
	var arah = player.arah_terakhir
	if arah == null:
		player.arah_terkahir = Vector2.DOWN
	
	if arah == Vector2.RIGHT:
		animasi.play("idle_kanan")
		animasi.scale.x = 1
	elif arah == Vector2.LEFT:
		animasi.play("idle_kanan")
		animasi.scale.x = -1
	elif arah == Vector2.UP:
		animasi.play("idle_atas")
	else:
		animasi.play("idle_bawah")

func physics_update(_delta):
	# kalau ada input, pindah ke JalanState
	if Input.is_action_pressed("ui_right") \
	or Input.is_action_pressed("ui_left") \
	or Input.is_action_pressed("ui_up") \
	or Input.is_action_pressed("ui_down"):
		player.change_state("jalan")
	if Input.is_action_pressed("tombol_serang"):
		player.change_state("serang")
