class_name PlayerGoal extends Area2D


signal scored_on(player: Player)


@onready var player: Player = get_parent()
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Balls"):
		if DataStore.global_settings.sfx_enabled:
			self.audio_player.play()
		self.scored_on.emit(self.player)
