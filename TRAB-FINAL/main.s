.text

	jal PRINT_MENU	# Printar a tela de menu
	jal MAIN_music	# coloca para tocar musica
	jal PERGUNTA_NIVEL
	jal PRINT_TABULEIRO	# Printar o tabuleiro

	li a7, 10
	ecall

.include "music.s"
.include "print_tabuleiro.s"
.include "print_menu.s"
.include "pergunta_nivel.s"
