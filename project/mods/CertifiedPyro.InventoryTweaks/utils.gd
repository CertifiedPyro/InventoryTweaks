static func get_key_from_action(action: String) -> String:
	var action_list := InputMap.get_action_list(action)
	if action_list.size() == 0:
		return "null"
	
	var event := action_list[0] as InputEventKey
	var scancode := OS.keyboard_get_scancode_from_physical(event.physical_scancode)
	if scancode >= 32 and scancode <= 255:
		return char(scancode)
	else:
		return OS.get_scancode_string(scancode)
