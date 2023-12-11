class_name GameOver extends Control


signal rematch_pressed()
signal main_menu_pressed()


@onready var win_label: Label = %WinLabel
@onready var lose_label: Label = %LoseLabel


func end_game(win: bool) -> void:
	get_tree().paused = true
	self.visible = true
	if win:
		self.win_label.show()
	else:
		self.lose_label.show()


func _on_rematch_button_pressed() -> void:
	self.rematch_pressed.emit()


func _on_main_menu_button_pressed() -> void:
	self.main_menu_pressed.emit()
