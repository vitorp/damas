.text
# params: a0(X axis), a1(Y axis)
# return: a0 = 1 if true, a0 = 0 if false
can_mv_up:
	addi sp, sp, -4
	sw s0, 0(sp)

	addi s0, a1, UP
	blt s0, zero, up_fail
	load_piece(a0,s0)
	li s0, 1
	blt a0, s0, up_succ
	up_fail:
	li a0, 0
	j end_can_mv_up
	up_succ:
	li a0, 1
	
	end_can_mv_up:
	lw s0, 0(sp)
	addi sp, sp, 4
	ret

# params: a0(X axis), a1(Y axis)
# return: a0 = 1 if true, a0 = 0 if false
can_mv_down:
	addi sp, sp, -8
	sw s0, 0(sp)
	sw s1, 4(sp)

	addi s0, a1, DOWN
	li s1, 7
	bgt s0, s1, down_fail
	load_piece(a0,s0)
	li s1, 1
	blt a0, s1, down_succ
	down_fail:
	li a0, 0
	j end_can_mv_down
	down_succ:
	li a0, 1

	end_can_mv_down:
	lw s0, 0(sp)
	lw s1, 4(sp)
	addi sp, sp, 8
	ret

# params: a0(X axis), a1(Y axis)
# return: a0 = 1 if true, a0 = 0 if false
can_mv_up_right:
	addi sp, sp, -8
	sw s0, 0(sp)
	sw s1, 4(sp)
	
	# Checks if line is even
	andi t0, a1, 0x01
	bne t0, zero, up_right_fail

	addi s0, a1, UP
	addi s1, a0, RIGHT
	# Checks if its in board
	blt s0, zero, up_right_fail
	blt s1, zero, up_right_fail
	load_piece(s1,s0)
	# Checks if space is empty
	li t0, 1
	blt a0, t0, up_right_succ
	up_right_fail:
	li a0, 0
	j end_can_mv_up_right
	up_right_succ:
	li a0, 1

	end_can_mv_up_right:
	lw s0, 0(sp)
	lw s1, 4(sp)
	addi sp, sp, 8
	ret

# params: a0(X axis), a1(Y axis)
# return: a0 = 1 if true, a0 = 0 if false
can_mv_up_left:
	addi sp, sp, -8
	sw s0, 0(sp)
	sw s1, 4(sp)
	
	# Checks if line is odd
	andi t0, a1, 0x01
	beq t0, zero, up_left_fail

	addi s0, a1, UP
	addi s1, a0, LEFT
	# Checks if its in board
	blt s0, zero, up_left_fail
	li t0, 3
	bgt s1, t0, up_left_fail
	load_piece(s1,s0)
	# Checks if space is empty
	li t0, 1
	blt a0, t0, up_left_succ
	up_left_fail:
	li a0, 0
	j end_can_mv_up_left
	up_left_succ:
	li a0, 1

	end_can_mv_up_left:
	lw s0, 0(sp)
	lw s1, 4(sp)
	addi sp, sp, 8
	ret

# params: a0(X axis), a1(Y axis)
# return: a0 = 1 if true, a0 = 0 if false
can_mv_down_right:
	addi sp, sp, -8
	sw s0, 0(sp)
	sw s1, 4(sp)
	
	# Checks if line is even
	andi t0, a1, 0x01
	bne t0, zero, down_right_fail

	addi s0, a1, DOWN
	addi s1, a0, RIGHT
	# Checks if its in board
	li t0, 7
	bgt s0, t0, down_right_fail
	blt s1, zero, down_right_fail
	load_piece(s1,s0)
	# Checks if space is empty
	li t0, 1
	blt a0, t0, down_right_succ
	down_right_fail:
	li a0, 0
	j end_can_mv_down_right
	down_right_succ:
	li a0, 1

	end_can_mv_down_right:
	lw s0, 0(sp)
	lw s1, 4(sp)
	addi sp, sp, 8
	ret

# params: a0(X axis), a1(Y axis)
# return: a0 = 1 if true, a0 = 0 if false
can_mv_down_left:
	addi sp, sp, -8
	sw s0, 0(sp)
	sw s1, 4(sp)
	
	# Checks if line is odd
	andi t0, a1, 0x01
	beq t0, zero, down_left_fail

	addi s0, a1, DOWN
	addi s1, a0, LEFT
	# Checks if its in board
	li t0, 7
	bgt s0, t0, down_left_fail
	li t0, 3
	bgt s1, t0, down_left_fail
	load_piece(s1,s0)
	# Checks if space is empty
	li t0, 1
	blt a0, t0, down_left_succ
	down_left_fail:
	li a0, 0
	j end_can_mv_down_left
	down_left_succ:
	li a0, 1

	end_can_mv_down_left:
	lw s0, 0(sp)
	lw s1, 4(sp)
	addi sp, sp, 8
	ret