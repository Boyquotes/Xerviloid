extends "res://Scripts/objets_en_mouvement/gravité/joueur_plateforme.gd"


func _ready():

	set_physics_process(true)
	set_process(true)
	est_joueur_courant =true
	

func _physics_process(delta):
	
	#quand le joueur est sur une porte montante
	if not Input.is_action_just_pressed("ui_up") and touche_porte(): 
		velocity.y = -128

	if est_joueur_courant and not Input.is_action_pressed("z"):
		raycastB.force_raycast_update()
		raycastB2.force_raycast_update()
		
		if Input.is_action_just_pressed("ui_up")  and (raycastB.is_colliding() or raycastB2.is_colliding()):
			velocity.y = -vitesse_saut

