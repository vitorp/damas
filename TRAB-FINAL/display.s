.include "aux_display.s"

.data
IMAGE_MENU: .string "MENU_image/MENU.bin"
IMAGE_TABULEIRO: .string "imagem_tabuleiro/tabuleiro.bin"

.text


DISPLAY:
# Abre o arquivo

	beq t0, zero, MENU
	j TAB
	
TAB:		
	la a0, IMAGE_TABULEIRO		# Endereço da string do nome do arquivo
	li a1,0			# Leitura
	li a2,0			# binário
	li a7,1024		# ecall de open file
	ecall			# retorna em $v0 o descritor do arquivo
			
	mv t0,a0		# salva o descritor em $t0
	
# Le o arquivos para a memoria VGA
	mv a0,t0		# $a0 recebe o descritor
	li a1,0xFF000000	# endereco de destino dos bytes lidos
	li a2,76800		# quantidade de bytes
	li a7,63		# syscall de read file
	ecall			# retorna em $v0 o numero de bytes lidos

#Fecha o arquivo
	mv a0,t0		# $a0 recebe o descritor
	li a7,57		# syscall de close file
	ecall			# retorna se foi tudo Ok

# Volta para o programa ler o nível desejado do menu
	j END_display


MENU:
	la a0, IMAGE_MENU		# Endereço da string do nome do arquivo
	li a1,0			# Leitura
	li a2,0			# binário
	li a7,1024		# syscall de open file
	ecall			# retorna em $v0 o descritor do arquivo
	mv t0,a0		# salva o descritor em $t0
	
# Le o arquivos para a memoria VGA
	mv a0,t0		# $a0 recebe o descritor
	li a1,0xFF000000	# endereco de destino dos bytes lidos
	li a2,76800		# quantidade de bytes
	li a7,63		# syscall de read file
	ecall			# retorna em $v0 o numero de bytes lidos

#Fecha o arquivo
	mv a0,t0		# $a0 recebe o descritor
	li a7,57		# syscall de close file
	ecall			# retorna se foi tudo Ok

# Volta para o programa ler o nível desejado do menu
	jr ra

END_display:	

