class_name PlayerExploder extends Node


@onready var player: Player = self.get_parent()
@onready var PlayerExplosion: PackedScene = preload("res://powerups/player_explosion.tscn")


func _process(_delta: float) -> void:
	var rect = self.player.get_paddle().color_rect
	var explosion = PlayerExplosion.instantiate()
	explosion.global_position = rect.global_position
	explosion.color = rect.color
	explosion.size = rect.size
	get_node("/root").add_child(explosion)
	self.player.queue_free()
