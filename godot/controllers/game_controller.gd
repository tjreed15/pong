class_name GameController extends Node


@onready var pause_menu: Control = %PauseMenu


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		self.pause_menu.visible = not self.pause_menu.visible
