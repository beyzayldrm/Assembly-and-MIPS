############################ Q1: file-io########################
.data
			.align 2
#inputTest1:		.asciiz "test1.txt"
#			.align 2
inputTest1:		.asciiz "test1.txt"
			.align 2
inputTest2:		.asciiz "test2.txt"
			.align 2
outputFile:		.asciiz "copy.pgm"
			.align 2
bufferR:		.space 1024
bufferW:		.asciiz "P2\n24 7\n15\n"		#contents hardcoded into buffer
			.align 2
openErrorPrint:		.asciiz "Error opening the file."
closeErrorPrint:	.asciiz "Error closing the file."
readErrorPrint:		.asciiz "Error writing to file."
writeErrorPrint:	.asciiz "Error reading the file."

.text
.globl fileio

fileio:
	
	la $a0,inputTest1
	#la $a0,inputTest2
	jal read_file
	
	la $a0,outputFile
	jal write_file
	
	li $v0,10		# exit...
	syscall	
	
read_file:
	# $a0 -> input filename	
	# Opens file
	# read file into buffer
	# return
	# Add code here
	
	# Opens file
	li $v0, 13		# system call for open file
	la $a0, inputTest1	# $a0 -> input filename
	li $a1, 0		# opens file for reading(0)
	li $a2, 0        	# mode is ignored
	syscall
	blez $v0, openError
	move $t0, $v0		# saves file descriptor
	
	# read file into buffer
	li $v0, 14		# system call for read file (into buffer)
	la $a1, bufferR		# address of buffer
	li $a2, 1024		# hardcoded buffer length
	move $a0, $t0		# saves file descriptor to a0
	syscall
	blez $v0, readError
	
	# Print read data to screen
 	la $a0, bufferR 	# load the address into $a0
 	li $v0, 4 		# print the string out
 	syscall
 	
 	# Close the file
 	li $v0, 16 		# system call for close file 
 	move $a0, $t0 		# restores file descriptor
 	syscall 		# closes file
	blez $v0, closeError
	
	jr $ra
	
write_file:
	# $a0 -> outputFilename
	# open file for writing
	# write following contents:
	# P2
	# 24 7
	# 15
	# write out contents read into buffer
	# close file
	# Add  code here
	
	# open file for writing
 	la $a0,outputFile 	# output file name
 	li $a1, 1 		# opens file for writing(1)
 	li $v0, 13		# system call for open file
 	li $a2, 0        	# mode is ignored
 	syscall
 	blez $v0, openError
 	move $t0, $v0 		# saves file descriptor

 	# write following contents
 	li $v0, 15 		# system call for write to file
 	la $a1, bufferW 	# address of buffer from which to write
 	li $a2, 1024 		# hardcoded buffer length
 	move $a0, $t0 		# put the file descriptor in $a0
 	syscall 		# write to file
 	blez $v0, writeError
 	
 	# close file
 	li $v0, 16 		# system call for close file
 	move $a0, $t0 		# restores file descriptor
 	syscall 		# closes file
	blez $v0, closeError
	
	jr $ra
		
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
	
writeError:
	li $v0, 4
	la $a0, writeErrorPrint
	syscall
	
