extends ColorRect


const MENU_SCENE = "res://scenes/menu/Menu.tscn"


@onready var difficulty_list: ItemList = %DifficultyList
@onready var winning_score: SpinBox = %WinningScore


func _ready() -> void:
	var settings = DataStore.global_settings
	self.difficulty_list.select(settings.difficulty_level)
	self.winning_score.value = settings.winning_score


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(MENU_SCENE)


func _on_difficulty_list_item_selected(index: int) -> void:
	DataStore.set_difficulty(index)


func _on_winning_score_value_changed(value: float) -> void:
	DataStore.set_winning_score(int(value))
