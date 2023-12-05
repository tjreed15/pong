extends Node

const SCORE_DELIMETER = " : "
const END_GAME_TIME = 1.5

@onready var scoreLabel: Label = $ScoreLabel
@onready var ball: Ball = $Ball
@onready var player1: Player = $Player1
@onready var player2: Player = $Player2
@onready var aiController: AIController = $Player2/Paddle/AIController
@onready var server: Player = self.player1
@onready var playerScores: Dictionary = {str(player1): 0, str(player2): 0}

func _ready() -> void:
	var difficulty = DataStore.globalSettings.difficultyLevel
	self.aiController.maxSpeed = (difficulty+2) * 250
	self.aiController.deviations = difficulty + 1
	self.serve()

func serve() -> void:
	self.ball.position = Constants.SCREEN_CENTER
	self.ball.set_direction(self.server.get_normal().rotated(randf_range(-PI/4, PI/4)))
	self.ball.set_speed(self.ball.initial_speed)

func update_score(scorer: Player) -> int:
	self.playerScores[str(scorer)] += 1
	var scoreString = ""
	for score in self.playerScores.values():
		scoreString += str(score) + SCORE_DELIMETER
	self.scoreLabel.text =  scoreString.left(-SCORE_DELIMETER.length())
	return self.playerScores[str(scorer)]

func end_game(winner: Player) -> void:
	DataStore.tallyGame(winner == self.player1)	
	self.scoreLabel.text += "\n" + winner.player_name + " wins!"
	self.ball.queue_free()
	var exploder = PlayerExploder.new()
	self.__get_other_player(winner).add_child(exploder)
	await get_tree().create_timer(END_GAME_TIME).timeout
	get_tree().change_scene_to_file("res://scenes/menu/Menu.tscn")

func _on_player_scored_on(player: Player) -> void:
	self.server = player
	var scorer = self.__get_other_player(player)
	
	if self.update_score(scorer) < DataStore.globalSettings.winningScore:
		self.serve()
	else:
		self.end_game(scorer)

func __get_other_player(player: Player):
	return player1 if player == player2 else player2
