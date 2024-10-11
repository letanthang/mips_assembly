    .data
    source:    .word 1, 2, 3, 4, 5, 6, 7, 8   # Source array (8 words)
    target:    .space 32                      # Target array space (32 bytes = 8 words)

    .text
    .globl main
main:
    # Initialize the base addresses for the source and target arrays
    la   $t0, source          # Load address of source array into $t0
    la   $t1, target          # Load address of target array into $t1
    
    # Set the counter for the number of words (8 words)
    li   $t2, 8               # Counter set to 8

copy_loop:
    beq  $t2, $zero, done     # If the counter is 0, jump to done
    
    lw   $t3, 0($t0)          # Load word from source array into $t3
    sw   $t3, 0($t1)          # Store word into the target array
    
    addi $t0, $t0, 4          # Increment source pointer by 4 (next word)
    addi $t1, $t1, 4          # Increment target pointer by 4 (next word)
    
    addi $t2, $t2, -1         # Decrement counter by 1
    j    copy_loop            # Jump back to the start of the loop

done:
    li   $v0, 10              # Exit system call
    syscall
