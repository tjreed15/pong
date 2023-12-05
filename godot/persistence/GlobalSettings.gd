class_name GlobalSettings extends Resource

const SAVE_FILE: String = "user://gloabl_settings.res"

@export var difficultyLevel: Difficulty.Level = Difficulty.Level.Easy
@export var winningScore: int = 7

static func loadSettings() -> GlobalSettings:
	if ResourceLoader.exists(SAVE_FILE):
		var settings = ResourceLoader.load(SAVE_FILE)
		print(settings)
		if settings is GlobalSettings:
			return settings
	return GlobalSettings.new()
	
func saveSettings() -> Error:
	return ResourceSaver.save(self, SAVE_FILE)
