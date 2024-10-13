.data 0x10010000
    arr: .space 400
    length: .word 100
    delimeter: .asciiz "\n"
.text
main:
    # process
    li      $a0, 0x10010000
    lw      $a1, length
    jal		ASSIGNARR			# ASSIGN ARRAY
    jal     PRINTARR            # THEN PRINT ARRAY
    
    # terminate program
    li      $v0, 10
    syscall
    
ASSIGNARR:
    # store return address
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

    # process input
    move    $t1, $a1          
    addi    $t1, -1
    move    $t2, $t1
    mul     $t2, $t2, 4
    add    $t0, $a0, $t2   # start add the end of array

    
    LOOP:
        beq     $t1, 0, EXITLOOP
        sw      $t1, 0($t0)
        addi    $t1, $t1, -1
        addi    $t0, $t0, -4
        b       LOOP
    EXITLOOP:
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr		$ra					# jump back to main
        
PRINTARR:
    # store return address
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

    # process input
    move    $t0, $a0                # set start address
    move    $t1, $a1                # get array length
    li      $t2, 0
    
    LOOPPRINT:
        beq     $t1, $t2, EXITLOOPPRINT
        # get int
        lw      $t5, 0($t0)
        # print int
        li      $v0, 1                # print integer mode = 1   
        move    $a0, $t5
        syscall
        #print delimeter
        li      $v0, 4                # print string mode = 4   
        la      $a0, delimeter
        syscall
        #increase counter
        addi    $t2, 1
        addi    $t0, 4
        b       LOOPPRINT
    EXITLOOPPRINT:
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr		$ra	                   # jump back to main
