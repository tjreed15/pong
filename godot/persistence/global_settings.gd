class_name GlobalSettings extends Resource


const SAVE_FILE: String = "user://gloabl_settings.res"


@export var difficulty_level: Difficulty.Level = Difficulty.Level.EASY
@export var winning_score: int = 7


static func load_settings() -> GlobalSettings:
	if ResourceLoader.exists(SAVE_FILE):
		var settings = ResourceLoader.load(SAVE_FILE)
		print(settings)
		if settings is GlobalSettings:
			return settings
	return GlobalSettings.new()
	
func save_settings() -> Error:
	return ResourceSaver.save(self, SAVE_FILE)
