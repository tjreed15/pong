extends Node


func _ready() -> void:
	if DataStore.global_settings.background_music_enabled:
		UiAudioPlayer.play_music()

