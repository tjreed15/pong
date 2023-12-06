class_name PlayerGoal extends Area2D


signal scored_on(player: Player)


@onready var player: Player = get_parent()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Balls"):
		self.scored_on.emit(self.player)
