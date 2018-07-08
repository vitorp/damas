.text

# params: a1(X axis), a2(Y axis)
# Eats piece in specified direction
eat_up:
	addi sp, sp, -4
	sw ra, 0(sp)
	li a0, UP
	jal eat_y_axis
	lw ra 0(sp)
	addi sp, sp, 4
	ret

# params: a1(X axis), a2(Y axis)
# Eats adjacent piece in specified direction
# note: If Y is odd adjacent is to the left
# if Y us even adjacent is to the right
eat_adj_up:
	addi sp, sp, -4
	sw ra, 0(sp)
	li a0, UP
	jal eat_x_axis
	lw ra 0(sp)
	addi sp, sp, 4
	ret

# params: a1(X axis), a0(Y axis)
# Eats piece in specified direction
eat_down:
	addi sp, sp, -4
	sw ra, 0(sp)
	li a0, DOWN
	jal eat_y_axis
	lw ra 0(sp)
	addi sp, sp, 4
	ret

# params: a1(X axis), a2(Y axis)
# Eats adjacent piece in specified direction
# note: If Y is odd adjacent is to the left
# if Y us even adjacent is to the right
eat_adj_down:
	addi sp, sp, -4
	sw ra, 0(sp)
	li a0, DOWN
	jal eat_x_axis
	lw ra 0(sp)
	addi sp, sp, 4
	ret
	
# params: a0(X axis), a1(Y axis)
# Eats piece in specified direction
can_eat_up:
	addi sp, sp, -4
	sw ra, 0(sp)
	li a2, UP
	jal can_eat_y_axis
	lw ra 0(sp)
	addi sp, sp, 4
	ret

# params: a0(X axis), a1(Y axis)
# Eats piece in specified direction
can_eat_down:
	addi sp, sp, -4
	sw ra, 0(sp)
	li a2, DOWN
	jal can_eat_y_axis
	lw ra 0(sp)
	addi sp, sp, 4
	ret

# params: a0(X axis), a1(Y axis)
# Eats piece in specified direction
can_eat_adj_up:
	addi sp, sp, -4
	sw ra, 0(sp)
	li a2, UP
	jal can_eat_x_axis
	lw ra 0(sp)
	addi sp, sp, 4
	ret

# params: a0(X axis), a1(Y axis)
# Eats piece in specified direction
can_eat_adj_down:
	addi sp, sp, -4
	sw ra, 0(sp)
	li a2, DOWN
	jal can_eat_x_axis
	lw ra 0(sp)
	addi sp, sp, 4
	ret


# params: a0 (UP || down), a1(X axis), a2(Y axis)
#
# Eats piece in (a0,a1+a2) 
# if odd delivers piece in (a0,a1) to:
# (a0 - 1,a1 +(2*a2)) 
# if even deliver piece to:
# (a0 + 1,a1 +(2*a2)) 
eat_y_axis:
	addi sp, sp, -16
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)

	mv s0, a1
	mv s1, a2
	mv s3, a0
	odd_right_even_left(s1)
	mv s2, a0
	
	load_piece(s0,s1) # a0 = piece
	# Clearing original space
	store_piece(s0,s1,zero)
	# Clearing eaten space
	add s1, s1, s3
	store_piece(s0,s1,zero)
	# Storing at destination
	add s1, s1, s3
	add s0, s0, s2 # Goes left if even and right if odd
	store_piece(s0,s1,a0)
	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	addi sp, sp, 16
	ret

# params:  a0 (UP || down) , a1(X axis), a2(Y axis)
#
# Piece in (a0,a1):
# 	eats: (a0 + Z,a1 +a2)
#  	delivers: (a0 + Z,a1 +(2 * a2))
# where Z = 1 if a1 is odd
# and Z = -1 if a1 is even 
eat_x_axis:
	addi sp, sp, -20
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw s4, 16(sp)

	mv s0, a1 # s0 = X Axis
	mv s1, a2 # S1 = Y Axis
	mv s3, a0 # S3 = UP || DOWN
	odd_left_even_right(s1)
	mv s2, a0 # s2 = LEFT || RIGHT

	load_piece(s0,s1)
	mv s4, a0 # s4 = piece
	# Clearing original space
	store_piece(s0,s1,zero)
	# Clearing eaten space
	add s1, s1, s3
	add s0, s0, s2 # Goes left if odd and right if even
	store_piece(s0,s1,zero)
	# Storing at destination
	add s1, s1, s3
	store_piece(s0,s1,s4)
	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw s4, 16(sp)
	addi sp, sp, 20
	ret

# params: a0(X axis), a1(Y axis), a2 (UP || down) 
# Checks if piece to be eaten is from a diferent team
# and if the destination is empty
# Assumes selected space is not empty
can_eat_y_axis:
	addi sp, sp, -28
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw s4, 16(sp)
	sw s5, 20(sp)
	sw ra, 24(sp)
	
	mv s0, a0
	mv s1, a1
	mv s5, a2
	odd_right_even_left(a1)
	mv s2, a0
	
	# Comparing pieces teams
	load_piece(s0,s1) 
	mv s3, a0 # s3 = piece
	add s1, s1, s5

	mv a0, s0
	mv a1, s1
	jal in_board
	beq a0, zero, can_eat_y_axis_fail # Checks if eaten piece is in board
	load_piece(s0,s1)
	mv s4, a0 # s4 = piece to be eaten
	beq s4, zero, can_eat_y_axis_fail # checks if there is a piece
	compare(s3,s4) # checks if pieces are from diferent teams
	beq a0, zero, can_eat_y_axis_fail
	
	# Checking if destination is empty
	add s0, s0, s2
	add s1, s1, s5
	mv a0, s0
	mv a1, s1
	jal in_board
	beq a0, zero, can_eat_y_axis_fail # Checks if destination is in board
	load_piece(s0, s1)
	beq a0, zero, can_eat_y_axis_succ

	can_eat_y_axis_fail:
	li a0, 0
	j end_can_eat_y_axis
	can_eat_y_axis_succ:
	li a0, 1
	
	end_can_eat_y_axis:
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw s4, 16(sp)
	lw s5, 20(sp)
	lw ra, 24(sp)
	addi sp, sp, 28
	ret

# params: a0(X axis), a1(Y axis), a2 (UP || down) 
# Checks if piece to be eaten is from a diferent team
# and if the destination is empty
# Assumes selected space is not empty
can_eat_x_axis:
	addi sp, sp, -28
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw s4, 16(sp)
	sw s5, 20(sp)
	sw ra, 24(sp)
	
	mv s0, a0
	mv s1, a1
	mv s5, a2
	odd_left_even_right(a1)
	mv s2, a0
	
	# Comparing pieces teams
	load_piece(s0,s1) 
	mv s3, a0 # s3 = piece
	add s1, s1, s5
	add s0, s0, s2

	mv a0, s0
	mv a1, s1
	jal in_board
	beq a0, zero, can_eat_x_axis_fail # Checks if eaten piece is in board
	load_piece(s0,s1)
	mv s4, a0 # s4 = piece to be eaten
	beq s4, zero, can_eat_x_axis_fail # checks if there is a piece
	compare(s3,s4) # checks if pieces are from diferent teams
	beq a0, zero, can_eat_x_axis_fail
	
	# Checking if destination is empty
	add s1, s1, s5
	mv a0, s0
	mv a1, s1
	jal in_board
	beq a0, zero, can_eat_x_axis_fail # Checks if destination is in board
	load_piece(s0, s1)
	beq a0, zero, can_eat_x_axis_succ

	can_eat_x_axis_fail:
	li a0, 0
	j end_can_eat_x_axis
	can_eat_x_axis_succ:
	li a0, 1
	
	end_can_eat_x_axis:
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw s4, 16(sp)
	lw s5, 20(sp)
	lw ra, 24(sp)
	addi sp, sp, 28
	ret

# params: a0(X Axis), a1(Y Axis)
# Returns a0 = 1 if in board
# and a0 = 0 if out of board
in_board:
	li t0, 3
	blt a0, zero, in_board_fail
	bgt a0, t0, in_board_fail
	li t0, 7
	blt a1, zero, in_board_fail
	bgt a1, t0, in_board_fail
	in_board_succ:
	li a0, 1
	j end_in_board
	in_board_fail:
	li a0, 0
	end_in_board:
	ret
