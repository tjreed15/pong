extends ColorRect

const MAIN_SCENE = preload("res://scenes/main/Main.tscn")


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_SCENE)


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_SCENE)


func _on_options_pressed() -> void:
	print("options")
