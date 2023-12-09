class_name PauseMenu extends Control


signal save_and_exit_pressed()


func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	self.visible = not self.visible


func _on_save_and_exit_button_pressed() -> void:
	self.save_and_exit_pressed.emit()
	self.toggle_pause()


func _on_continue_button_pressed() -> void:
	self.toggle_pause()
