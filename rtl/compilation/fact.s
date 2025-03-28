.text
.align 4
# .global fact
.global erg1Mul
.type   erg1Mul,    @function
.global erg2TestImmHazard
.type   erg2TestImmHazard, @function
.global erg3Test
.type   erg3Test, @function

# fact: addi t0, zero, 2 # immediate 2 needed for "if(n<2)"
# bge a0, t0, elseF # if n<2 false, i.e. if n≥2 goto ELSE
# addi a0, zero, 1 # THEN: create return-value 1, place in reg. a0
# jr ra # return --this is the end of the "then" clause

# elseF: addi sp, sp, -8 # PUSH1: allocate 8 Bytes on the stack
# sw ra, 4(sp) # PUSH2: save ra into first allocated word
# sw a0, 0(sp) # PUSH3: save my argument (n) into second word
# addi a0, a0, -1 # create argument (n-1) into a0 for my child
# jal ra, fact # call my child procedure
# add t0, a0, zero # copy return value from my child into t0
# lw ra, 4(sp) # POP1: restore ra from stack
# lw a0, 0(sp) # POP2: restore a0 from stack
# addi sp, sp, 8 # POP3: dealloc the 8 B that I had allocated
# mul a0, a0, t0 # multiply my own arg a0==n times the return
# jr ra

erg1Mul:
li      t0, 0xAAAAA
li      t1, 0xBBBBB
mul     a0, t1,     t0
mulh    a1, t1,     t0
addi    t0, zero,   80
addi    t1, zero,   84
sw      a0, 0(t0)
sw      a1, 0(t1)
jr      ra

erg2TestImmHazard:
li      t0, 0   #register x5
li      t1, 5   #register x6
li      t2, 6   #register x7
li      t3, 7   #register x28
li      t4, 28  #register x29
li      t5, 29  #register x30
jr      ra

erg3Test:
li      x11, 4
li      x12, 6
li      x17, 1
li      x18, 2
li      x21, 1
add     x10, x11, x12 # x10=10=A
sub     x15, x10, x17 # x15=10=A
mul     x16, x10, x18 # x16=20=14
srl     x17, x10, x21 # x17==5
li      t0, 56
sw      x17, 0(t0)
lw      t4, 0(t0) 
lw      t2, -8(t0)  
lw      t3, -12(t0)
lw      t1, -4(t0)  
add     t1, t4, t1
add     t1, t1, t2
add     t1, t1, t3
sw      t1, 4(t0)
jr      ra
