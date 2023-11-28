class_name GameController extends Node

@onready var pauseMenu: Control = %PauseMenu

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		self.pauseMenu.visible = not self.pauseMenu.visible
