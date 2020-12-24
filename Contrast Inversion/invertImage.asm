#################################invert Image######################
.data
.text
.globl invert_image
invert_image:
	# $a0 -> image struct
	#############return###############
	# $v0 -> new inverted image
	############################
	# Add Code
	
	lw $t0, 0($a0)		# loading width       
  	lw $t1, 4($a0)         	# loading height
  	lw $t2, 8($a0)		# loading max_val

while: 
  	mul $s1, $t0, $t1	# width * height
  	addi $s0, $a0, 12 	# pointer to struct uint8_t array
  	
  	addi $a1, $a1, -1	# [0 -> width - 1]
	mul $t3, $t1, $a1 	# width * row
  
	add $t3, $t3, $a2	# column + width * row // i * width + j
	add $t3, $t3, $a0	# pixel value for array index a1,a2
	
	#sub $
  	
  	move $s2, $zero		# max = 0
	
	jr $ra
