class_name GlobalSignalMapper extends Resource


func DEFAULT_PARAM_MAP_CREATOR(node: Node) -> Callable:
	return func(): self.global_signal.emit(node)


@export var class_type: String
@export var local_signal: String
@export var global_signal: Signal
@export var param_map_creator: Callable = Callable() :
	get:
		if param_map_creator == Callable():
			return DEFAULT_PARAM_MAP_CREATOR
		return param_map_creator


@warning_ignore("shadowed_variable")
static func __initialize(
	class_type: String,
	local_signal: String,
	global_signal: Signal,
	param_map_creator: Callable = Callable(),
) -> GlobalSignalMapper:
	var mapper = GlobalSignalMapper.new()
	mapper.class_type = class_type
	mapper.local_signal = local_signal
	mapper.global_signal = global_signal
	mapper.param_map_creator = param_map_creator
	return mapper


# TODO: Handle parms passed in local_signal -> globa_signal
func connect_node(node: Node) -> void:
	if node.is_class(self.class_type):
		var callback: Callable = self.param_map_creator.call(node)
		var sig: Signal = node[self.local_signal]
		sig.connect(callback)

