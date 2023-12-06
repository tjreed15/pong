extends Node

@onready var game_stats: GameStats = GameStats.load_game_stats()
@onready var global_settings: GlobalSettings = GlobalSettings.load_settings()


func tally_game(win: bool) -> Error:
	var level = self.global_settings.difficulty_level
	var count: WinLossCount = self.game_stats.win_loss_count[level]
	if win:
		count.wins += 1
	else:
		count.losses += 1
	return self.game_stats.save_game_stats()

func reset_game_stats() -> Error:
	self.game_stats = GameStats.new()
	return self.game_stats.save_game_stats()

func set_difficulty(level: Difficulty.Level) -> Error:
	self.global_settings.difficulty_level = level
	return self.global_settings.save_settings()

func set_winning_score(score: int) -> Error:
	self.global_settings.winning_score = score
	return self.global_settings.save_settings()
