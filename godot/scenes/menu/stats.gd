extends ColorRect

const DIFFICULTY_SEPARATOR: String = ": "
const SEPARATOR_STRING: String = " - "


@onready var easy_label: Label = %EasyLabel
@onready var medium_label: Label = %MediumLabel
@onready var hard_label: Label = %HardLabel
@onready var reset_button_accept: AcceptDialog = %ResetButtonAccept


func _ready() -> void:
	self.set_labels()


func set_labels() -> void:
	var win_loss_counts = DataStore.game_stats.win_loss_count
	var easy_win_loss_count: WinLossCount = win_loss_counts[Difficulty.Level.EASY]
	var medium_win_loss_count: WinLossCount = win_loss_counts[Difficulty.Level.MEDIUM]
	var hard_win_loss_count: WinLossCount = win_loss_counts[Difficulty.Level.HARD]
	self.easy_label.text = Difficulty.get_label(Difficulty.Level.EASY) + DIFFICULTY_SEPARATOR + str(easy_win_loss_count.wins) + SEPARATOR_STRING + str(easy_win_loss_count.losses)
	self.medium_label.text = Difficulty.get_label(Difficulty.Level.MEDIUM) + DIFFICULTY_SEPARATOR + str(medium_win_loss_count.wins) + SEPARATOR_STRING + str(medium_win_loss_count.losses)
	self.hard_label.text = Difficulty.get_label(Difficulty.Level.HARD) + DIFFICULTY_SEPARATOR + str(hard_win_loss_count.wins) + SEPARATOR_STRING + str(hard_win_loss_count.losses)


func _on_back_button_pressed() -> void:
	SceneChanger.change_scene(SceneChanger.Scene.MENU)


func _on_reset_button_pressed() -> void:
	self.reset_button_accept.popup()


func _on_recet_button_accept_confirmed() -> void:
	DataStore.reset_game_stats()
	self.set_labels()
