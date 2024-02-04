class_name GameOver extends Control


signal rematch_pressed()
signal main_menu_pressed()

const WINNING_SOUND: AudioStream = preload("res://addons/kenney music jingles/Steel jingles/jingles_steel_10.ogg")
const LOSING_SOUND: AudioStream = preload("res://addons/kenney music jingles/8-Bit jingles/jingles_nes_0.ogg")

@onready var win_label: Label = %WinLabel
@onready var lose_label: Label = %LoseLabel
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer


func end_game(win: bool) -> void:
	get_tree().paused = true
	self.visible = true
	if win:
		self.__player_wins()
	else:
		self.__player_loses()


func __player_wins():
	self.win_label.show()
	self.audio_stream_player.stream = WINNING_SOUND
	self.audio_stream_player.play()

func __player_loses():
	self.lose_label.show()
	self.audio_stream_player.stream = LOSING_SOUND
	self.audio_stream_player.play()


func _on_rematch_button_pressed() -> void:
	self.rematch_pressed.emit()


func _on_main_menu_button_pressed() -> void:
	self.main_menu_pressed.emit()
