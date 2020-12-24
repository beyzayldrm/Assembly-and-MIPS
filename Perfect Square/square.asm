# This program illustrates an exercise of determining whether an integer is a perfect square.
# The subroutine 'square' return 1 if the input is a perfect square or 0 otherwise, using an appropriate return register.
# The 'main' program should test the subroutine by first prompting the user for an integer to test, and then
# calling the subroutine with that integer as an argument. Determining on the outcome of the test, the
# 'main' program should generate an appropriate print statement.
# Feel free to add additional entries as you need them in the .text or .data segments.
# Make sure that your 'main' program terminates gracefully.
# Be sure to comment your code. Use proper register conventions!
#--------------------------------------------------------------------------------------------------------------------------
# The aim/algorithm of my MIPS subroutine:
# perfectSquare(int n){
# 	for (int i = 1; i * i <= n; i++) {
# 		if ((n % i == 0) && (n / i == i)) {
# 			return 1;
# 		}
# 	}
#	return 0;
# }

	.data

prompt:	.asciiz "Enter a positive integer: \n"
PerfectSquare: "The integer you've entered is a perfect square."
NoPerfectSquare: "The integer you've entered is NOT a perfect square."

	.text
	.globl main

main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5			# getting user input
	syscall
	
	move $t0, $v0			# storing the value in a new variable for usage in the code
	
	addi $s0, $0, 1     		# i = 1
	
	jal square
	
	li $v0, 10			# exiting the program
	syscall

square:
loop:
	mult $s0, $s0
	mfhi $s1			# i * i
	
	div $t0, $s0		
	mfhi $s2			# n % i
	
	slt $t1, $s1, $t0 		# set to 1 if (i*i < n)
	beq $t1, $zero, notaSquare	# branch if condition fails, $t0 = 0
	move $t2, $s0			# temp value for old i
	addi $s0, $s0, 1		# increment i
	beq $s2, $0, secondcheck	# if ( n % i == 0) &&
	
	j loop
	
	secondcheck:
	div $t0, $t2		
	mflo $s3			# n / i
	
	beq $s3, $t2, isaSquare		# && ( n / i == i)
	bne $s3, $t2, loop
	
	li $v0, 10			# exiting program
	syscall
	
	isaSquare:
		li $v0, 4			# printing if number is perfect square
		la $a0, PerfectSquare
		syscall
		
		li $v0, 10			# exiting the program
		syscall
	
	notaSquare:
		li $v0, 4			# printing if number is not a perfect square
		la $a0, NoPerfectSquare
		syscall