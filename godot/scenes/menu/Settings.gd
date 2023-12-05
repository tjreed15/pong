extends ColorRect

const MENU_SCENE = "res://scenes/menu/Menu.tscn"

@onready var difficultyList: ItemList = %DifficultyList
@onready var winningScore: SpinBox = %WinningScore

func _ready() -> void:
	var settings = DataStore.globalSettings
	self.difficultyList.select(settings.difficultyLevel)
	self.winningScore.value = settings.winningScore

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(MENU_SCENE)


func _on_difficulty_list_item_selected(index: int) -> void:
	DataStore.set_difficulty(index)


func _on_winning_score_value_changed(value: float) -> void:
	DataStore.set_winning_score(value)
