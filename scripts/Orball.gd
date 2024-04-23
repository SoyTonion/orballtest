extends CharacterBody2D

var velocidad := 100
var direccion := 0.0
var salto := 250
const gravedad := 10
var atacando := false
@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
func _physics_process(delta):
	direccion = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccion * velocidad
	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
	if !atacando:
		if is_on_floor():
			if direccion != 0:
				anim.play("orball_walk")
			else:
				anim.play("orball_idle")
		else:
			anim.play("orball_jump")
	
		if is_on_floor() and Input.is_action_pressed("ui_up"):
			velocity.y -= salto
		if !is_on_floor():
			velocity.y += gravedad
		if is_on_floor() and Input.is_action_pressed("ui_accept"):
			atacando = true
		move_and_slide()
	else:
		anim.play("orball_attack2")
		await(anim.animation_finished)
		atacando = false
