extends Node


const CLICK_STREAM: AudioStream = preload("res://addons/kenney_ui_audio/click1.wav")
const HOVER_STREAM: AudioStream = preload("res://addons/kenney_ui_audio/rollover1.wav")
const BG_MUSIC_STREAM: AudioStream = preload("res://resources/audio/Down-Under.mp3")

var bg_music_position: float = 0

@onready var click_audio_player: AudioStreamPlayer = self.__init_audio_player(CLICK_STREAM)
@onready var hover_audio_player: AudioStreamPlayer = self.__init_audio_player(HOVER_STREAM)
@onready var bg_music_audio_player: AudioStreamPlayer = self.__init_audio_player(BG_MUSIC_STREAM)


func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	SignalBus.button_pressed.connect(func(_button): self._on_Button_pressed())
	SignalBus.button_hovered.connect(func(_button): self._on_Button_hovered())

func play_music():
	self.bg_music_audio_player.play(self.bg_music_position)
	
func stop_music():
	self.bg_music_position = self.bg_music_audio_player.get_playback_position()
	self.bg_music_audio_player.stop()

func toggle_music():
	if self.bg_music_audio_player.playing:
		self.stop_music()
	else:
		self.play_music()

func _on_Button_pressed():
	if DataStore.global_settings.sfx_enabled:
		self.click_audio_player.play()


func _on_Button_hovered():
	if DataStore.global_settings.sfx_enabled:
		self.hover_audio_player.play()


func __init_audio_player(stream: AudioStream) -> AudioStreamPlayer:
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = stream
	return player
