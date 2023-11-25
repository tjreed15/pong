class_name PlayerExploder extends Node

@onready var player: Player = self.get_parent()


func _process(delta: float) -> void:
	print("Explode")
	self.player.queue_free()
