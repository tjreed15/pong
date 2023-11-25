extends Node

@onready var ball: Ball = self.get_parent()

func _on_ball_area_entered(area: Area2D) -> void:
	if area.has_method("get_normal"):
		ball.bounce(area.get_normal())
