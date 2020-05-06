.data
buffer:			.space 1024
bufferSmaller:		.space 1024
prompt: 		.asciiz "Enter the input string: "
spaceChar: 		.asciiz " "
newLine: 		.asciiz "\n"
		
		.text
		.globl main

main:	li $v0, 4  # print string 
	la $a0, prompt  # take input string from user
	syscall
	
	la $t0, buffer
	la $t1, spaceChar  # space char
	lb $t1, 0($t1)
	la $t7, newLine  # newline char
	lb $t7, 0($t7)
	
	li $v0, 8  # read string
	la $a0, buffer
	li $a1, 100
	syscall

# abBaBBc
# abbabbc
			
	la $t3, bufferSmaller  # holding space for small version of string
	add $t4, $0, $0  # t4=0
	add $t5, $0, $0  # t5=0  -> counter for length of the string
	li $s0, 90  # s0 = 90
	

Loop:	lb $t2, 0($t0)  # load character read 
	beq $t2, $t7, end  # check if it is new line character
	add $t5, $t5, 1  # if character is not endline, increment counter
	add $t0, $t0, 1  # if not add 1 to iteration variable
	ori $t4, $t2, 0x20  # oring with 20 gives us small letter
	sb $t4, 0($t3)  # store smaller char version 
	add $t3, $t3, 1  # iterate to the next location

	j Loop  # return back to head of the loop
	
end:	li $v0, 4  # Print string
	la $a0, bufferSmaller
	syscall 
	
	# exit program
	li $v0, 10
	syscall
	
