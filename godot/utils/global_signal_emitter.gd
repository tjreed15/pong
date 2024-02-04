extends Node


@export var given: int
@export var mappers: Array[GlobalSignalMapper] = [
	GlobalSignalMapper.__initialize("Button", "pressed", SignalBus.button_pressed),
	GlobalSignalMapper.__initialize("Button", "mouse_entered", SignalBus.button_hovered),
]


func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	connect_tree(get_tree().root)
	get_tree().node_added.connect(self.connect_node)


func connect_node(node):
	for mapper in self.mappers:
		mapper.connect_node(node)


func connect_tree(root: Node):
	connect_node(root)
	for child in root.get_children():
		connect_tree(child)
