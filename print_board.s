.text
print_board:
	addi sp, sp, -20
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw ra, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)
	
	mv s0, zero # s0 = X Axis
	mv s1, zero # s1 = Y axis

	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	H1(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	H2(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	H3(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	H4(s3)
	jal PECAS
	
	mv s0, zero
	addi s1, s1, 1

	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	G1(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	G2(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	G3(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	G4(s3)
	jal PECAS
	
	mv s0, zero
	addi s1, s1, 1

	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	F1(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	F2(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	F3(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	F4(s3)
	jal PECAS
	
	mv s0, zero
	addi s1, s1, 1

	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	E1(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	E2(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	E3(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	E4(s3)
	jal PECAS
	
	mv s0, zero
	addi s1, s1, 1

	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	D1(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	D2(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	D3(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	D4(s3)
	jal PECAS
	
	mv s0, zero
	addi s1, s1, 1

	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	C1(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	C2(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	C3(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	C4(s3)
	jal PECAS
	
	mv s0, zero
	addi s1, s1, 1

	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	B1(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	B2(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	B3(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	B4(s3)
	jal PECAS
	
	mv s0, zero
	addi s1, s1, 1

	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	A1(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	A2(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	A3(s3)
	jal PECAS
	
	addi s0, s0, 1
	load_piece(s0,s1)
	mv s3, a0 # s3 = piece
	A4(s3)
	jal PECAS
	
	end_print_board:
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw ra, 8(sp)
	lw s2, 12(sp)
	lw s3, 16(sp)
	addi sp, sp, 20
	ret
