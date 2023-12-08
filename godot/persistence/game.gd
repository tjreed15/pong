class_name Game extends Resource


const SAVE_FILE: String = "user://game.res"


@export var player1_score: int = 0
@export var player2_score: int = 0


static func load_game() -> Game:
	if ResourceLoader.exists(SAVE_FILE):
		var game = ResourceLoader.load(SAVE_FILE)
		print(game)
		if game is Game:
			return game
	return null


func save_game() -> Error:
	return ResourceSaver.save(self, SAVE_FILE)


func delete_saved_game() -> Error:
	return DirAccess.remove_absolute(SAVE_FILE)
