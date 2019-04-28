	# Declare main as a global function
	.globl main 
	# All program code is placed after the
	# .text assembler directive
	.text 		
# The label 'main' represents the starting point
main:



# STEP 1: Get an integer for array size from the console
# STEP 2: Check to make sure the integer N meets the requirements 2 < N < 50. If not, end the program.
# STEP 3: Read from the console and store all N array elements from 0 to N-1 into provided memory at val0.
# STEP 4: Use bubblesort to sort the array
# STEP 5: Step through the sorted array and print all the (sorted) elements with commas between the values.
# STEP 6: Call the exit syscall funcion to end the program.

# All the strings needed are provided in the .data section.
		li $t1, 0			# Index
		li $v0, 4 			# System call code 4: print_string
		la $a0, msg1 		# Load string msg1 into a0
		syscall
		li $v0, 5			# System call code 5: read integer
		syscall
		move $s0, $v0		# Get number read from previous syscall and store in $s0
		slti $t0, $s0, 2	# Compare to left bounds
		bne $t0, $zero, OOB	# Branch to termination if out of bounds
		slti $t0, $s0, 50	# Compare to right bounds
		beq $t0, $zero, OOB	# Branch to termination if out of bounds
Start:	la $t2, val0		# Load address of val0 into $t2
		add $t3, $t1, $zero # Store index in $t3
		add $t3, $t3, $t3	# Double the index
		add $t3, $t3, $t3	# Double the index again(x4)
		add $t4, $t3, $t2	# Combine components of the address
		li $v0, 4			# System call code 4: print string
		la $a0, msg3		# Load string msg3 into $a0
		syscall
		li $v0, 1			# System call code 1: print integer
		add $a0, $zero, $t1	# Load index into $a0
		syscall
		li $v0, 4			# System call code 4: print string
		la $a0, msg4		# Load msg4 into $a0
		syscall
		li $v0, 5			# System call code 5: read integer
		syscall
		sw $v0, 0($t4)		# Store the input in the array at index $t4
		addi $t1, $t1, 1	# Increase the index by one
		bne $t1, $s0, Start	# Go back to beginning of loop if index has not reached max
		li $v0, 4			# System call code 4: print string
		la $a0, msg5 		# Load msg5 into $a0
		syscall
		li $s3, 0			# While boolean
		addi $s4, $s0, 0	# k
While:	beq $s3, $zero, Sort# while not done
		j Print				# Jump to print function when done with while loop
Sort:	li $s3, 1			# Done = true
		sub $t6, $s4, 1		# k -1
		li $t1, 0			# i = 0
For:	beq $t6, $t1, Sub	# When done with the for loop, branch to subtraction
		add $t3, $t1, $zero # Store index in $t3
		add $t3, $t3, $t3	# Double the index
		add $t3, $t3, $t3	# Double the index again(x4)
		add $t4, $t3, $t2	# Combine components of the address
		addi $t9, $t1, 1	# Load the next item in the array
		add $t9, $t9, $t9	# Double the index
		add $t9, $t9, $t9	# Double the index again(x4)
		add $t5, $t9, $t2	# Combine components of the address
		lw $s1, 0($t4)		# Get value of first number
		lw $s2, 0($t5)		# Get value of next number
		slt $t0, $s1, $s2	# Compare the values
		addi, $t1, $t1, 1	# i++
		bne $t0, $zero, For # Branch back to the beginning if no need to swap
		sw $s1, 0($t5)		# Store value one in value two's location
		sw $s2, 0($t4)		# Store value two in value one's location
		li $s3, 0			# Done = false
		j For				# Jump to beginning of for loop
Sub:	sub $s4, $s4, 1		# k--
		j While				# Jump to beginning of while loop
Print:	li $t1, 0			# Index counter
		li $v0, 4			# System call code 4: print string
		la $a0, msg6		# Load msg6 into $a0
		syscall
Print2:	beq $t1, $s0, Exit	# Branch to Exit when finished printing
		add $t3, $t1, $zero # Store index in $t3
		add $t3, $t3, $t3	# Double the index
		add $t3, $t3, $t3	# Double the index again(x4)
		add $t4, $t3, $t2	# Combine components of the address
		lw $a0, 0($t4)		# Load stored number
		li $v0, 1			# System call code 1: print integer
		syscall
		addi $t5, $t1, 1	# Check to see if last item
		beq $t5, $s0, Exit	# Don't print a comma, branch to termination
		li $v0, 4			# System call code 4: print string
		la $a0, msg7		# Load msg7 into $a0
		syscall
		addi $t1, $t1, 1	# Index + 1
		j Print2
Exit:	li $v0, 10			# Terminate program
		syscall
OOB:	li $v0, 4			# System call code 4: print string
		la $a0, msg2		# Load string msg2 into $a0
		syscall
		j Exit				# Jump to termination



        .data
msg1: 	.asciiz "Choose an array size between 2 and 50: "
msg2:	.asciiz "\nArray out of bounds! Ending Program"
msg3:	.asciiz "Enter value for element "
msg4:	.asciiz " : "
msg5:	.asciiz "Array initialized! Beginning sorting...\n"
msg6:	.asciiz "Finished! Sorted Array:\n"
msg7:	.asciiz ", "
val0: 	.word 1:50  #initializes 50 data words starting at val0 to 1