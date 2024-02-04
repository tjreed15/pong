extends ColorRect


const MENU_SCENE = "res://scenes/menu/Menu.tscn"


@onready var language_list: ItemList = %LanguageList
@onready var difficulty_list: ItemList = %DifficultyList
@onready var winning_score: SpinBox = %WinningScore
@onready var sound_effects_check_button: CheckButton = %SoundEffectsCheckButton
@onready var background_music_check_button: CheckButton = %BackgroundMusicCheckButton


func _ready() -> void:
	self.__initialize_settings()


func _on_back_button_pressed() -> void:
	SceneChanger.change_scene(SceneChanger.Scene.MENU)


func _on_language_list_item_selected(index: int) -> void:
	TranslationServer.set_locale(TranslationServer.get_loaded_locales()[index])
	self.__initialize_settings()


func _on_difficulty_list_item_selected(index: int) -> void:
	DataStore.set_difficulty(index)

func _on_winning_score_value_changed(value: float) -> void:
	DataStore.set_winning_score(int(value))

func _on_sound_effects_check_button_toggled(button_pressed: bool) -> void:
	DataStore.set_sfx_enabled(button_pressed)

func _on_background_music_check_button_toggled(button_pressed: bool) -> void:
	if button_pressed != DataStore.global_settings.background_music_enabled:
		UiAudioPlayer.toggle_music()
		DataStore.set_background_music_enabled(button_pressed)


func __initialize_settings() -> void:
	self.__initialize_language()
	self.__initialize_difficulty()
	self.__initialize_winning_score()
	self.__initialize_sound_effects()
	self.__initialize_background_music()


func __initialize_language() -> void:
	self.language_list.clear()
	Array(TranslationServer.get_loaded_locales()).map(self.language_list.add_item)
	var index = max(TranslationServer.get_loaded_locales().find(TranslationServer.get_locale()), 0)
	self.language_list.select(index)


func __initialize_difficulty() -> void:
	self.difficulty_list.clear()
	Difficulty.Level.values().map(Difficulty.get_label).map(self.difficulty_list.add_item)
	self.difficulty_list.select(DataStore.global_settings.difficulty_level)


func __initialize_winning_score() -> void:
	self.winning_score.value = DataStore.global_settings.winning_score


func __initialize_sound_effects() -> void:
	self.sound_effects_check_button.button_pressed = DataStore.global_settings.sfx_enabled

func __initialize_background_music() -> void:
	self.background_music_check_button.button_pressed = DataStore.global_settings.background_music_enabled

