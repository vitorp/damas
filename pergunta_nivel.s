.data 
STR_pergunta_menu: .string "Digite o numero: "
.text
PERGUNTA_NIVEL:
	addi sp, sp, -4
	sw ra, 0(sp)
	# Leitura do numero(nível) digitado
	li a7, 105
	jal exceptionHandling
	# Voltar para o menu
	lw ra, 0(sp)
	addi sp, sp , 4
	
	jr ra						
	
	
	
