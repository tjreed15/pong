extends Node

@onready var gameStats: GameStats = GameStats.loadGameStats()
@onready var globalSettings: GlobalSettings = GlobalSettings.loadSettings()


func tallyGame(win: bool) -> Error:
	var level = self.globalSettings.difficultyLevel
	var count: WinLossCount = self.gameStats.winLossCount[level]
	if win:
		count.wins += 1
	else:
		count.losses += 1
	return self.gameStats.saveGameStats()

func reset_game_stats() -> Error:
	self.gameStats = GameStats.new()
	return self.gameStats.saveGameStats()

func set_difficulty(level: Difficulty.Level) -> Error:
	self.globalSettings.difficultyLevel = level
	return self.globalSettings.saveSettings()

func set_winning_score(score: int) -> Error:
	self.globalSettings.winningScore = score
	return self.globalSettings.saveSettings()
