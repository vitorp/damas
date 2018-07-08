.text
print_board:
	addi sp, sp, -16
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw ra, 8(sp)
	sw s2, 12(sp)
	
	mv s0, zero # s0 = X Axis
	mv s1, zero # s1 = Y axis
	li s3, BLACK
	
	print_int(s0)
	print_int(s1)
	
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#A1()
	jalr s2, 0
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#A2()
	jalr s2, 0
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#A3()
	jalr s2, 0
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#A4()
	jalr s2, 0
	
	print_int(s0)
	print_int(s1)
	addi s1, s1, 1 # y += 1
	mv s0, zero

	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#B1()
	jalr s2, 0
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#B2()
	jalr s2, 0
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#B3()
	jalr s2, 0
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#B4()
	jalr s2, 0
	
	print_int(s0)
	print_int(s1)
	
	addi s1, s1, 1 # y += 1
	mv s0, zero
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#C1()
	jalr s2, 0
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#C2()
	jalr s2, 0
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#C3()
	jalr s2, 0
	
	addi s0, s0, 1
	load_piece(s0,s1)
	jal piece_print_addr
	mv s2, a0 # s2 = print_addr
	#C4()
	jalr s2, 0
	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw ra, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 16
	ret

# Params: a0 (Piece)
piece_print_addr:
	addi sp, sp, -4
	sw s0, 0(sp)
	
	mv s0, a0
	
	li t0, WHITE
	bne s0, t0, not_white
	la a0, print_white_piece
	j end_piece_print_addr
	not_white:
	li t0, EMPTY
	beq s0, t0, empty_space
	la a0, print_black_piece
	j end_piece_print_addr
	empty_space:
	la a0, print_nothing
	
	end_piece_print_addr:
	
	lw s0, 0(sp)
	addi sp, sp, 4
	ret

print_white_piece:
	li a0, 4
	print_int(a0)
	ret
	
print_black_piece:
	li a0, 6
	print_int(a0)
	ret
	
print_nothing:
	ret
