extends Node


const SCORE_DELIMETER = " : "
const END_GAME_TIME = 1.5


@onready var score_label: Label = %ScoreLabel
@onready var game_over: GameOver = %GameOver
@onready var ball: Ball = $Ball
@onready var player1: Player = $Player1
@onready var player2: Player = $Player2
@onready var ai_controller: AIController = $Player2/Paddle/AIController
@onready var server: Player = self.player1
@onready var player_scores: Dictionary = {str(player1): 0, str(player2): 0}


var default_ball_speed: int


func _ready() -> void:
	self.__init_score()
	var difficulty = DataStore.global_settings.difficulty_level
	self.ai_controller.max_speed = (difficulty + 2) * 250
	self.ai_controller.deviations = difficulty + 1
	self.default_ball_speed = (difficulty+3) * 200
	self.serve()


func serve() -> void:
	self.ball.position = Constants.SCREEN_CENTER
	self.ball.set_direction(self.server.get_normal().rotated(randf_range(-PI/4, PI/4)))
	self.ball.set_speed(self.default_ball_speed)


func increment_score(scorer: Player) -> int:
	self.player_scores[str(scorer)] += 1
	self.update_score()
	return self.player_scores[str(scorer)]


func update_score() -> void:
	var score_string = ""
	for score in self.player_scores.values():
		score_string += str(score) + SCORE_DELIMETER
	self.score_label.text =  score_string.left(-SCORE_DELIMETER.length())


func end_game(winner: Player) -> void:
	DataStore.tally_game(winner == self.player1)
	self.score_label.text += "\n" + winner.player_name + " wins!"
	self.ball.queue_free()
	var exploder = PlayerExploder.new()
	self.__get_other_player(winner).add_child(exploder)
	await get_tree().create_timer(END_GAME_TIME).timeout
	self.game_over.show()


func _on_player_scored_on(player: Player) -> void:
	self.server = player
	var scorer = self.__get_other_player(player)
	if self.increment_score(scorer) < DataStore.global_settings.winning_score:
		self.serve()
	else:
		self.end_game(scorer)


func __get_other_player(player: Player):
	return player1 if player == player2 else player2


func _on_pause_menu_save_and_exit_pressed() -> void:
	var player1_score = self.player_scores[str(self.player1)]
	var player2_score = self.player_scores[str(self.player2)]
	DataStore.save_game(player1_score, player2_score)
	get_tree().change_scene_to_file("res://scenes/menu/Menu.tscn")


func __init_score() -> void:
	self.player_scores[str(player1)] = DataStore.game.player1_score
	self.player_scores[str(player2)] = DataStore.game.player2_score
	self.update_score()


func _on_game_over_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/Menu.tscn")


func _on_game_over_rematch_pressed() -> void:
	DataStore.game = Game.new()
	get_tree().change_scene_to_file("res://scenes/main/Main.tscn")
