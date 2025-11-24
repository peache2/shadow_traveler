extends State
 
func enter():
	super.enter()
	animation_player.play("Death")
 
func boss_slained():
	animation_player.play("boss_slained") 
	$"../../Knockout".play()
