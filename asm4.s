.data

turtle: 	.asciiz		"Turtle \""
rightquote: 	.asciiz		" \"\n"
pos:		.asciiz		"   pos "
comma: 		.asciiz		","
dir: 		.asciiz		"   dir "
north: 		.asciiz		"North\n"
south:		.asciiz		"South\n" 
west: 		.asciiz		"West\n"
east:		.asciiz		"East\n"
odomoeter:      .asciiz		"   odometer "
newline: 	.asciiz		"\n"

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
	
	addiu   $v0, $zero, 4		# print turtle 
	la      $a0, turtle
	syscall 
	
	addiu   $v0, $zero, 4		# print name field 
	sw	$t0, 4($a0)
	la      $a0, $t0		
	syscall
	
	addiu   $v0, $zero, 4		# print rightquote 
	la      $a0, rightquote
	syscall 
	
	addiu   $v0, $zero, 4		# print pos 
	la      $a0, pos
	syscall 
	
	addiu   $v0, $zero, 4		# print x field 
	sw	$t0, 0($a0)
	la      $a0, $t0		
	syscall
	
	addiu   $v0, $zero, 4		# print comma 
	la      $a0, comma		
	syscall
	
	addiu   $v0, $zero, 4		# print y field 
	sw	$t0, 1($a0)
	la      $a0, $t0		
	syscall
	
	addiu   $v0, $zero, 4		# print newline 
	la      $a0, newline		
	syscall
	
	addiu   $v0, $zero, 4		# print dir 
	la      $a0, dir		
	syscall
	
	lb	$t0, 2($a0)		# load dir field 
	add	$t1, $zero, $zero	# create check variable 
	beq	$t0, $t1, printNorth	# if dir == 0, print north
	addi	$t1, $zero, 1		# check++
	beq	$t0, $t1, printEast	# if dir == 1, print east
	addi	$t1, $zero, 1		# check++
	beq	$t0, $t1, printSouth	# if dir == 2, print south
	addiu 	$t1, $zero, 1		# check++
	beq	$t0, $t1, printWest	# if dir == 3, print west
	
printNorth: 
	addiu   $v0, $zero, 4		# print north
	la      $a0, north		
	syscall
	j done
	
printEast:	
	addiu   $v0, $zero, 4		# print east
	la      $a0, east		
	syscall
	j done
	
printSouth:
	addiu   $v0, $zero, 4		# print south 
	la      $a0, south		
	syscall
	j done

printWest:
	addiu   $v0, $zero, 4		# print west 
	la      $a0, west	
	syscall

done: 
	addiu   $v0, $zero, 4		# print odometer
	la      $a0, odometer		
	syscall
	
	addiu   $v0, $zero, 1		# print odometer field 
	sw	$t0, 8($a0)
	la      $a0, $t0		
	syscall
	
	addiu   $v0, $zero, 4		# print newline
	la      $a0, newline		
	syscall
	
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
	
	# turn Turtle to the left 
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
	lb	$s0, 2($a0)		# grab dir field 
	add	$s1, $zero, $zero	# initiaite check variable 
	beq	$s0, $s1, moveY		# if dir == 0, moveNorth
	addi	$s1, $zero, 1		# check++
	beq	$s0, $s1, moveX		# if dir == 1, moveEast
	addi	$s0, $zero, 1		# check++
	beq	$s0, $s1, moveY		# if dir == 2, moveSouth
	addi	$s0, $zero, 1		# check++
	beq	$s0, $s1, moveX		# if dir == 3, moveWest
	
moveY:
	# initialize all fields of function 
	lb	$t0, 1($a0)		# grab y field
	beq 	$s0, $zero, addDistY	# if dir == North, add dist to Y
	j subDistY			# if dir == South, subtract dist to Y
	
addDistY:
	add	$t0, $a1, $zero		# y + dist
	
subDistY:
	sub	$t0, $a1, $zero		# y = dist 
	
	# create limit checks for coordinates
	addi	$t1, $zero, 10		# initialize 10 check
	addi	$t2, $zero, -10		# initialize -10 check
	
	# check if y is higher than 10 
	slt 	$t3, $t0, $t1		# if y < 10 
	beq	$t3, $zero, higherYTen	# if y > 10, go to higherTen
	
	#check if y is lower than - 10 
	slt	$t4, $t2, $t0		# if - 10 < y
	beq	$t4, $zero, lowerYTen	# if y < -10, go to lowerTen 
	j odomCheck
		
	# helper check to set y to 10
higherYTen:
	addi	$t0, $zero, 10		# set y == 10
	sb	1($a0), $t0		# store y back
	j odomCheck
	
	# helper check to set y = -10
lowerYTen: 
	addi	$t0, $zero, -10		# set y == -10
	sb	1($a0), $t0		# store y back
	j odomCheck
	
moveX:
	# initialize all fields of function 
	lb	$t0, 0($a0)		# grab x field
	addi	$t1, $zero, 1		# initiate check variable
	beq 	$s0, $t1, addDistX	# if dir == West, add dist to X
	j subDistX			# if dir == East, subtract dist to X
	
addDistX:
	add	$t0, $a1, $zero		# x + dist
	
subDistX:
	sub	$t0, $a1, $zero		# x = dist 
	
	# create limit checks for coordinates
	addi	$t1, $zero, 10		# initialize 10 check
	addi	$t2, $zero, -10		# initialize -10 check
	
	# check if x is higher than 10 
	slt 	$t3, $t0, $t1		# if y < 10 
	beq	$t3, $zero, higherXTen	# if y > 10, go to higherTen
	
	#check if x is lower than - 10 
	slt	$t4, $t2, $t0		# if - 10 < y
	beq	$t4, $zero, lowerXTen	# if y < -10, go to lowerTen 
	j odomCheck
		
	# helper check to set x to 10
higherXTen:
	addi	$t0, $zero, 10		# set y == 10
	sb	0($a0), $t0		# store x back
	j odomCheck
	
	# helper check to set x = -10
lowerXTen: 
	addi	$t0, $zero, -10		# set y == -10
	sb	0($a0), $t0		# store x back
	j odomCheck

	# add the distance to odometer
odomCheck:
	lw	$s2, 8($a0)		# load odometer 
	slt 	$t5, $a1, $zero		# if dist < 0
	beq	$t5, $zero, absValOdom	# if dist < 0, go to absValOdom
	add	$a1, $s2		# add dist to odometer
	sw	8($a0), $s2		# store odometer back 
	j done

	# helper check if distance is negative
absValOdom: 
	sub	$a1, $zero, $a1		# receive absolute value of distance
	add	$s2, $a1, $zero		# dist + odom
	sw	8($a0), $s2		# store odometer back
		
done:
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

