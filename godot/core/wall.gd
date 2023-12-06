class_name Wall extends CharacterBody2D


@onready var color_rect: ColorRect = $ColorRect

@export var color: Color = Color.WHITE :
	set(new_value):
		color = new_value
		if not is_node_ready():
			await ready
		self.color_rect.color = new_value

func get_normal() -> Vector2:
	return Vector2.RIGHT.rotated(self.rotation)
