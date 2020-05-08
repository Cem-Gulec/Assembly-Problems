.data ## Data declaration section
first_matrix: .space 1024
second_matrix: .space 1024
first_matrix_array: .space 1024
second_matrix_array: .space 1024
buffer:			.space 1024
bufferSmaller:		.space 1024
## String to be printed:
welcome: .asciiz "Welcome to our MIPS project!\n"
menu: .asciiz "\n\nMain Menu:\n1. Square Root Approximate\n2. Matrix Multiplication\n3. Palindrome\n4. Exit\nPlease select an option: "
out_string: .asciiz "\nEnter the number of iteration for the series: "
a_string: .asciiz "a: "
b_string: .asciiz "b: "
# queston 2 strings
enter_f_matrix: .asciiz "\nEnter the first matrix: "
enter_s_matrix: .asciiz "\nEnter the second matrix: "
enter_fd_matrix: .asciiz "\nEnter the first dimension of first matrix: "
enter_sd_matrix: .asciiz "\nEnter the second dimension of first matrix: "
multiplication_matrix: .asciiz "\nMultiplication matrix:\n"
# question 3 strings
prompt: 		.asciiz "Enter the input string: "
spaceChar: 		.asciiz " "
newLine: 		.asciiz "\n"
palindrome: 		.asciiz " is palindrome"
notPalindrome: 		.asciiz " is not palindrome"

.text ## Assembly language instructions go in text segment
.globl main
main:
# MENU
li $v0, 4 # system call code for printing string = 4
la $a0, welcome # load address of string to be printed into $a0
syscall
MENU:
li $v0, 4 # system call code for printing string = 4
la $a0, menu # load address of string to be printed into $a0
syscall
li $v0, 5 # read_int
syscall
# move $t9, $v0 # selection stored in $t9
li $t9, 1
bne $v0, $t9, check_next_2	# skip to next if this isn't the selection
# 1 is selected, call it's procedure
li $v0, 4 # system call code for printing string = 4
la $a0, out_string # load address of string to be printed into $a0
syscall # call operating system to perform operation

li $v0, 5 # read_int
syscall

move $a0, $v0
jal Procedure_1	# go to procedure with argument in $a0	
j MENU		# jump back to the menu after procedure returns


check_next_2:
li $t9, 2
bne $v0, $t9, check_next_3	# skip to next if this isn't the selection
# 2 is selected, call it's procedure
# take inputs and store them in $a0, $a1, $a2, $a3 registers before calling the procedure
li $v0, 4 # system call code for printing string = 4
la $a0, enter_f_matrix # Enter the first matrix
syscall # call operating system to perform operation
li $v0, 8 # read first matrix string
la $a0, first_matrix
li $a1, 1024
syscall

li $v0, 4 # system call code for printing string = 4
la $a0, enter_s_matrix # Enter the second matrix: 
syscall # call operating system to perform operation
li $v0, 8 # read secondrst matrix string
la $a0, second_matrix
li $a1, 1024
syscall
move $a0, $a1

li $v0, 4 # system call code for printing string = 4
la $a0, enter_fd_matrix # Enter the first dimension of first matrix: 
syscall
li $v0, 5 # read_int
syscall	# $a0 holds the integer read
add $a2, $zero, $v0	# move readed int ot $a2

li $v0, 4 # system call code for printing string = 4
la $a0, enter_sd_matrix # Enter the first dimension of first matrix: 
syscall
li $v0, 5 # read_int
syscall	# $a0 holds the integer read
add $a3, $zero, $v0	# move readed int to $a3

la $a0, first_matrix	#load first matrix's memory address into $a0
la $a1, second_matrix	#load second matrix's memory address into $a1
jal Procedure_q2	# go to procedure with arguments in $a0-$a3
j MENU		# jump back to the menu after procedure returns

check_next_3:
li $t9, 3
bne $v0, $t9, check_next_4	# skip to next if this isn't the selection
# 3 is selected, call it's procedure
# take inputs and store them in $a0, $a1, $a2, $a3 registers before calling the procedure

li $v0, 4       # system call code for printing string = 4
la $a0, prompt  # take input string from user
syscall

la $t0, buffer     # load label address of the original string
la $t1, spaceChar  # space char
lb $t1, 0($t1)     # load byte -> space character
la $t7, newLine    # newline char
lb $t7, 0($t7)     # load byte -> new line character

li $v0, 8       # read the original string
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
jal Procedure_3	# go to procedure with argument in $a0	
j MENU		# jump back to the menu after procedure returns

check_next_4:
li $t9, 4
beq $v0, $t9, EXIT	# exit if 4 is selected
j MENU			# jump back to MENU again





# $a0: int = number of iteration
Procedure_1:
# save $a0 to the stack
addi $sp $sp, -4 	# allcoate space for 1 word
sw $a0, 0($sp)		# save $a0 into stack

move $t0, $a0 # n stored in $t0
move $t7, $a0 # $t7 also stores copy of n, which is going to be used in second loop

# ititialize #$t1=a=1, $t2=b=1
li $t1, 1
li $t2, 1

# print a:
li $v0, 4
la $a0, a_string
syscall

whileA:	# loop
blez $t0, endwhileA # loop until n reaches 0 and jump to endwhile
# print current a value
li $v0, 1 # print_int
move $a0, $t1
syscall	# prints a's value
li $v0, 11  # syscall number for printing character
# print space, 32 is ASCII code for space
li $a0, 32
syscall # space -> ' '

sll $t3, $t2,1 # shift left b to calculate 2b
add $t2, $t2, $t1 # b = a + b
add $t1, $t1, $t3 # a = a + 2b
sub $t0, $t0, 1 # decrement by 1
j whileA
endwhileA:

# new line
li $v0, 11
li $a0, 10
syscall

# ititialize a=1, b=1 again
li $t1, 1
li $t2, 1

# print b:
li $v0, 4
la $a0, b_string
syscall

whileB:	# loop
blez $t7, endwhileB # loop until n reaches 0 and jump to endwhile
# print current a value
li $v0, 1 # print_int
move $a0, $t2
syscall	# prints b's value
# print space, 32 is ASCII code for space
li $a0, 32
li $v0, 11  # syscall number for printing character
syscall # space -> ' '

sll $t3, $t2,1 # shift left b to calculate 2b
add $t2, $t2, $t1 # b = a + b
add $t1, $t1, $t3 # a = a + 2b
sub $t7, $t7, 1 # decrement by 1
j whileB
endwhileB:

# end of Procedure_1
# restore $a0
lw $a0, 0($sp)		# restore $a0
addi $sp, $sp, 4	# deallocate space
jr $ra			# jump back to the return address






# $a0: addr = address of first matrix string
# $a1: addr = address of second matrix string
# $a2: int    = first dimension
# $a3: int    = second dimension
Procedure_q2:
# Save $a0-$a3 into stack to restore later
addi $sp, $sp, -16	# allocate 4 words
sw $a0, 12($sp)		# save $a0
sw $a1, 8($sp)		# save $a1
sw $a2, 4($sp)		# save $a2
sw $a3, 0($sp)		# save $a3

#la $s0, first_matrix_array	# address of parsed first matrix Array<int>
# loop first string
# PARSE AND SAVE INTO MEMORY START
la $s0, first_matrix_array
#add $s0, $zero, $zero	# $s0: index of first_matrix_array
add $t0, $a0, $zero	# $t0 now holds the string address
loop_q2_1:
lb $t1, 0($t0) 		# load 1 byte - a char
beq $t1, '\n', endloop_q2_1	# endline
beq $t1, ' ', nextchar_q2_1	# go to next character over the string if it's a space
# if not a space
## while loop to get full integer
# t2 holds the total value if current integers
add $t2, $zero, $zero	# $t2 = 0
j aa
integer_continued_q2_1:
# can be entered conditionally
# burada 10 ile carpip t2 ye ekle
li $t7, 10
# multiple $t2 my 10
mult $t2, $t7
mflo $t2	# t2 = t2 * 10
aa:
andi $t1, $t1, 0x0F	# ascii char to integer conversion
add $t2, $t2, $t1
# if next value isn't space jump to 
### NEXT VAL CHECK START
addi $t7, $t0, 1 	# &t7 = next character
lb $t7, 0($t7)
# eger \n veya ' ' ise save to memeory
beq $t7, '\n', save_mem_q2_1
beq $t7, ' ' , save_mem_q2_1
# otherwise go to restricted area
	# increase char pointer + 1
	addi $t0, $t0, 1  	# next char
	# set t1 to next char
	lb $t1, 0($t0)
j integer_continued_q2_1
### NEXT VAL CHECK END
save_mem_q2_1:
sw $t2, 0($s0)		# save integer to first_matrix_array[$s0]
addi $s0, $s0, 4	# next location
nextchar_q2_1:
addi $t0, $t0, 1  	# next char
j loop_q2_1
endloop_q2_1:
# PARSE AND SAVE INTO MEMORY END


# loop second string
# PARSE AND SAVE INTO MEMORY START
la $s1, second_matrix_array
#add $s0, $zero, $zero	# $s0: index of first_matrix_array
add $t0, $a1, $zero	# $t0 now holds the string address
loop_q2_2:
lb $t1, 0($t0) 		# load 1 byte - a char
beq $t1, '\n', endloop_q2_2	# endline
beq $t1, ' ', nextchar_q2_2	# go to next character over the string if it's a space
# if not a space
## while loop to get full integer
# t2 holds the total value if current integers
add $t2, $zero, $zero	# $t2 = 0
j aa_2
integer_continued_q2_2:
# can be entered conditionally
# burada 10 ile carpip t2 ye ekle
li $t7, 10
# multiple $t2 my 10
mult $t2, $t7
mflo $t2	# t2 = t2 * 10
aa_2:
andi $t1, $t1, 0x0F	# ascii char to integer conversion
add $t2, $t2, $t1
# if next value isn't space jump to 
### NEXT VAL CHECK START
addi $t7, $t0, 1 	# &t7 = next character
lb $t7, 0($t7)
# eger \n veya ' ' ise save to memeory
beq $t7, '\n', save_mem_q2_2
beq $t7, ' ' , save_mem_q2_2
# otherwise go to restricted area
	# increase char pointer + 1
	addi $t0, $t0, 1  	# next char
	# set t1 to next char
	lb $t1, 0($t0)
j integer_continued_q2_2
### NEXT VAL CHECK END
save_mem_q2_2:
sw $t2, 0($s1)		# save integer to first_matrix_array[$s0]
addi $s1, $s1, 4	# next location
nextchar_q2_2:
addi $t0, $t0, 1  	# next char
j loop_q2_2
endloop_q2_2:

li $t2, -1
sw $t2, 0($s1)	
# PARSE AND SAVE INTO MEMORY END


# CALCULATE THE DIMENSION OF SECOND MATRIX

# first, calcualte the length of 2nd matrix
add $t2, $zero, $zero		# t2 is the counter with initial value of 0
add $t0, $zero, $zero		# iterator for second matrix array
q2_calc_sec_legth:
lw $t1, second_matrix_array($t0)	# get the content of the second matrix
beq $t1, -1, end_q2_calc
# increase counter
addi $t2, $t2, 1	# t2 += 1
#li $v0, 1	# pritning fo rdebugging purposes
#add $a0, $zero, $t1
#syscall
addi $t0, $t0, 4
j q2_calc_sec_legth
end_q2_calc:

# make division to calcualte dimension of second matrix
div $t2, $a3	# t2 is the total length of second matrix
mflo $s7	# s7 holds the dimension of the second matrix

li $v0, 4 # system call code for printing string = 4
la $a0, multiplication_matrix # Multiplication matrix:
syscall # call operating system to perform operation

# corresponding c++ code:
#    for (int i = 0; i < a2; i++) // 3 times, one row of A each time
#    {
#        for (int j = 0; j < x; j++) // 2 times
#        {
#            int res = 0;
#            for (int k = 0; k < a3; k++)
#            {
#                res = res + (A[i][k] * B[k][j]);
#            }
#            cout << res << " ";
#        }
#        cout << endl;
#    }  
  
# outher loop, $a1 times
li $t0,0		# i = 0
q2_mult_outher_loop:
beq $t0, $a2, q2_mult_outher_loop_end	# loop until i < a2
	li $t1,0		# j = 0
	q2_mult_inner_loop:
	beq $t1, $s7, q2_mult_inner_loop_end
		li $s1, 0	#	s1 = res variable, initially zero
		li $t2, 0	# k = 0
		q2_mult_main_loop:
		beq $t2, $a3, q2_mult_main_loop_end
		# res = res + (A[i][k] * B[k][j]);
		# A[i][k] = a3 * i + k (address_of_matrix_1)
		
		# === calculate A[i][k] start ===
		# multiple $a3 with i 
		mult $a3, $t0		# a3 * i
		mflo $t3		# t3 = a3 * i
		add $t3, $t3, $t2	# t3 = a3 * i + k 	(index of the A to access)
		sll $t3, $t3, 2		# (t3 = a3 * i + k) * 4	(memory offset)
		lw $t3, first_matrix_array($t3)	# t3 =A[i][k]
		# === calculate A[i][k] end   ===
		# === calculate B[k][j] start ===
		# B[k][j] = k * x + j				0, 2, 4
		mult $t2, $s7		# k * x
		mflo $t4		# t4 = k * x
		add $t4, $t4, $t1	# t4 = k * x + j       (index of the B to access)
		sll $t4, $t4, 2		# (t4 = k * x + j) * 4 (memory offset)
		lw $t4, second_matrix_array($t4) # t4 = B[k][j]
		# === calculate B[k][j] end   ===
		
		  # $t3 = A[i][k]
		  # $t4 = B[k][j]
		# multiply A[i][k] * B[k][j]
		mult $t3, $t4		# A[i][k] * B[k][j]
		mflo $t5
		add $s1, $s1, $t5	# res = res + A[i][k] * B[k][j]

		addi $t2, $t2, 1	# k++
		j q2_mult_main_loop
		q2_mult_main_loop_end:
		## print result
		li $v0, 1	# print_int
		add $a0, $s1, $zero	# $t7 to be printed
		syscall
		## print space
		li $a0, 32	# 32 is the ascii code for space
		li $v0, 11  # syscall number for printing character
		syscall
	addi $t1, $t1, 1	#j++
	j q2_mult_inner_loop
	q2_mult_inner_loop_end:
	## print newline hcar
	li $a0, 10	# 10 is the ascii code for LF
	li $v0, 11  # syscall number for printing character
	syscall
addi $t0, $t0, 1	# i++
j q2_mult_outher_loop
q2_mult_outher_loop_end:

# end of Procedure_2
# restore $a0-$a3 registers from stack
lw $a3, 0($sp)		# restore $a3
lw $a2, 4($sp)		# restore $a2
lw $a1, 8($sp)		# restore $a1
lw $a0, 12($sp)		# restore $a0
addi $sp, $sp, 16	# deallocate 4 words
jr $ra			# jump back to the menu


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




EXIT:
li $v0, 10 # terminate program
syscall
