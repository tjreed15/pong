class_name GameStats extends Resource

const SAVE_FILE: String = "user://game_stats.res"

@export var winLossCount: Dictionary = {
	Difficulty.Level.Easy: WinLossCount.new(),
	Difficulty.Level.Medium: WinLossCount.new(),
	Difficulty.Level.Hard: WinLossCount.new(),
}

static func loadGameStats() -> GameStats:
	if ResourceLoader.exists(SAVE_FILE):
		var stats = ResourceLoader.load(SAVE_FILE)
		print(stats)
		if stats is GameStats:
			return stats
	return GameStats.new()
	
func saveGameStats() -> Error:
	return ResourceSaver.save(self, SAVE_FILE)
