extends State
 
func enter():
	super.enter()
	attack()
 
func attack():
	animation_player.play("Attack")
	await animation_player.animation_finished


func combo():
	var move_set = ["1","1","2"]
	for i in move_set:
		await attack()

 
func transition():
	if owner.direction.length() > 100:
		get_parent().change_state("Follow")
