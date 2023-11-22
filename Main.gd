extends Node

const CENTER = Vector2(1280/2.0, 720/2.0)
const BALL_SPEED = 500
const WINNING_SCORE = 7
const SCORE_DELIMETER = " : "

@onready var scoreLabel: Label = $ScoreLabel
@onready var ball: Ball = $Ball
@onready var player1: Player = $Player1
@onready var player2: Player = $Player2
@onready var server: Player = self.player1
@onready var playerScores: Dictionary = {str(player1): 0, str(player2): 0}

func _ready() -> void:
	serve()

func serve() -> void:
	self.ball.position = CENTER
	self.ball.velocity = self.server.get_normal().rotated(randf_range(-PI/4, PI/4)) * BALL_SPEED

func update_score(scorer: Player) -> int:
	self.playerScores[str(scorer)] += 1
	var scoreString = ""
	for score in self.playerScores.values():
		scoreString += str(score) + SCORE_DELIMETER
	self.scoreLabel.text =  scoreString.left(-SCORE_DELIMETER.length())
	return self.playerScores[str(scorer)]

func end_game(winner: Player) -> void:
	self.scoreLabel.text += "\n" + winner.player_name + " wins!"
	self.ball.queue_free()

func _on_player_scored_on(player: Player) -> void:
	var scorer = null
	if player == player1:
		self.server = self.player1
		scorer = self.player2
	else:
		self.server = self.player2
		scorer = self.player1
	
	if self.update_score(scorer) < WINNING_SCORE:
		self.serve()
	else:
		self.end_game(scorer)

