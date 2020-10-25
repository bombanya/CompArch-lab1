.data
N:
.word 4
M:
.word 3
matrix:
.word 1,87,2,2
.word -4,0,12,42
.word 12,23,-45,6

.text

main:
lw t0, N
lw t1, M
la t2, matrix
addi sp, sp, -12
sw t0, 0(sp)
sw t1, 4(sp)
sw t2, 8(sp)
call store_matrix
call max_from_matrix
call print_result
addi a0, x0, 10
ecall

store_matrix: #push matrix on stack
lw t0, 0(sp) #N
lw t1, 4(sp) #M
lw t2, 8(sp) #matrix
addi sp, sp, 12

addi t3, x0, 0 #row counter

sm_newrow:
addi t4, x0, 0 #column counter
sm_cycle:
lw t5, 0(t2)
addi t2, t2, 4
addi sp, sp, -4
sw t5, 0(sp)
addi t4, t4, 1
blt t4, t0, sm_cycle
addi t3, t3, 1
blt t3, t1, sm_newrow
addi sp, sp, -8
sw t0, 0(sp) #N
sw t1, 4(sp) #M
ret

max_from_matrix: #pop matrix from stack and push indexes of max element
lw t0, 0(sp) #N
lw t1, 4(sp) #M
addi sp, sp, 8

lw t2, 0(sp) #max
addi a0, x0, 0
addi a1, x0, 0

addi t3, x0, 0 #row counter

max_newrow:
addi t4, x0, 0 #column counter
max_cycle:
lw t5, 0(sp)
addi sp, sp, 4
bge t2, t5, continue

update_max:
add t2, t5, x0
add a0, t3, x0
add a1, t4, x0

continue:
addi t4, t4, 1
blt t4, t0, max_cycle
addi t3, t3, 1
blt t3, t1, max_newrow
sub a0, t1, a0 #because we read matrix in reversed order
sub a1, t0, a1
addi a0, a0, -1
addi a1, a1, -1
addi sp, sp, -8
sw a0, 0(sp)
sw a1, 4(sp)
ret

print_result:
addi a0, x0, 11 #print (
addi a1, x0, 40
ecall
addi a0, x0, 1 #print row index
lw a1, 0(sp)
ecall
addi a0, x0, 11 #print ,
addi a1, x0, 44
ecall
addi a0, x0, 1 #print column index
lw a1, 4(sp)
ecall
addi sp, sp, 8
addi a0, x0, 11 #print )
addi a1, x0, 41
ecall
ret