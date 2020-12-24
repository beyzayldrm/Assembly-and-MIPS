##########################get pixel #######################
.data
outsideErrorPrint:	.asciiz "Error, location outside the image!"

.text
.globl get_pixel

get_pixel:
	# $a0 -> image struct
	# $a1 -> row number
	# $a2 -> column number
	################return##################
	# $v0 -> value of image at (row,column)
	#######################################
	# Add Code
	
	lw $t0, 0($a0)		# loading width       
  	lw $t1, 4($a0)         	# loading height
	
	bltz $a1, error		# row < 0, error
	ble $t0, $a1, error	# width <= row, error
	bltz $a2, error		# column < 0, error
	ble $t1, $a2, error	# height <= column, error

	addi $a0, $a0, 12 	# pointer to struct uint8_t array
  
	addi $a1, $a1, -1	# [0 -> width - 1]
	mul $t2, $t1, $a1 	# width * row
  
	add $t2, $t2, $a2	# column + width * row // i * width + j
	add $t2, $t2, $a0	# pixel value for array index a1,a2
  
	move $v0, $t2		# copying into v0

	jr $ra

error:
	move $v0, $zero		# return zero
	li $v0, 4
	la $a0, outsideErrorPrint
	syscall
