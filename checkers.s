
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
linha2: .word 0x00060006
linha3: .word 0x00000600
linha4: .word 0x00040600
linha5: .word 0x04040404
linha6: .word 0x04040404
linha7: .word 0x04040404

piece_x: .asciz "Digite a coordenada X da peça:\n"
piece_y: .asciz "Digite a coordenada Y da peça:\n"
invalid_x_y:  .asciz "Coordenadas invalidas. Reselecione a peca.\n"
invalid_option: .asciz "Opcao invalida.\n"
unmovable_piece: .asciz "Peca sem movimentos validos, selecione outra peca.\n"
invalid_piece: .asciz "Peca selecionada invalida, selecione outra peca.\n"

mv_up_right_text: .asciz " - Mover para cima direita\n"
mv_up_left_text: .asciz " - Mover para cima esquerda\n"
mv_down_text: .asciz " - Mover para Baixo\n"
mv_down_right_text: .asciz " - Mover para baixo direita\n"
mv_down_left_text: .asciz " - Mover para baixo esquerda\n"

eat_up_text: .asciz " - Comer para cima\n"
eat_down_text: .asciz " - Comer para baixo\n"
eat_adj_up_text: .asciz " - Comer adjacente cima\n"
eat_adj_down_text: .asciz " - Comer adjacente baixo\n"

reselect_piece_text: .asciz " - Escolher outra peca\n"
error_text: .asciz " - Error\n"

# For testing
white_space: .asciz "-"
brk: .asciz "\n"
.align 2
play_options: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
.text 		
	jal setup	# Printar a tela de menu
	turn_draw:
	jal print_step

	turn_loop:
	jal select_piece
	mv s0, a0
	mv s1, a1
	
	# Checks if piece is from the white team
	#load_piece(s0,s1)
	#li t0, WHITE
	# beq a0, t0, valid_piece
	# print_string(invalid_piece)
	# j turn_loop
	
	valid_piece:
	mv a0, s0
	mv a1, s1
	jal load_mv_options
	mv a2, a0
	mv a0, s0
	mv a1, s1
	jal load_eat_options # a0 =  Option Count
	jal load_reselect_piece
	
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
	
	exit:
	li a7, 10
	ecall

.include "mv_piece.s"
.include "eat_piece.s"

setup:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal PRINT_MENU	# Printar a tela de menu
	jal MAIN_music	# coloca para tocar musica
	#jal PERGUNTA_NIVEL
	jal PRINT_TABULEIRO
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

print_step:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal print_board
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

.include "select_play.s"
.include "print_board.s"

# Interface
.include "music.s"
.include "print_menu.s"
.include "pergunta_nivel.s"
.include "print_tabuleiro.s"

.include "SYSTEMv11.s"
