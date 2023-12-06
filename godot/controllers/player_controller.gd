class_name PlayerController extends Node


@onready var paddle: Paddle = get_parent()


func _physics_process(_delta: float) -> void:
	var pos = get_viewport().get_mouse_position()
	if Input.is_action_pressed("rotate"):
		self.paddle.look_at(pos)
	else:
		var vel = Vector2(0, pos.y - self.paddle.global_position.y)
		self.paddle.move_and_collide(vel)
