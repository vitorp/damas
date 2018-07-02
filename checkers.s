
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
# bit[2] = pe�a existente
# bit[1] = Time ( Branco = 0 e Preto = 1 )
# bit[0] = Dama
# Pe�a Branca = 0x04
# Pe�a Preta = 0x06
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

piece_x: .asciz "Digite a coordenada X da pe�a:\n"
piece_y: .asciz "Digite a coordenada Y da pe�a:\n"
invalid_x_y:  .asciz "Coordenadas invalidas. Reselecione a peca.\n"
invalid_option: .asciz "Opcao invalida.\n"
unmovable_piece: .asciz "Peca sem movimentos validos, selecione outra peca.\n"
invalid_piece: .asciz "Peca selecionada invalida, selecione outra peca.\n"

mv_up_text: .asciz " - Mover para cima\n"
mv_up_right_text: .asciz " - Mover para cima esquerda\n"
mv_up_left_text: .asciz " - Mover para cima direita\n"
mv_down_text: .asciz " - Mover para Baixo\n"
mv_down_right_text: .asciz " - Mover para baixo esquerda\n"
mv_down_left_text: .asciz " - Mover para baixo direita\n"
reselect_piece_text: .asciz " - Escolher outra peca\n"
error_text: .asciz " - Error\n"

# For testing
white_space: .asciz " - "
brk: .asciz "\n"
.align 2
play_options: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
.text 	
	turn_draw:
	mv s0, zero
	mv s1, zero
	li s2, 8
	j draw_loop
	finish_row:
	addi s1, s1, 1
	print_string(brk)
	draw_loop:
	beq s1,s2, turn_loop
	mv s0, zero
	andi t0, s1, 0x01
	beq t0, zero, even_row_draw_loop
	
	odd_row_draw_loop:
	li t0, 4 
	beq s0, t0, finish_row
	print_string(white_space)
	load_piece(s0,s1)
	print_int(a0)
	addi s0, s0, 1
	j odd_row_draw_loop
	
	even_row_draw_loop:
	li t0, 4 
	beq s0, t0, finish_row
	load_piece(s0,s1)
	print_int(a0)
	print_string(white_space)
	addi s0, s0, 1
	j even_row_draw_loop
	
	turn_loop:
	jal select_piece
	mv s0, a0
	mv s1, a1
	
	# Checks if piece is from the white team
	load_piece(s0,s1)
	li t0, WHITE
	beq a0, t0, valid_piece
	print_string(invalid_piece)
	j turn_loop
	
	valid_piece:
	mv a0, s0
	mv a1, s1
	jal load_play_options
	
	# Check if piece has valid movements
	li t0, 1
	bgt a0, t0, movable_piece
	print_string(unmovable_piece)
	j turn_loop
	
	movable_piece:
	mv a1, s1
	jal choose_option
	mv a1, s0
	mv a2, s1
	jal execute_option
	j turn_draw

.include "mv_piece.s"
.include "eat_piece.s"
.include "select_play.s"
exit:
