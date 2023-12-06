extends Node


const SCORE_DELIMETER = " : "
const END_GAME_TIME = 1.5


@onready var score_label: Label = %ScoreLabel
@onready var ball: Ball = $Ball
@onready var player1: Player = $Player1
@onready var player2: Player = $Player2
@onready var ai_controller: AIController = $Player2/Paddle/AIController
@onready var server: Player = self.player1
@onready var player_scores: Dictionary = {str(player1): 0, str(player2): 0}


func _ready() -> void:
	var difficulty = DataStore.global_settings.difficulty_level
	self.ai_controller.max_speed = (difficulty+2) * 250
	self.ai_controller.deviations = difficulty + 1
	self.serve()


func serve() -> void:
	self.ball.position = Constants.SCREEN_CENTER
	self.ball.set_direction(self.server.get_normal().rotated(randf_range(-PI/4, PI/4)))
	self.ball.set_speed(self.ball.initial_speed)


func update_score(scorer: Player) -> int:
	self.player_scores[str(scorer)] += 1
	var score_string = ""
	for score in self.player_scores.values():
		score_string += str(score) + SCORE_DELIMETER
	self.score_label.text =  score_string.left(-SCORE_DELIMETER.length())
	return self.player_scores[str(scorer)]


func end_game(winner: Player) -> void:
	DataStore.tally_game(winner == self.player1)	
	self.score_label.text += "\n" + winner.player_name + " wins!"
	self.ball.queue_free()
	var exploder = PlayerExploder.new()
	self.__get_other_player(winner).add_child(exploder)
	await get_tree().create_timer(END_GAME_TIME).timeout
	get_tree().change_scene_to_file("res://scenes/menu/Menu.tscn")


func _on_player_scored_on(player: Player) -> void:
	self.server = player
	var scorer = self.__get_other_player(player)
	if self.update_score(scorer) < DataStore.global_settings.winning_score:
		self.serve()
	else:
		self.end_game(scorer)


func __get_other_player(player: Player):
	return player1 if player == player2 else player2
