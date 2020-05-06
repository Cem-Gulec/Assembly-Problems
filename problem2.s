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

# $a0: addr = address of first matrix string
# $a1: addr = address of second matrix string
# $a2: int    = first dimension
# $a3: int    = second dimension
Procedure_q2:

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

##### TESTS #####
la $s0, first_matrix_array
lw $s1, 0($s0)
addi $s0, $s0,4
lw $s2, 0($s0)
mult $s1, $s2
mfhi $t0
mflo $t1

li $v0, 10 # terminate program
syscall
