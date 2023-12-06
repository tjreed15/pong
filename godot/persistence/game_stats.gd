class_name GameStats extends Resource


const SAVE_FILE: String = "user://game_stats.res"


@export var win_loss_count: Dictionary = {
	Difficulty.Level.EASY: WinLossCount.new(),
	Difficulty.Level.MEDIUM: WinLossCount.new(),
	Difficulty.Level.HARD: WinLossCount.new(),
}


static func load_game_stats() -> GameStats:
	if ResourceLoader.exists(SAVE_FILE):
		var stats = ResourceLoader.load(SAVE_FILE)
		print(stats)
		if stats is GameStats:
			return stats
	return GameStats.new()


func save_game_stats() -> Error:
	return ResourceSaver.save(self, SAVE_FILE)
