extends "res://Scripts/objets_en_mouvement/Objet_bouge.gd"
var joueur_peut_monter=false
var active = true setget set_active
export var index_camera =0
var camera
var est_joueur_courant = false
var position_original = Vector2()
var speed = 200
var gravity = 1300
var facing_right =1
var facing_up =1
var dialogue_path = ""
var change_direction=[false,false]
var direction = Vector2()
func _ready():
	# Trop dépendant de structure
	if "Joueur" in self.name:
		camera = get_owner().get_child(2).get_child(index_camera)#marche pas pour joueur inactif
	position_original=position
func set_active(value):

	active = value
	set_physics_process(value)
	set_process(value)
	set_visible(value)

	#get_node("CollisionShape2D").disabled= value
#	if not value:#je ne suis pas capabvle de désactiver les collisions
#		position_original = position
#		position = Vector2(10000,10000)
#	else: position =position_original


