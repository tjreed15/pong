class_name GameOver extends Control


signal rematch_pressed()
signal main_menu_pressed()


func game_over() -> void:
	get_tree().paused = true
	self.visible = not self.visible


func _on_rematch_button_pressed() -> void:
	self.rematch_pressed.emit()


func _on_main_menu_button_pressed() -> void:
	self.main_menu_pressed.emit()
