class_name WinLossCount extends Resource


@export var wins = 0
@export var losses = 0

func update(win: bool) -> void:
	if win:
		self.wins += 1
	else:
		self.losses += 1
