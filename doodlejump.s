#####################################################################
#
# CSC258H5S Winter 2021 Assembly Programming Project
# University of Toronto Mississauga
#
# Group members:
# - Student 1: Sasan Makvandi,  1995239136
# - Student 2 (if any): Name, Student Number
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8					     
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4/5 (choose the one the applies)
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################


# Demo for painting
#
# Bitmap Display Configuration::
# - Unit width in pixels: 8					     
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
.data
	displayAddress:	.word	0x10008000
	four: .word 4
	thirty: .word 120
.text
	lw $t0, displayAddress	# $t0 stores the base address for display
	li $t1, 0xfffaf5	# $t1 stores the white colour code
	li $t4, 0x8ec27e	# $t2 stores the green colour code
	li $t3, 0xff0000	# $t3 stores the red colour code
	li $t6, 0x0000ff
	li $t8, 4098
	
	
	# I will be using $t8 for the position of the character
	
	sw $t1, 0($t0)	 # paint the first (top-left) unit red. 
		
		
	lw $t0, displayAddress
	#first loop paints the whole display white
	LOOPINIT:
		li $t2, 0 #the loop variant
	WHILE:
		sw $t1, ($t0) #store the location of the white in first position
		addi $t2, $t2, 4 #increment by a byte for the loop variant
		add $t0, $t0, 4 #increment by a byte
		
		beq $t2, 4092, THEN #branch if t2 is equal to 4092, if so move on to THEN
		
		j WHILE
	THEN:
		sw $t1, ($t0) #store the value of t0 in t1
		addi $t2, $t2, 4 #increment by a byte
		
		j DONE #jump to done
	DONE:
	
	SETTINGTHINGS:
		
	#making the doodle
	lw $t0, displayAddress
	MAKECHAR:
		li $t2, 0 # loop variant
		sw $t1, 0($t0) #store the array address in $t1
	WHILE3:
		sw $t1, 0($t0)
		addi $t2, $t2, 4
		add $t0, $t0, 4
		beq $t2, 3760, MAKINGHEAD #making the head of the character
		li $s2, 4
		mult $t8, $s2
		mfhi $s2
		addi $s1, $s2, 120 #finding where the position of the body should be
		beq $t2, $s1 , MAKEBODY #adding 32 *4 to get the exact position on the row bellow
		beq, $t2, 4092, DONE3
		
		j WHILE3
		
	MAKINGHEAD:
		sw $t8, ($t0) #will be the pointer for the character
		sw $t6, ($t0) #next following will be the painting of the head
		add $t0, $t0, 4
		sw $t6, ($t0)
		addi $t2, $t2, 4
		j WHILE3 #jump back to the loop to paint the rest
	
	MAKEBODY:
		sw $t6, ($t0)
		add $t0, $t0, 8
		sw $t6, ($t0)
		addi $t2, $t2, 8
		j WHILE3
	
	DONE3:
	
	
	
	
	
	
	
	
	MAKEPLAT:
		lw $t0, displayAddress 
		li $t2, 0 #load the value 0 for the loop
		addi $a1, $zero, 32 
		addi $v0, $zero, 42 #random int
		syscall
		move $t3, $a0
		mul $a0, $a0, 4
		add $a0, $a0, 3968
		add $t0, $t0, $a0
		
	IF:
		bgt $t3, 15, WHILE_LEFT
		ble $t3, 15, WHILE_RIGHT
		
	WHILE_RIGHT:	
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, 4
		
		beq $t2, 9, THEN2
		
		
		j WHILE_RIGHT
	WHILE_LEFT:
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, -4
		
		beq $t2, 9, THEN2
		
		
		j WHILE_LEFT
		
	THEN2:
		j DONE2
	DONE2:
	
	
	
	
	
	
	MAINLOOP:
		
		
	
	
Exit:
	li $v0, 10 # terminate the program gracefully
	syscall
