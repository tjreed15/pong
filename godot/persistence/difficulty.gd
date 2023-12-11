extends Node


enum Level {
	EASY,
	MEDIUM,
	HARD,
}


var LABELS: Dictionary = {
	str(Level.EASY): "GLOBAL_EASY_LABEL",
	str(Level.MEDIUM): "GLOBAL_MEDIUM_LABEL",
	str(Level.HARD): "GLOBAL_HARD_LABEL",
}


func get_label(level: Level) -> String:
	return tr(LABELS[str(level)])
