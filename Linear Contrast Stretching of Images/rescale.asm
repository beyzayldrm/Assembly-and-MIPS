###############################rescale image######################
.data
.text
.globl rescale_image
rescale_image:
	# $a0 -> image struct
	############return###########
	# $v0 -> rescaled image
	######################
	# Add Code
	
	lw $t0, 0($a0)		# loading width       
  	lw $t1, 4($a0)         	# loading height
  	lw $t2, 8($a0)		# loading max_val
	
	jr $ra
