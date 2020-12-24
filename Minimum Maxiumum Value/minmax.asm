# This program illustrates the exercise of finding the maximum and minimum values in an array.
# The array in this example has hardcoded initial values.
# The subroutine 'minmax' should return the minimum and maximum values
# in the array, using appropriate registers.
# The 'main' program should test the subroutine and should print the results using syscalls for printing.
# Feel free to add additional entries as you need them in the .text or .data segments.
# Make sure that your 'main' program terminates gracefully.
# Be sure to comment your code. Use proper register conventions!
# ---------------------------------------------------------------------------------------------------------
# The aim/algorithm of my MIPS subroutine:
# 	getMinMax(int [] array1, int size){
#		int firstMin = array1[0];
#		int firstMax = array1[0];
#		for(int i=1; i<size; i++){
#			int second = array1[i]
#			if (firstMin > second){ firstMin = second }
#			if (firstMax < second){ firstMax = second }
#		}
# 	return firstMin;
# 	return firstMax;
# 	}

	.data
	SmallestNumber: .asciiz "Smallest number in the array: "
	NewLine: .asciiz "\n"
	LargestNumber: .asciiz "Largest number in the array: "

	
# An array, with hard-coded values, to use for testing
array1:	.word 23, 45, -2, 4, 6, 42, 7, 35, 10, 2, -332, 101, 2, 3, 110, -1
size: .word 16

	.text
	.globl main

main: 
	la $t0, array1
    	lw $s0, 0($t0)  	#setting the temp. smallest and largest to first value in array
    	lw $s1, 0($t0)  	
   	addi $t4, $zero, 0      #setting the counter to 0
   	li $t1, 0   		#setting size of the array to 16
	
	jal minmax		#calling minmax subroutine
	li $v0, 10		#exiting the program
	syscall

minmax:
	loop: 
    		bge $t4, 16, endloop
   		lw $t2, array1($t1)
   		bgt $t2, $s0, largest
   		blt $t2, $s1, smallest
	
	secondloop:
  		addi $t1, $t1, 4 	#increasing the index
  		addi $t4, $t4, 1 	#incrementing the counter
  		j loop

	largest:			# if (firstMax < second)
    		move $s0, $t2		# { firstMax = second }
   		j secondloop

	smallest: 			# if (firstMin > second)
    		move $s1, $t2		# { firstMin = second }
    		j secondloop

	endloop:
		li $v0 4
		la $a0 SmallestNumber
 		syscall

    		li $v0 1
		la $a0 ($s1)
    		syscall

		li $v0 4
		la $a0 NewLine
		syscall
    
		li $v0 4
		la $a0 LargestNumber
		syscall
	
		li $v0 1
		la $a0 ($s0)
		syscall