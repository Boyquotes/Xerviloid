extends "res://Scripts/objets_en_mouvement/gravité/joueur_plateforme.gd"

var saut=0

func _ready():
	set_physics_process(true)
	set_process(true)
	est_joueur_courant =false
	

func _physics_process(delta):
	_move(delta)


func _move(delta):
	#quand le joueur est sur une porte montante
	if not Input.is_action_just_pressed("ui_up") and touche_porte(): 
		velocity.y = -128

	if est_joueur_courant and not Input.is_action_pressed("z"):
		raycastB.force_raycast_update()
		raycastB2.force_raycast_update()
		
		#on réinitialise le saut à zéro lorsque le joueur touche au sol
		if raycastB.is_colliding() or raycastB2.is_colliding():
			saut=0

	#lorsque le joueur saute, il peut double sauter
		if Input.is_action_just_pressed("ui_up")  and ((raycastB.is_colliding() or raycastB2.is_colliding()) or saut<2):
			if saut!=2 and not (raycastB.is_colliding() or raycastB2.is_colliding()):
				saut+=2
			else: saut+=1
			velocity.y = -vitesse_saut




		




	
