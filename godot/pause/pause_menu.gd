class_name PauseMenu extends Control


signal save_and_exit_pressed()


func pause() -> void:
	self.__set_pause(true)


func unpause() -> void:
	self.__set_pause(false)


func __set_pause(paused: bool) -> void:
	get_tree().paused = paused
	self.visible = paused


func _on_save_and_exit_button_pressed() -> void:
	self.save_and_exit_pressed.emit()


func _on_continue_button_pressed() -> void:
	self.unpause()
