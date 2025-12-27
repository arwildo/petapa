extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D

func _ready():
	sprite.play("idle")
