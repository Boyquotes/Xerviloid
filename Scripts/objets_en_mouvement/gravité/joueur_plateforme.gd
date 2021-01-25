extends "res://Scripts/objets_en_mouvement/gravité/objets_gravite.gd"

var vitesse_saut = 500
signal undo
var position_precedente

func _ready():
	position_precedente=position
	connect("undo",Global,"undo")


func _physics_process(delta):
	if est_joueur_courant:
	#on pese sur z pour annuler un mouvement
		if Input.is_action_pressed("z"):
			emit_signal("undo")
		else:
			direction.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
			direction.y = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
			if direction.x > 0:
				facing_right=1
			elif direction.x < 0:
				facing_right=-1
			if position_precedente!=position:
				velocity.x = (direction.x*speed)
				if velocity!= Vector2() : 
					Global.emit_signal("action")
					position_precedente=position
	else: velocity.x=0
		
	if snap:
		move_and_slide_with_snap(velocity,Vector2(0,1),Vector2(0,-1))
	else:
		move_and_slide(velocity,Vector2(0,-1))
	
