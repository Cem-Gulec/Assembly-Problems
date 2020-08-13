.data  # data declaration section
buffer:			.space 1024  # space for original string
bufferSmaller:		.space 1024  # space for string to be converted into smaller one
prompt: 		.asciiz "Enter the input string: "
spaceChar: 		.asciiz " "
newLine: 		.asciiz "\n"
palindrome: 		.asciiz " is palindrome."
notPalindrome: 		.asciiz " is not palindrome."
		
		.text
		.globl main

# t0: buffer variable
# t1: spaceChar
# t2: character read / first index
# t3: bufferSmaller variable
# t4: small letter variable / last index
# t5: counter
# t6: last index value
# t7: newLine / first index value


main:	li $v0, 4       # system call code for printing string = 4
	la $a0, prompt  # take input string from user
	syscall
	
	la $t0, buffer     # load label address of the original string
	la $t1, spaceChar  # space char
	lb $t1, 0($t1)     # load byte -> space character
	la $t7, newLine    # newline char
	lb $t7, 0($t7)     # load byte -> new line character
	
	li $v0, 8       # read the originalstring
	la $a0, buffer  # load label adress of buffer to the argument register
	li $a1, 100
	syscall

# First goal is to transform:
# example orginal string: abBaBBc
# to smaller letters    : abbabbc
			
	la $t3, bufferSmaller  # holding space for small version of string
	add $t4, $0, $0        # t4=0
	add $t5, $0, $0        # t5=0  -> counter for length of the string
	li $s0, 90             # s0 = 90
	
	move $a0, $v0
	jal Procedure_3
	j endProgram
	

# loop for reading string
Procedure_3:	
	
	addi $sp $sp, -4  # allocate space for 1 word
	sw $a0, 0($sp)    # save $a0 into stack
	
	Loop1:
	lb $t2, 0($t0)      # load character read 
	beq $t2, $t7, end1  # check if it is new line character
	add $t5, $t5, 1     # if character is not endline, increment counter
	add $t0, $t0, 1     # if not add 1 to iteration variable
	ori $t4, $t2, 0x20  # oring with 20 gives us small letter
	sb $t4, 0($t3)      # store smaller char version 
	add $t3, $t3, 1     # iterate to the next location

	j Loop1             # return back to head of the loop
	

	# loop for checking recurrently from 
	#first and last indexes to determine if it is palindrome
	Loop2:	
	bge $t2, $t4, endPalindrome  # if there is no violation to palindrome rule terminate program as printing "palindrome"
	lb $t6, ($t4)                # $t6 = last index value
	lb $t7, ($t2)                # $t7 = first index value
	
	bne $t6, $t7, endNotPalindrome  # if there is mismatch between letters terminate program as printing "not palindrome"
	sub $t4, $t4, 1                 # decrement last index by 1
	add $t2, $t2, 1                 # increment first index by 1
	j Loop2
	

	end1:	
	li $v0, 4              # system call code for printing string = 4
	la $a0, bufferSmaller  # loading adress of converted string into $a0
	syscall
	
	sub $t5, $t5, 1    # len - 1
	add $t2, $0, $0    #  resetting t2 to be used for first index
	add $t4, $t5, $a0  # $t4 = last index (updated with length)
	add $t2, $t2, $a0  # $t2 = first index
	j Loop2            # after printing jump to loop where we check if it is palindrome
	

	endPalindrome: 	
	li $v0, 4           # system call code for printing string = 4
	la $a0, palindrome  # print out that our string is palindrome
	syscall
	
	j Procedure_3_end	
			
	
	endNotPalindrome: 	
	li $v0, 4  	       # system call code for printing string = 4
	la $a0, notPalindrome  # print out that our string is not palindrome
	syscall
	

	Procedure_3_end:	
	lw $a0, 0($sp)		# restore $a0
	addi $sp, $sp, 4	# deallocate space
	jr $ra			# jump back to the return address


# exit program
endProgram:	
	li $v0, 10  # terminate program
	syscall
