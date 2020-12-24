##########################set pixel #######################
.data
outsideErrorPrint:	.asciiz "Error, location outside the image!"

.text
.globl set_pixel
set_pixel:
	# $a0 -> image struct
	# $a1 -> row number
	# $a2 -> column number
	# $a3 -> new value (clipped at 255)
	###############return################
	#void
	# Add code here
	
	lw $t0, 0($a0)		# loading width       
  	lw $t1, 4($a0)         	# loading height
	
	bltz $a1, error		# row < 0, error
	ble $t0, $a1, error	# width <= row, error
	bltz $a2, error		# column < 0, error
	ble $t1, $a2, error	# height <= column, error
	bgt $a3, 255, set	# value > 255

	addi $a0, $a0, 12 	# pointer to struct uint8_t array
  
	addi $a1, $a1, -1	# [0 -> width - 1]
	mul $t2, $t1, $a1 	# (arranged) width * row
  
	add $t3, $t2, $a2	# column + width * row // i * width + j
	add $t3, $t3, $a0	# pixel value for array index a1,a2
  
	move $a0, $t3		# copying into v0

	jr $ra

set:
	li $a3, 255		#load 255
	jr $ra

error:
	move $v0, $zero		# return zero
	li $v0, 4
	la $a0, outsideErrorPrint
	syscall
	
