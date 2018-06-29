
.include "macros.s"
.eqv DOWN	1
.eqv UP		-1
.eqv RIGHT	-1
.eqv LEFT	1 

.data
# 0000: 
# bit[3] = inutilizado
# bit[2] = peça existente
# bit[1] = Time ( Branco = 0 e Preto = 1 )
# bit[0] = Dama
# Peça Branca = 0x04
# Peça Preta = 0x06
# Dama Branca = 0x05
# Dama Preta = 0x07
# Vazio = 0x00
base:   .word 0x06060606
linha1: .word 0x06060606
linha2: .word 0x06050106
linha3: .word 0x00000000
linha4: .word 0x00000000
linha5: .word 0x04040302
linha6: .word 0x04040404
linha7: .word 0x04040404
.text 
	li s2, 1
	li s3, 2
	mv_down(s2,s3)
	li s2, 0
	li s3, 5
	mv_up(s2,s3)
	li s2, 1
	li s3, 5
	mv_up_left(s2,s3)
	li s2, 2
	mv_up_right(s2,s3)
	li s2, 2
	li s3, 2
	mv_down_left(s2,s3)
	li s2,3
	mv_down_right(s2,s3)
	li a0, 1
	li a1, 7
	jal can_mv_down
	j exit

# params: a0(X axis), a1(Y axis)
# return: a0 = 1 if true, a0 = 0 if false
can_mv_up:
	addi sp, sp, -4
	sw s0, 0(sp)

	addi s0, a1, UP
	blt s0, zero, up_fail
	load_piece(a0,s0)
	li s0, 1
	blt a0, s0, up_succ
	up_fail:
	li a0, 0
	j end_can_mv_up
	up_succ:
	li a0, 1
	
	end_can_mv_up:
	lw s0, 0(sp)
	addi sp, sp, 4
	ret

# params: a0(X axis), a1(Y axis)
# return: a0 = 1 if true, a0 = 0 if false
can_mv_down:
	addi sp, sp, -8
	sw s0, 0(sp)
	sw s1, 4(sp)

	addi s0, a1, DOWN
	li s1, 7
	bgt s0, s1, down_fail
	load_piece(a0,s0)
	li s1, 1
	blt a0, s1, down_succ
	down_fail:
	li a0, 0
	j end_can_mv_down
	down_succ:
	li a0, 1

	end_can_mv_down:
	lw s0, 0(sp)
	lw s1, 4(sp)
	addi sp, sp, 8
	ret
exit: