.section .text
.global main

main:
    li t0, 0x04030201
    li t1, 0x04030201

    # loop counter
    li t3, 1000

    # accumulator
    li t4, 0

    # base address
    li t2, 0x20000000

    # start cycle count
    csrr t5, mcycle

loop:
    li   t6, 0xFF

    # byte 0
    and  a0, t0, t6
    and  a1, t1, t6
    mul  a0, a0, a1

    # byte 1
    srli a2, t0, 8
    and  a2, a2, t6
    srli a3, t1, 8
    and  a3, a3, t6
    mul  a2, a2, a3

    # byte 2
    srli a4, t0, 16
    and  a4, a4, t6
    srli a5, t1, 16
    and  a5, a5, t6
    mul  a4, a4, a5

    # byte 3
    srli a6, t0, 24
    srli a7, t1, 24
    mul  a6, a6, a7

    # sum
    add  a0, a0, a2
    add  a0, a0, a4
    add  a0, a0, a6

    # accumulate
    add  t4, t4, a0

    # loop control
    addi t3, t3, -1
    bnez t3, loop

    # end cycle count
    csrr t6, mcycle
    sub t6, t6, t5

    # store results
    sw t4, 0(t2)     # result = 30000
    sw t6, 4(t2)     # cycles

end:
    j end