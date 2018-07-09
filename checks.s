
	upgrade_white_kings:
	addi sp, sp, -8
	sw s0, 0(sp)
	sw s1, 4(sp)
	
	mv s0, zero
	mv s1, zero
	
	upgrade_white_kings_loop:
	li t0, 4
	beq s0, t0, end_upgrade_white_kings
	load_piece(s0,s1)
	li t0, WHITE
	bne a0, t0, no_upgrade_white_king
	li t4, WHITE_KING
	store_piece(s0,s1,t4)
	no_upgrade_white_king:
	addi s0, s0, 1
	j upgrade_white_kings_loop

	end_upgrade_white_kings:
	lw s0, 0(sp)
	lw s1, 4(sp)
	addi sp, sp, 8
	ret
	
	upgrade_black_kings:
	addi sp, sp, -8
	sw s0, 0(sp)
	sw s1, 4(sp)
	
	mv s0, zero
	li s1, 7
	
	upgrade_black_kings_loop:
	li t0, 4
	beq s0, t0, end_upgrade_black_kings
	load_piece(s0,s1)
	li t0, BLACK
	bne a0, t0, no_upgrade_black_king
	li t4, BLACK_KING
	store_piece(s0,s1,t4)
	no_upgrade_black_king:
	addi s0, s0, 1
	j upgrade_black_kings_loop

	end_upgrade_black_kings:
	lw s0, 0(sp)
	lw s1, 4(sp)
	addi sp, sp, 8
	ret

find_black_piece:
	addi sp, sp, -12
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	
	mv s0, zero
	mv s1, zero
	mv s2, zero
	
	find_black_piece_loop:
	li t0, 4
	blt s0, t0, no_row_reset_find_black
	mv s0, zero
	addi s1, s1, 1
	li t0, 7
	bgt s1, t0, not_found_black_piece
	no_row_reset_find_black:
	
	load_piece(s0,s1)
	mv t0, a0
	li t1, BLACK
	li t2, BLACK_KING
	beq t0, t1, found_black_piece
	beq t0, t2, found_black_piece
	addi s0, s0, 1
	j find_black_piece_loop
	found_black_piece:
	li s2, 1
	j end_find_black_piece
	not_found_black_piece:
	li s2, 0

	end_find_black_piece:
	mv a0, s2

	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	addi sp, sp, 12
	ret

find_white_piece:
	addi sp, sp, -12
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	
	mv s0, zero
	mv s1, zero
	mv s2, zero
	
	find_white_piece_loop:
	li t0, 4
	blt s0, t0, no_row_reset_find_white
	mv s0, zero
	addi s1, s1, 1
	li t0, 7
	bgt s1, t0, not_found_white_piece
	no_row_reset_find_white:
	
	load_piece(s0,s1)
	mv t0, a0
	li t1, WHITE
	li t2, WHITE_KING
	beq t0, t1, found_white_piece
	beq t0, t2, found_white_piece
	addi s0, s0, 1
	j find_white_piece_loop
	found_white_piece:
	li s2, 1
	j end_find_white_piece
	not_found_white_piece:
	li s2, 0

	end_find_white_piece:
	mv a0, s2

	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	addi sp, sp, 12
	ret