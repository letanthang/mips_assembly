.data 0x10010000
    arr1: .word 12, 6, 23, 16
    N: .word 4
    delimeter: .asciiz "\n"
.text
main:
    # process
    li      $v0, 0x10010000
    li      $v1, 0x10010100
    jal		COPYARR				# COPY ARR
    move    $v0, $s0
    jal     PRINTARR            # THEN PRINT ARR
    
    # terminate program
    li      $v0, 10
    syscall
    
COPYARR:
    # store return address
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)
    move    $s0, $v1

    move    $t0, $v0
    move    $t1, $v1
    lw      $t3, N
    li      $t4, 0
    
    LOOP:
        beq     $t3, $t4, EXITLOOP
        lw      $t5, 0($t0)
        sw      $t5, 0($t1)
        addi    $t0, $t0, 4
        addi    $t1, $t1, 4
        addi    $t4, $t4, 1
        b       LOOP
    EXITLOOP:
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr		$ra					# jump back to main
        
PRINTARR:
    # store return address
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

    # init temp var
    move    $t0, $v0
    lw      $t1, N
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
