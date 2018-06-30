# Macros params can't be t0 - t3
.macro load_piece(%x,%y)
	slli t0, %y, 2
	la t1, base # Loads base adress
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

.macro mv_up(%x,%y)
 	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, UP
	store_piece(%x,t3,a0)
.end_macro

.macro mv_down(%x,%y)
 	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, DOWN
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

.macro mv_down_right(%x,%y)
	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, DOWN
	addi t2, %x, RIGHT
	store_piece(t2,t3,a0)
.end_macro

.macro mv_down_left(%x,%y)
	load_piece(%x,%y)
	store_piece(%x,%y,zero) 	
	addi t3, %y, DOWN
	addi t2, %x, LEFT
	store_piece(t2,t3,a0)
.end_macro

# a0 = LEFT (1) if Y is even, a0 = RIGHT (-1) if Y is odd
.macro odd_right_even_left(%y)
	andi t0, %y, 0x01
	slli t0, t0, 1
	li t1, LEFT
	sub a0, t1, t0
.end_macro

.macro odd_left_even_right(%y)
	andi t0, %y, 0x01
	slli t0, t0, 1
	li t1, RIGHT
	add a0, t1, t0
.end_macro

# params: a0(X axis), a1(Y axis)
# Eats piece in specified direction
.macro eat(%direction)
	li a2, %direction
	jal eat_y_axis
.end_macro

# params: a0(X axis), a1(Y axis)
# Eats piece in specified direction
.macro can_eat(%direction)
	li a2, %direction
	jal can_eat_y_axis
.end_macro

# params: a0(X axis), a1(Y axis)
# Eats adjacent piece in specified direction
# note: If Y is odd adjacent is to the left
# if Y us even adjacent is to the right
.macro eat_adj(%direction)
	li a2, %direction
	jal eat_x_axis
.end_macro

.macro can_eat_adj(%direction)
	li a2, %direction
	jal can_eat_x_axis
.end_macro
# params: piece1 reg, piece2 reg
# Returns a0 = piece1 != piece2
.macro compare(%piece1, %piece2)
	xor t0, %piece1, %piece2
	andi t0, t0, 0x02
	srl a0, t0, t1
.end_macro
