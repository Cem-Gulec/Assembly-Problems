# Square root approximation
.data ## Data declaration section
## String to be printed:
out_string: .asciiz "\nEnter the number of iteration for the series:"
a: .asciiz "a: "
b: .asciiz "b: "

.text ## Assembly language instructions go in text segment
main: ## iiz Start of code section
li $v0, 4 # system call code for printing string = 4
la $a0, out_string # load address of string to be printed into $a0
syscall # call operating system to perform operation

li $v0, 5 # read_int
syscall

move $a0, $v0
jal Procedure_1
j EXIT

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
la $a0, a
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
la $a0, b
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

# EXIT
EXIT:
li $v0, 10 # terminate program
syscall
