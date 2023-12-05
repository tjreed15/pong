extends ColorRect

const MAIN_SCENE = "res://scenes/main/Main.tscn"
const STATS_SCENE = "res://scenes/menu/Stats.tscn"
const SETTINGS_SCENE = "res://scenes/menu/Settings.tscn"


func _on_continue_pressed() -> void:
	print("continue")


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_SCENE)


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file(SETTINGS_SCENE)


func _on_stats_pressed() -> void:
	get_tree().change_scene_to_file(STATS_SCENE)
