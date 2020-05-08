# Square root approximation
.data ## Data declaration section
first_matrix: .space 1024
second_matrix: .space 1024
first_matrix_array: .space 1024
second_matrix_array: .space 1024
## String to be printed:
enter_f_matrix: .asciiz "\nEnter the first matrix: "
enter_s_matrix: .asciiz "\nEnter the second matrix: "
enter_fd_matrix: .asciiz "\nEnter the first dimension of first matrix: "
enter_sd_matrix: .asciiz "\nEnter the second dimension of first matrix: "
multiplication_matrix: .asciiz "\nMultiplication matrix:\n"

.text ## Assembly language instructions go in text segment
main: ## iiz Start of code section
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


la $a0, first_matrix
la $a1, second_matrix
jal Procedure_q2	# go to procedure with arguments in $a0-$a3
j EXIT
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
jr $ra			# jump back to the menu


addi $sp, $sp, 16	# deallocate 4 words

# EXIT
EXIT:
li $v0, 10 # terminate program
syscall
