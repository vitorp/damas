
.include "macros.s"
.eqv DOWN	1
.eqv UP		-1
.eqv RIGHT	-1
.eqv LEFT	1
.eqv WHITE	0x04
.eqv WHITE_KING 0x05
.eqv BLACK	0x06
.eqv BLACK_KING 0x07
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
base:   .word 0x00000000
linha1: .word 0x00000700
linha2: .word 0x00000000
linha3: .word 0x00050000
linha4: .word 0x00000000
linha5: .word 0x00000000
linha6: .word 0x04000000
linha7: .word 0x04000000

piece_x: .asciz "Digite a coordenada X:\n"
piece_y: .asciz "Digite a coordenada Y:\n"
invalid_x_y:  .asciz "Coordenadas invalidas."
invalid_option: .asciz "Opcao invalida.\n"
unmovable_piece: .asciz "Peca sem movimentos validos!"
invalid_piece: .asciz "Peca selecionada invalida!"

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
stop_king_text: .asciz " - Parar\n"
error_text: .asciz " - Error\n"

victory_text: .asciz " Parabens voce ganhou!\n"
defeat_text: .asciz " Voce perdeu!\n"
clear_line: .asciz "                                    "
# For testing
white_space: .asciz "-"
brk: .asciz "\n"
.align 2
line_control: .word 0
play_options: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
enemy_options: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
			12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
.text
	jal load_exception_handling # s11 = ecall address
	jal setup_step	# Printar a tela de menu
	jal print_step

	j turn_loop # So that player starts playing
	turn_reset:
	li t0, 9
	la t1, line_control
	sw t0, 0(t1)
	j turn_draw
	turn_start:
	li t0, 9
	la t1, line_control
	sw t0, 0(t1)

	jal upgrade_white_kings_step
	jal find_black_piece_step
	beq a0, zero, victory

	jal enemy_turn
	jal upgrade_black_kings_step
	li t4, 3000
	sleep(t4)
	jal find_white_piece_step
	beq a0, zero, defeat
	turn_draw:
	jal print_step


	turn_loop:
	jal select_piece_step
	mv s0, a0
	mv s1, a1
	load_piece(s0,s1)
	mv s2, a0 # s2 = piece

	# Checks if piece is from the white team
	load_piece(s0,s1)
	li t0, WHITE
	beq a0, t0, valid_piece
	li t0, WHITE_KING
	beq a0, t0, valid_piece
	print_string(invalid_piece)
	li t4, 3000
	sleep(t4)
	print_string(clear_line)
	j turn_loop

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
	li t4, 3000
	sleep(t4)
	print_string(clear_line)
	j turn_loop

	movable_piece:
	mv a1, s1
	jal choose_option # a0 = Selected option label
	mv a1, s0
	mv a2, s1
	li t0, WHITE_KING
	li t1, BLACK_KING
	beq s2, t0, king_move
	beq s2, t1, king_move
	jal execute_option
	j turn_start
	king_move:
	jal king_loop_step
	j turn_start

	defeat:
	print_string(defeat_text)
	j exit
	victory:
	print_string(victory_text)
	exit:
	j exit

.include "mv_piece.s"

.include "eat_piece.s"
.include "enemy.s"
setup_step:
	j setup_step_2

print_step:
	j print_step_2
select_piece_step:
	j select_piece

king_loop_step:
	j king_loop

find_black_piece_step:
	j find_black_piece

find_white_piece_step:
	j find_white_piece

upgrade_white_kings_step:
	j upgrade_black_kings
upgrade_black_kings_step:
	j upgrade_white_kings
load_exception_handling:
	j load_exception_handling_2
turn_start_step:
	j turn_start
turn_reset_step:
	j turn_reset

.include "select_play.s"

setup_step_2:
	j setup

load_exception_handling_2:
	j load_exception_handling_3

print_step_2:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal PRINT_TABULEIRO
	jal print_board
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

.include "checks.s"
.include "king.s"
.include "print_board.s"

setup:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal PRINT_MENU	# Printar a tela de menu
	jal MAIN_music	# coloca para tocar musica
	#jal PERGUNTA_NIVEL
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

load_exception_handling_3:
	la s11, exceptionHandling
	ret
# Interface
.include "music.s"
.include "print_menu.s"
.include "pergunta_nivel.s"
.include "print_tabuleiro.s"

.include "SYSTEMv11.s"
