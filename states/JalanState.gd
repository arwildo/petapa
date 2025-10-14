extends State

const ARAH_MAP = {
	"ui_right": {"vec": Vector2.RIGHT, "anim": "jalan_kanan", "scale_x": 1},
	"ui_left":  {"vec": Vector2.LEFT,  "anim": "jalan_kanan",  "scale_x": -1},
	"ui_up":    {"vec": Vector2.UP,    "anim": "jalan_atas"},
	"ui_down":  {"vec": Vector2.DOWN,  "anim": "jalan_bawah"}
}

func physics_update(_delta):
	player.vel = Vector2.ZERO
	var animasi = player.get_animasi()
	var jalan = false

	for action in ARAH_MAP.keys():
		if Input.is_action_pressed(action):
			var data = ARAH_MAP[action]
			player.vel += data["vec"]
			player.arah_terakhir = data["vec"] # simpan arah terkahir
			animasi.play(data["anim"])
			if data.has("scale_x"):
				animasi.scale.x = data["scale_x"]
			jalan = true

	if jalan:
		player.velocity = player.vel.normalized() * player.KECEPATAN
	elif Input.is_action_pressed("tombol_serang"):
		player.change_state("serang")
	else:
		player.change_state("idle")
