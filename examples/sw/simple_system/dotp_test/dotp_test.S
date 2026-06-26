.section .text
.global main

main:
    # operands
    li t0, 0x04030201
    li t1, 0x04030201

    # loop counter
    li t3, 1000

    # accumulator
    li t4, 0

    # base address for output
    li t2, 0x20000000

    # start cycle count
    csrr t5, mcycle

loop:
    # DOTP t0, t0, t1
    .word 0x0A6282B3

    add t4, t4, t0
    addi t3, t3, -1
    bnez t3, loop

    # end cycle count
    csrr t6, mcycle
    sub t6, t6, t5   # total cycles

    # store results
    sw t4, 0(t2)     # result = 30000
    sw t6, 4(t2)     # cycle count

end:
    j end