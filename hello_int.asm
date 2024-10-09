    # Hello, Int! - print the 3rd item of 3 => 6
.data                                   ## Data declaration section
    ## Input array 
    arr: .word 5, 2, 6, 1
.text                                   ## Assembly language instructions go in text segment
main:
    # process                                   
    la      $t1,   arr
    lw      $t2,    8($t1)

    # ouput
    li      $v0,    1                   # system call code for printing integer = 1
    move    $a0,    $t2         
    syscall                             # call operating system to perform operation
    # specified in $v0
    # syscall takes its arguments from $a0, $a1, ...

    # terminate program
    li      $v0,    10                  
    syscall