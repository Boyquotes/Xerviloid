extends Area2D


var joueurs
var joueurs_inactifs
var joueur_actif
var corps

export var teleportation =[false,Vector2()]

#export var position_joueur=Vector2()#on l<utilise pour tasser le joueur inactif de la zone si on change de vue
#est ce que ]a chnage qqchose

export var haut_ou_cote ="cote"
#export var position_joueur=Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
#	racine = get_owner()#(:
	joueurs = Global.joueurs
	joueurs_inactifs = Global.joueurs_inactifs
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var index_joueur = corps.get_index()
	#if not Input.is_action_pressed("mouvement_haut"):
	corps.camera =get_parent()
	get_parent().make_current()
	
	if not haut_ou_cote in corps.name:
		Global.sauvegardes_undo.back().push_front([true, index_joueur])
		Global.defered_reparent(index_joueur)
	if teleportation[0]:
		get_owner().get_child(0).get_child(index_joueur).position = teleportation[1]
	set_process(false)
	$TimerEntree.start(.1)


func _on_Area2D_body_entered(body):#rentre 2 fois

	# Trouver pourquoi ça rentre 2 fois, solution du timer devrait être temporaire peut-etre a cause de l<heritage, plusieurs physic process
	if $TimerEntree.is_stopped():
		#print(body.position,body.name)
		$TimerEntree.start(.1)
		if "Joueur" in body.name:#get_physics_process_delta_time()
			corps=body
			set_process(true)
			
			
