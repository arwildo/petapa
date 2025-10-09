extends State

func physics_update(_delta):
	var animasi = player.get_animasi()
	var lagi_menyerang = false
	
	if Input.is_action_pressed("tombol_serang"):
		lagi_menyerang = true

	if lagi_menyerang:
		animasi.play("serang_depan")
	else:
		player.change_state("idle")
