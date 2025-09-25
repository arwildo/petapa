extends State

const ARAH_MAP = {
	"ui_right": {"vec": Vector2.RIGHT, "anim": "jalan_kanan", "scale_x": 1},
	"ui_left":  {"vec": Vector2.LEFT,  "anim": "jalan_kanan",  "scale_x": -1},
	"ui_up":    {"vec": Vector2.UP,    "anim": "jalan_atas"},
	"ui_down":  {"vec": Vector2.DOWN,  "anim": "jalan_bawah"}
}

func physics_update(_delta):
	var vel = Vector2.ZERO
	var animasi = player.get_animasi()
	var jalan = false

	for action in ARAH_MAP.keys():
		if Input.is_action_pressed(action):
			var data = ARAH_MAP[action]
			vel += data["vec"]
			animasi.play(data["anim"])
			if data.has("scale_x"):
				animasi.scale.x = data["scale_x"]
			jalan = true

	if jalan:
		player.velocity = vel.normalized() * player.KECEPATAN
	else:
		player.change_state("idle")
