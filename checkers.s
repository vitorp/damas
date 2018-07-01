
.include "macros.s"
.eqv DOWN	1
.eqv UP		-1
.eqv RIGHT	-1
.eqv LEFT	1 
.eqv WHITE	0x04
.eqv BLACK	0x06
.eqv EMPTY	0x00 

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

.data
base:   .word 0x06060606
linha1: .word 0x06060606
linha2: .word 0x06060606
linha3: .word 0x00000000
linha4: .word 0x00000000
linha5: .word 0x04040404
linha6: .word 0x04040404
linha7: .word 0x04040404

piece_x: .asciz "Digite a coordenada X da peça:\n"
piece_y: .asciz "Digite a coordenada Y da peça:\n"
invalid_x_y:  .asciz "Coordenadas invalidas. Reselecione a peca.\n"
invalid_option: .asciz "Opcao invalida.\n"
invalid_piece: .asciz "Peca sem movimentos validos, selecione outra peca.\n"
mv_up_text: .asciz " - Mover para cima\n"
mv_up_right_text: .asciz " - Mover para cima direita\n"
mv_up_left_text: .asciz " - Mover para cima esquerda\n"
mv_down_text: .asciz " - Mover para Baixo\n"
mv_down_right_text: .asciz " - Mover para baixo direito\n"
mv_down_left_text: .asciz " - Mover para baixo esquerda\n"
reselect_piece_text: .asciz " - Escolher outra peca\n"
error_text: .asciz " - Error\n"
.align 2
play_options: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
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
	li a0, 2
	li a1, 4
	jal can_mv_up_right
	li a0, 0
	li a1, 3
	jal can_mv_up_left
	li a0, 1
	li a1, 7
	jal can_mv_down_right
	li a0, 2
	li a1, 3
	jal can_mv_down_left
	
	li a0, 2
	li a1, 4
	eat(UP)
	li a0, 1
	li a1, 3
	eat(UP)
	li a0, 3
	li a1, 1
	eat(DOWN)
	li a0, 1
	li a1, 0
	eat(DOWN)
	
	li a0, 1
	li a1, 7
	eat_adj(UP)
	li a0, 3
	li a1, 6
	eat_adj(UP)
	
	li a0, 3
	li a1, 0
	eat_adj(DOWN)
	li a0, 0
	li a1, 1
	eat_adj(DOWN)
	li a0, 2
	li a1, 4
	can_eat(UP)
	li s0, 0
	li s1, 1
	li s2, WHITE
	store_piece(s0,s1,s2)
	li a0, 0
	li a1, 0
	can_eat(DOWN)
	li a0, 2
	li a1, 4
	can_eat_adj(UP)
	
	turn_loop:
	jal select_piece
	mv s0, a0
	mv s1, a1
	mv a0, s0
	mv a1, s1
	jal load_play_options
	
	li t0, 1
	bgt a0, t0, movable_piece
	print_string(invalid_piece)
	j turn_loop
	
	movable_piece:
	jal choose_option
	mv a1, s0
	mv a2, s1
	jal execute_option
	j turn_loop

.include "mv_piece.s"
.include "eat_piece.s"
.include "select_play.s"
exit:
