extends Node

@onready var game: Game = Game.load_game()
@onready var game_stats: GameStats = GameStats.load_game_stats()
@onready var global_settings: GlobalSettings = GlobalSettings.load_settings()

func save_game(player1_score: int, player2_score: int) -> Error:
	self.game = Game.new()
	game.player1_score = player1_score
	game.player2_score = player2_score
	return self.game.save_game()


func tally_game(win: bool) -> Error:
	var level = self.global_settings.difficulty_level
	self.game_stats.win_loss_count[level].update(win)
	var stats_status = self.game_stats.save_game_stats()
	if stats_status != OK:
		return stats_status
	
	var game_status = self.game.delete_saved_game()
	self.game = null
	if game_status != OK:
		return game_status
	
	return OK


func reset_game_stats() -> Error:
	self.game_stats = GameStats.new()
	return self.game_stats.save_game_stats()


func set_difficulty(level: Difficulty.Level) -> Error:
	self.global_settings.difficulty_level = level
	return self.global_settings.save_settings()


func set_winning_score(score: int) -> Error:
	self.global_settings.winning_score = score
	return self.global_settings.save_settings()

func set_sfx_enabled(sfx_enabled: bool) -> Error:
	self.global_settings.sfx_enabled = sfx_enabled
	return self.global_settings.save_settings()
	
func set_background_music_enabled(background_music_enabled: bool) -> Error:
	self.global_settings.background_music_enabled = background_music_enabled
	return self.global_settings.save_settings()
