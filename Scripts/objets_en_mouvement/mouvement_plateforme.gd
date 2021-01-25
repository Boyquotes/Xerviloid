extends "res://Scripts/objets_en_mouvement/Objet_bouge.gd"

export var distance = Vector2()
export var vitesse =Vector2(0,128)
var accum =Vector2()
var position_origine
var position_finale 
var avance=Vector2()
var timer_fini
func _ready():
	position_origine = position
	position_finale = Vector2(distance.x+position_origine.x,distance.y+position_origine.y)
	timer_fini=true

func _physics_process(delta):
 #on deplace une plateforme et on veut qu'elle attande lorsqu'elle est au bout
	if timer_fini:
		if position_origine.x !=position_finale.x :
			if position.x<=position_origine.x:
				commencer_timer()
				avance.x = 1
			elif position.x>= position_finale.x:
				commencer_timer()
				avance.x = -1
		
		if position_origine.y !=position_finale.y :
			if position.y<=position_origine.y:
				commencer_timer()
				avance.y = 1
			elif position.y>= position_finale.y:
				commencer_timer()
				avance.y = -1

		accum+=Vector2(vitesse.x*avance.x,vitesse.y*avance.y)

		position = Vector2(position_origine.x+accum.x*delta,position_origine.y+accum.y*delta)


func _on_Timer_timeout():
	timer_fini = true

func commencer_timer():
	timer_fini=false
	$Timer.set_wait_time(2)
	$Timer.start()
