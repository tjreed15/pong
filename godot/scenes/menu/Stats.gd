extends ColorRect


const SEPARATOR_STRING: String = " - "
const MENU_SCENE = "res://scenes/menu/Menu.tscn"


@onready var easy_label: Label = %EasyLabel
@onready var medium_label: Label = %MediumLabel
@onready var hard_label: Label = %HardLabel


func _ready() -> void:
	self.set_labels()
	
func set_labels() -> void:
	var win_loss_counts = DataStore.game_stats.win_loss_count
	var easy_win_loss_count: WinLossCount = win_loss_counts[Difficulty.Level.EASY]
	var medium_win_loss_count: WinLossCount = win_loss_counts[Difficulty.Level.MEDIUM]
	var hard_win_loss_count: WinLossCount = win_loss_counts[Difficulty.Level.HARD]
	self.easy_label.text = "Easy: " + str(easy_win_loss_count.wins) + SEPARATOR_STRING + str(easy_win_loss_count.losses)
	self.medium_label.text = "Medium: " + str(medium_win_loss_count.wins) + SEPARATOR_STRING + str(medium_win_loss_count.losses)
	self.hard_label.text = "Hard: " + str(hard_win_loss_count.wins) + SEPARATOR_STRING + str(hard_win_loss_count.losses)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(MENU_SCENE)


func _on_reset_button_pressed() -> void:
	DataStore.reset_game_stats()
	self.set_labels()
