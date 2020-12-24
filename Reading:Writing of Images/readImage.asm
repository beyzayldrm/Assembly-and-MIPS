#########################Read Image#########################
.data
# feep:			.asciiz "feep.pgm"

header:			.space 10
image:			.word 16

openErrorPrint:		.asciiz "Error opening the file."
closeErrorPrint:	.asciiz "Error closing the file."
readErrorPrint:		.asciiz "Error writing to file."

.text
		.globl read_image
		
read_image:
	# $a0 -> input file name
	################# return #####################
	# $v0 -> Image struct :
	# struct image {
	#	int width;
	#       int height;
	#	int max_value;
	#	char contents[width*height];
	#	}
	##############################################
	# Add code here
	addi $sp, $sp, 4 
        sw $ra, 0($sp)
        la $s0, header
	
	# Opens file
	li $v0, 13		# system call for open file
	#la $a0, feep		# $a0 -> input filename (already done in main)
	li $a1, 0		# opens file for reading(0)
	li $a2, 0        	# mode is ignored
	syscall
	blez $v0, openError
	move $t0, $v0		# saves file descriptor
	
	# read file into header
	li $v0, 14		# system call for read file (into buffer)
	la $a1, header		# address of header
	li $a2, 10		# hardcoded header length
	move $a0, $t0		# saves file descriptor to a0
	syscall
	blez $v0, readError
	
 	# Close the file
 	li $v0, 16 		# system call for close file 
 	move $a0, $t0 		# restores file descriptor
 	syscall 		# closes file
	blez $v0, closeError
	
	# struct image {
	li $t2, 6		# 4 whitespaces + 2 bytes of P2
	la $a0, 3($s0)          
	la $a0, 1($t0)		
	jal struct_var
	move $s1, $v0		# copying int width in s1     
	move $s2, $v0		# copying int height in s2          
	move $s3, $v0		# copying int max_value in s3
	
	# return
	lb $v0, 1($a1)
	move $s4, $v0
	lw $a0, image
	jal malloc
	
  	sw $s1, 0($v0)		# storing width       
  	sw $s2, 4($v0)         	# storing height
  	sw $s3, 8($v0)		# storing max_value
  	sw $t2, 12($v0)        	# storing uint_8t
  	
  	move $v0, $s4		# storing address
	
	beq $v0,'2',P2
	beq $v0, '5', P5
	
	jr $ra	

struct_var:
	la $t0, 0($a0)          
	add $t2, $t2, $v1
	jr $ra
	
atoi:         
	li $t7, 10
	lbu $t3, ($s1)		# load unsigned char from array into s1
	bgt $t3, 57, digit	# check if char is not a digit (ascii>'9')
	blt $t3, 48, digit	# check if char is not a digit (ascii<'0')
	addi $t3, $t3, -48	# converts s1's ascii value to dec value
	mul $s2, $s2, $t7	# sum *= 10
	add $t2, $t2, $t3	# sum += array[s1]-'0'
	addi $t2, $t2, 1	# increment array address
	j atoi			# jump to start of loop

digit:
	jr $ra

malloc:
	li $v0, 9		# dynamic memory allocation
	syscall
	jr $ra

P2:
	jr $ra

P5:
	jr $ra
	
# Errors:

openError:
	li $v0, 4
	la $a0, openErrorPrint
	syscall

closeError:
	li $v0, 4
	la $a0, closeErrorPrint
	syscall

readError:
	li $v0, 4
	la $a0, readErrorPrint
	syscall
	
