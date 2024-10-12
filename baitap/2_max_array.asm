.data 0x10010000
array: .word 3, 5, 7, 2, 8, 1, 9, 4  # Define the array with 8 elements

.text
.globl main
main:
la $t0, array          # Load the base address of the array into $t0
lw $t1, 0($t0)         # Load the first element into $t1
addi $t2, $zero, 1     # Initialize the index to 1

loop:
addi $t0, $t0, 4       # Increment the address to point to the next element
lw $t3, 0($t0)         # Load the next element into $t3
slt $t4, $t1, $t3      # Check if the current maximum is less than the new element
bne $t4, $zero, update_max # If the new element is greater, update the maximum
addi $t2, $t2, 1       # Increment the index
bne $t2, 8, loop       # Continue the loop if the index is less than 8

# Print the largest number
move $a0, $t1          # Move the largest number to $a0
li $v0, 1              # Load the print_int system call code into $v0
syscall                # Make the system call

li $v0, 10             # Exit the program
syscall

update_max:
move $t1, $t3          # Update the maximum to the new element
j loop