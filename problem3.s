.data
buffer:			.space 1024
bufferSmaller:		.space 1024
prompt: 		.asciiz "Enter the input string: "
spaceChar: 		.asciiz " "
newLine: 		.asciiz "\n"
		
		.text
		.globl main

main:	li $v0, 4
	la $a0, prompt
	syscall
	
	la $t0, buffer
	la $t1, spaceChar
	lb $t1, 0($t1)
	la $t7, newLine
	lb $t7, 0($t7)
	
	li $v0, 8
	la $a0, buffer
	li $a1, 100
	syscall

# abBaBBc
# abbabbc
			
	la $t3, bufferSmaller
	add $t4, $0, $0
	li $s0, 90
	

Loop:	lb $t2, 0($t0)  #load character read 
	beq $t2, $t7, end  #check if it is new line character
	add $t0, $t0, 1
	ori $t4, $t2, 0x20
	sb $t4, 0($t3)
	add $t3, $t3, 1

	j Loop
	
end:	li $v0, 4 #Print string
	la $a0, bufferSmaller
	syscall 
	
	#exit program
	li $v0, 10
	syscall
	
