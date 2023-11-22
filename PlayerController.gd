class_name PlayerController extends Node


@onready var paddle: Paddle = get_parent()

func _process(_delta: float) -> void:
	var vel = Vector2(0, get_viewport().get_mouse_position().y - self.paddle.global_position.y)
	paddle.move_and_collide(vel)
