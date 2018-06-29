.text
# params: a0(X axis), a1(Y axis)
# Eats up piece and delivers piece to UP RIGHT if Y is odd
# or UP LEFT if Y is even
eat_up:
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
	addi s1, s1, UP
	store_piece(s0,s1,zero)
	# Storing at destination
	addi s1, s1, UP
	add s0, s0, s2 # Goes left if even and right if odd
	store_piece(s0,s1,a0)
	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	addi sp, sp, 12
	ret