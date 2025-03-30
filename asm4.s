.data

	.asciiz		.word		"Turtle "
	.asciiz		.word		"   pos "
	.asciiz		.word		"   dir "
	.asciiz		.word		"   odometer "

.text

turtle_init:
	
	# standard prologue 
	addiu	$sp, $sp, -24
	sw	$fp, $fp, 0($sp)
	sw	$ra, 4($sp)
	addiu 	$fp, $sp, 20
	
	# store all fields of Turtle struct 
	
	sb 	$t0, 0($a0)		# store char x;
	sb	$t0, 1($a0)		# store char y;
	sb	$t0, 2($a0)		# store char dir;
	sw	$t0, 4($a0)		# store name of turtle
	sw	$t0, 8($a0)		# store the odomoter 
	
	# standard epilogue 
	lw	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra

turtle_debug:

	# standard prologue 
	addiu	$sp, $sp, -24
	sw	$fp, $fp, 0($sp)
	sw	$ra, 4($sp)
	addiu 	$fp, $sp, 20
	
	# print out all fields of Turtle 
	# access all variables of Turtle and print them out (syscall)
	
	
	# standard epilogue 
	lw	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra
	
turtle_turnLeft:

	# standard prologue 
	addiu	$sp, $sp, -24
	sw	$fp, $fp, 0($sp)
	sw	$ra, 4($sp)
	addiu 	$fp, $sp, 20
	
	# turn the Turtle to the left 
	lb	$t0, 2($a0)		# load dir field
	beq	$t0, $zero, zeroLeft	# if dir is zero, go to zeroLeft
	addi 	$t0, $t0, -1		# subtract dir by 1 to turn left 
	sb	$t0, 2($a0)		# store dir back
	
zeroLeft: 
	addi	$t0, $t0, 3		# if dir is zero, turning left turns dir into 3
	sb	$t0, 2($a0)		# store dir back 
	
	# standard epilogue 
	lw	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra


turtle_turnRight: 
	
	# standard prologue 
	addiu	$sp, $sp, -24
	sw	$fp, $fp, 0($sp)
	sw	$ra, 4($sp)
	addiu 	$fp, $sp, 20
	
	# turn Turtle to right 
	lb 	$t0, 2($a0)		# load dir field
	addi 	$t1, $zero, 3		# load temporary register to 3
	beq	$t0, $t1, threeRight	# check is dir equal to 3
	addi	$t0, $zero, 1		# add 1 to dir to turn right 
	sb	$t0, 2($a0)		# store dir field back 
	
threeRight: 
	addi	$t0, $zero, -3		# if dir is 3, turning right equals to zero 
	sb	$t0, 2($a0)		# store dir back
	
	# standard epilogue 
	lw	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra
	

turtle_move:

	# standard prologue 
	addiu	$sp, $sp, -24
	sw	$fp, $fp, 0($sp)
	sw	$ra, 4($sp)
	addiu 	$fp, $sp, 20
	
	# move Turtle forward  
	# check Java Code to translate to MIPS 
	
	# standard epilogue 
	lw	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra
	

turtle_searchName:
	
	# standard prologue 
	addiu	$sp, $sp, -24
	sw	$fp, $fp, 0($sp)
	sw	$ra, 4($sp)
	addiu 	$fp, $sp, 20
	
	# search for specfic Turtle "name"
	# use strcomp() ? 
	
	
	# standard epilogue 
	lw	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra
	

turtle_sortByX_indirect:

