extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer
var joueur_courant = 0
var joueur_suivant
var qte_joueurs

# Called when the node enters the scene tree for the first time.
func _ready():
	qte_joueurs = get_parent().get_child(0).get_children().size()
	ajouterPortraits()
	timer = $Timer
	timer.set_wait_time(3)
	timer.start()


func ajouterPortraits():
	for e in range(qte_joueurs):
		var texture = load('res://Art/Personnages/Joueur/PortraitJoueur' + str(e) + '.png')
		get_child(e).set_texture(texture)

func _process(delta):
	if Input.is_action_just_pressed('ui_q') or Input.is_action_just_pressed("ui_e"):
		set_visible(true)
		timer.set_wait_time(3)
		timer.start()
		if Input.is_action_just_pressed('ui_q'):
			joueur_suivant = (joueur_courant - 1) % qte_joueurs if joueur_courant - 1 != -1 else qte_joueurs - 1
			
		elif Input.is_action_just_pressed("ui_e"):
			joueur_suivant = (joueur_courant + 1) % qte_joueurs
		get_owner().get_child(0).get_child(joueur_courant).est_joueur_courant =false
		get_owner().get_child(0).get_child(joueur_suivant).est_joueur_courant =true
		get_owner().get_child(0).get_child(joueur_suivant).camera.make_current()
		joueur_courant = joueur_suivant

func _on_Timer_timeout():
	set_visible(false)

