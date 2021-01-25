extends Node

func _ready():
	for i in get_children(): #joueur courrant
		i.set_active(false)
