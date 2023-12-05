extends ColorRect

const SEPARATOR_STRING: String = " - "
const MENU_SCENE = "res://scenes/menu/Menu.tscn"

@onready var easyLabel: Label = %EasyLabel
@onready var mediumLabel: Label = %MediumLabel
@onready var hardLabel: Label = %HardLabel

func _ready() -> void:
	self.set_labels()
	
func set_labels() -> void:
	var winLossCounts = DataStore.gameStats.winLossCount
	var easyWinLossCount: WinLossCount = winLossCounts[Difficulty.Level.Easy]
	var mediumWinLossCount: WinLossCount = winLossCounts[Difficulty.Level.Medium]
	var hardWinLossCount: WinLossCount = winLossCounts[Difficulty.Level.Hard]
	self.easyLabel.text = "Easy: " + str(easyWinLossCount.wins) + SEPARATOR_STRING + str(easyWinLossCount.losses)
	self.mediumLabel.text = "Medium: " + str(mediumWinLossCount.wins) + SEPARATOR_STRING + str(mediumWinLossCount.losses)
	self.hardLabel.text = "Hard: " + str(hardWinLossCount.wins) + SEPARATOR_STRING + str(hardWinLossCount.losses)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(MENU_SCENE)


func _on_reset_button_pressed() -> void:
	DataStore.reset_game_stats()
	self.set_labels()
