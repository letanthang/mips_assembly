    .data
    array: .word 10, 20, 35, 25, 50, 15, 5, 65, 75, 45, 30, 55, 85, 95, 60, 40  # Array containing 16 elements
    msg:   .asciiz "The largest value is: "  # Message to print before the result

    .text
    .globl main
main:
    la   $t0, array       # Load the address of the array into $t0
    lw   $t1, 0($t0)      # Load the first element into $t1 (initial max value)
    li   $t2, 1           # Counter to iterate through the array elements (start from the second element)

loop:
    beq  $t2, 16, done    # If 16 elements have been compared, end the loop
    sll  $t3, $t2, 2      # Multiply the index by 4 (since each element is 4 bytes)
    add  $t4, $t0, $t3    # Calculate the address of the next element
    lw   $t5, 0($t4)      # Load the next element into $t5

    blt  $t1, $t5, update # If the current max value is less than the new value, update the max value

    addi $t2, $t2, 1      # Increment the counter by 1
    j    loop             # Repeat the loop for the next element

update:
    move $t1, $t5         # Update the max value
    j    loop             # Go back to the loop

done:
    move $v1, $t1         # Store the largest value into $v1

    # Print the result message
    la   $a0, msg         # Load the address of the message into $a0
    li   $v0, 4           # Syscall for printing a string
    syscall               # Make the syscall

    # Print the largest value (stored in $v1)
    move $a0, $v1         # Move the largest value into $a0
    li   $v0, 1           # Syscall for printing an integer
    syscall               # Make the syscall

    # Exit the program
    li   $v0, 10          # Syscall for program exit
    syscall               # Make the syscall
