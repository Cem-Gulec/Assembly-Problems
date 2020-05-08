# Square root approximation
.data ## Data declaration section
## String to be printed:
welcome: .asciiz "Welcome to our MIPS project!\n"
menu: .asciiz "\nMain Menu:\n1. Square Root Approximate\n2. Matrix Multiplication\n3. Palindrome\n4. Exit\nPlease select an option: "
out_string: .asciiz "\nEnter the number of iteration for the series:"
a: .asciiz "a: "
b: .asciiz "b: "

.text ## Assembly language instructions go in text segment

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
beq $v0, $t9, Q1	# go to 1. question
li $t9, 2
beq $v0, $t9, Q2	# go to 2. question
li $t9, 3
beq $v0, $t9, Q3	# go to 3. question
li $t9, 4
beq $v0, $t9, EXIT	# exit if 4 is selected
beq $zero, $zero, MENU

Q1:
main: ## iiz Start of code section
li $v0, 4 # system call code for printing string = 4
la $a0, out_string # load address of string to be printed into $a0
syscall # call operating system to perform operation

li $v0, 5 # read_int
syscall
move $t0, $v0 # n stored in $t0
move $t7, $v0 # $t7 also stores copy of n

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
j MENU

Q2:
j MENU

Q3:
j MENU

EXIT:
li $v0, 10 # terminate program
syscall
