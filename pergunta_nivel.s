.data 
STR_pergunta_menu: .string "Digite o numero: "
.text
PERGUNTA_NIVEL:
	addi sp, sp, -4
	sw ra, 0(sp)
	# String para perguntar a dificuldade
	la a0, STR_pergunta_menu
	li a1, 0
	li a2, 0
	li a3, 0xff00
	li a7, 104	
	
	jal exceptionHandling
	
	# Leitura do numero(nível) digitado
	li a7, 105
	jal exceptionHandling
	# Voltar para o menu
	lw ra, 0(sp)
	addi sp, sp , 4
	
	jr ra						
	
	
	
