.macro load_piece(%x,%y)
	la t1, base # Loads base adress
	slli t0, %y, 2
	add t0, t1, t0 # Calculates line address
 	add t0, t0, %x # Calculates column address
 	lb a0, 0(t0)
.end_macro

.macro store_piece(%x,%y,%piece)
	la t1, base # Loads base address
	slli t0, %y, 2
 	add t0, t1, t0 # Calculates line address
 	add t0, t0, %x # Calculates column address
 	sb %piece, 0(t0)
.end_macro

.macro mv_down(%x,%y)
 	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, DOWN
	store_piece(%x,t3,a0)
.end_macro

.macro mv_up(%x,%y)
 	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, UP
	store_piece(%x,t3,a0)
.end_macro

.macro mv_up_right(%x,%y)
	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, UP
	addi t2, %x, RIGHT
	store_piece(t2,t3,a0)
.end_macro

.macro mv_up_left(%x,%y)
	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, UP
	addi t2, %x, LEFT
	store_piece(t2,t3,a0)
.end_macro

.macro mv_down_left(%x,%y)
	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, DOWN
	addi t2, %x, LEFT
	store_piece(t2,t3,a0)
.end_macro

.macro mv_down_right(%x,%y)
	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, DOWN
	addi t2, %x, RIGHT
	store_piece(t2,t3,a0)
.end_macro

#.macro can_mv_up(%x,%y)
#	addi t3, %
#	load_piece
#.end_macro
