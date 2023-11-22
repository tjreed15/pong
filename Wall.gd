class_name Wall extends CharacterBody2D

@onready var colorRect: ColorRect = $ColorRect
@onready var collisionShape: CollisionShape2D = $CollisionShape2D

@export var color: Color = Color.WHITE :
	set(new_value):
		color = new_value
		if not is_node_ready():
			await ready
		self.colorRect.color = new_value

func get_normal() -> Vector2:
	return Vector2.RIGHT.rotated(self.rotation)
