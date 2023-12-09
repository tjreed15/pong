extends Node


const MAIN_SCENE = "res://scenes/main/Main.tscn"
const MENU_SCENE = "res://scenes/menu/Menu.tscn"
const SETTINGS_SCENE = "res://scenes/menu/Settings.tscn"
const STATS_SCENE = "res://scenes/menu/Stats.tscn"


enum Scene {
	MAIN,
	MENU,
	SETTINGS,
	STATS,
}


var SCENE_MAP: Dictionary = {
	str(Scene.MAIN): MAIN_SCENE,
	str(Scene.MENU): MENU_SCENE,
	str(Scene.SETTINGS): SETTINGS_SCENE,
	str(Scene.STATS): STATS_SCENE,
}


func change_scene(scene: Scene) -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(SCENE_MAP[str(scene)])
