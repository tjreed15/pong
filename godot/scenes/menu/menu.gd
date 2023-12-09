extends ColorRect


@onready var continue_button: Button = %Continue


func _ready() -> void:
	if not DataStore.game:
		self.continue_button.hide()


func _on_continue_pressed() -> void:
	SceneChanger.change_scene(SceneChanger.Scene.MAIN)


func _on_new_game_pressed() -> void:
	DataStore.game = Game.new()
	SceneChanger.change_scene(SceneChanger.Scene.MAIN)


func _on_options_pressed() -> void:
	SceneChanger.change_scene(SceneChanger.Scene.SETTINGS)


func _on_stats_pressed() -> void:
	SceneChanger.change_scene(SceneChanger.Scene.STATS)
