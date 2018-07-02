
.data 
STR_pergunta_menu: .string "Digite um numero entre 1 e 3 de acordo com a dificuldade que deseja:"
.text
PERGUNTA_NIVEL:

	# String para perguntar a dificuldade
	la a0, STR_pergunta_menu
	li a7, 4
	ecall
	
	# Leitura do numero(nível) digitado
	li a7, 5
	ecall
	
	# Voltar para o menu
	jr ra						
	
	
	
