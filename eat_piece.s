.text
# params: a0(X axis), a1(Y axis), a2 (UP || down)
#
# Eats piece in (a0,a1+a2) 
# if odd delivers piece in (a0,a1) to:
# (a0 - 1,a1 +(2*a2)) 
# if even deliver piece to:
# (a0 + 1,a1 +(2*a2)) 
eat_y_axis:
	addi sp, sp, -12
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)

	mv s0, a0
	mv s1, a1
	odd_right_even_left(a1)
	mv s2, a0
	
	load_piece(s0,s1) # a0 = piece
	# Clearing original space
	store_piece(s0,s1,zero)
	# Clearing eaten space
	add s1, s1, a2
	store_piece(s0,s1,zero)
	# Storing at destination
	add s1, s1, a2
	add s0, s0, s2 # Goes left if even and right if odd
	store_piece(s0,s1,a0)
	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	addi sp, sp, 12
	ret

# params: a0(X axis), a1(Y axis), a2 (UP || down) 
#
# Piece in (a0,a1):
# 	eats: (a0 + Z,a1 +a2)
#  	delivers: (a0 + Z,a1 +(2 * a2))
# where Z = 1 if a1 is odd
# and Z = -1 if a1 is even 
eat_x_axis:
	addi sp, sp, -12
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)

	mv s0, a0
	mv s1, a1
	odd_left_even_right(a1)
	mv s2, a0
	load_piece(s0,s1) # a0 = piece
	# Clearing original space
	store_piece(s0,s1,zero)
	# Clearing eaten space
	add s1, s1, a2
	add s0, s0, s2 # Goes left if odd and right if even
	store_piece(s0,s1,zero)
	# Storing at destination
	add s1, s1, a2
	store_piece(s0,s1,a0)
	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	addi sp, sp, 12
	ret