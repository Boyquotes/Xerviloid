extends "res://Scripts/objets_en_mouvement/vue_de_haut/Joueur_Haut.gd"

var zone_saut

func _ready():

	est_joueur_courant=false

func _physics_process(delta):

	if est_joueur_courant:

#ne fonctionne pas avec l'héritage
		if not tween.is_active():
			if direction.y==0:
				direction.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
			if direction.x==0:
				direction.y = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
		else: direction = Vector2()
		
		
		match direction:
			Vector2(-1, 0):
				change_direction[0]= self.scale.x==-1
				self.scale.x=-1
				facing_right=-1
				#la zone saut est une zone où le joueur 2 peut se teleporter
				$Zone_saut/Collision_saut.position = Vector2(64,16)
			Vector2(1, 0):
				change_direction[0]= self.scale.x==1
				self.scale.x=1
				facing_right=1
				$Zone_saut/Collision_saut.position = Vector2(64,16)
			Vector2(0, -1):
				facing_up = -1
				change_direction[1] = raycastB.scale.y==-1
				raycastB.scale.y=-1
				$Zone_saut/Collision_saut.position = Vector2(0,-48)
			Vector2(0,1):
				facing_up = 1
				change_direction[1] = raycastB.scale.y==1
				raycastB.scale.y=1
				$Zone_saut/Collision_saut.position = Vector2(0,80)

		raycastD.force_raycast_update()
		if change_direction[0] and direction.x != 0 and not raycastD.is_colliding():
			tween.interpolate_property(self, 'position', position, position + Vector2(Global.GRID_TAILLE*direction.x, 0), vitesse, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		raycastB.force_raycast_update()
		if change_direction[1] and direction.y != 0 and not raycastB.is_colliding():
			tween.interpolate_property(self, 'position', position, position + Vector2(0, Global.GRID_TAILLE*direction.y), vitesse, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			
		#le joueur se deplace et peut passer par dessus n'importe quoi pour se rendre à la position de zone saut
		if Input.is_action_just_pressed("ui_select") and not tween.is_active():
			if zone_saut==null:
				if $Zone_saut/Collision_saut.position.x !=0:
					tween.interpolate_property(self, 'position', position, position + Vector2(2*Global.GRID_TAILLE*facing_right, 0), vitesse, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				else:
					tween.interpolate_property(self, 'position', position, position + Vector2(0, 2*Global.GRID_TAILLE*facing_up), vitesse, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()


func _on_Zone_saut_body_entered(body):
	zone_saut=body

func _on_Zone_saut_body_exited(body):
	if body==zone_saut:
		zone_saut=null
