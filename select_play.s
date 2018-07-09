.text

# Params: a0(X Axis), a1 (Y Axis)
# Returns: a0( Options count )
load_mv_options:
	addi sp, sp, -20
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw ra, 12(sp)
	sw s3, 16(sp)

	mv s0, a0 # s0 = X Axis
	mv s1, a1 # s1 = Y Axis
	mv s2, zero # s2 = Options Count

	load_piece(s0,s1)
	mv s3, a0 # s3 = Piece

	li t0, BLACK
	beq s3, t0, black_options

	white_options:

	mv a0, s0
	mv a1, s1
	la a2, can_mv_up
	la a3, mv_up
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	mv a0, s0
	mv a1, s1
	la a2, can_mv_up_right
	la a3, mv_up_right
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	mv a0, s0
	mv a1, s1
	la a2, can_mv_up_left
	la a3, mv_up_left
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	li t0, WHITE
	beq s3, t0 end_play_options # If its not white its a king so it can continue to black options

	black_options:
	mv a0, s0
	mv a1, s1
	la a2, can_mv_down
	la a3, mv_down
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	mv a0, s0
	mv a1, s1
	la a2, can_mv_down_right
	la a3, mv_down_right
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	mv a0, s0
	mv a1, s1
	la a2, can_mv_down_left
	la a3, mv_down_left
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	end_play_options:
	mv a0, s2

	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw ra, 12(sp)
	lw s3, 16(sp)
	addi sp, sp, 20
	ret

# Params: a0 (X Axis), a1(Y Axis), a2(Options Count)
# Return: a0 (Options Count)
load_eat_options:
	addi sp, sp, -20
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw ra, 12(sp)
	sw s3, 16(sp)

	mv s0, a0 # s0 = A Axis
	mv s1, a1 # s1 - Y Axis
	mv s2, a2 # s3 = Options Count

	load_piece(s0,s1)
	mv s3, a0 # s3 = a0
	li t0, BLACK
	beq a0, t0, black_eat_options

	white_eat_options:

	mv a0, s0
	mv a1, s1
	la a2, can_eat_up
	la a3, eat_up
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	mv a0, s0
	mv a1, s1
	la a2, can_eat_adj_up
	la a3, eat_adj_up
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	li t0, WHITE
	beq s3, t0 end_eat_options # If its not white its a king so it can continue to black options
	black_eat_options:

	mv a0, s0
	mv a1, s1
	la a2, can_eat_down
	la a3, eat_down
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	mv a0, s0
	mv a1, s1
	la a2, can_eat_adj_down
	la a3, eat_adj_down
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	end_eat_options:
	mv a0, s2 # a0 = Options count
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw ra, 12(sp)
	lw s3, 16(sp)
	addi sp, sp, 20
	ret

# Params: a0 (Option Count)
# Return: a0 (option Count)
load_reselect_piece:
	addi sp, sp, -4
	sw s0, 0(sp)

	mv s0, a0

	slli t0, s0, 2 # Calculate array pos
	addi s0, s0, 1
	la t1, play_options
	add t1, t1, t0
	la t2, reselect_piece
	sw t2, 0(t1)

	mv a0, s0
	lw s0, 0(sp)
	addi sp, sp, 4
	ret

# Params: a0(Options count), a1 (Y axis)
# Returns: a0 (Option address)
choose_option:
	addi sp, sp, -20
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw ra, 12(sp)
	sw s3, 16(sp)

	mv s0, a0 # s0= options count
	mv s1, zero # s1 = counter
	la s2, play_options
	mv s3, a1
	j print_option_loop

	read_option_invalid:
	print_string(invalid_option)
	mv s1, zero

	print_option_loop:
	beq s1, s0, read_option

	# Print option index
	print_int(s1)


	slli t1, s1, 2 # Option index
	add t0, s2, t1 # Option full address
	lw a0, 0(t0)
	mv a1, s3
	jal option_text_addr # a0 = text addr
	print_string_reg(a0) # Print option text

	addi s1, s1 ,1
	j print_option_loop


	read_option:
	read_int()
	blt a0, zero, read_option_invalid
	addi t0, s0, -1
	bgt a0, t0, read_option_invalid

	slli t0, a0, 2
	add t0, s2, t0
	lw a0, 0(t0)

	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw ra, 12(sp)
	lw s3, 16(sp)
	addi sp, sp, 20
	ret

# Params: a0 (Options Adress), a1(X Axis), a2 (Y Axis)
# Return: a0(Destiny X Axis), a1(Destiny Y Axis)
execute_option:
	addi sp, sp, -4
	sw ra, 0(sp)

	jalr a0, 0 # Execute option

	lw ra, 0(sp)
	addi sp, sp, 4
	ret

reselect_piece:
	addi sp, sp, 4 # Free ra stacked in execute_option
	j turn_reset_step

stop_king:
	addi sp, sp, 4 # Free ra stacked in execute_option
	j turn_start_step

# Params: a0(X Axis), a1 (Y Axis), a2(Check Option label), a3(Option label), a4(Option Count)
# returns: a0 = 1 if option is added
#          a0 = 0 if option skipped
check_play_option:
	addi sp, sp , -4
	sw ra, 0(sp)

	jalr a2, 0
	beq a0, zero, skip_option

	slli t0, a4, 2 # Calculate array pos
	la t1, play_options
	add t1, t1, t0
	sw a3, 0(t1)
	li a0, 1
	j end_check_play_option

	skip_option:
	li a0, 0
	end_check_play_option:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

# Params: a0(Option address), a1 (Y Axis)
# Return: a0 (Option text adress)
option_text_addr:
	addi sp, sp, -4
	sw s0, 0(sp)

	mv s0, a1 # s0 = Y Axis

	la t0, mv_up
	bne a0, t0, not_mv_up
	andi t1, s0, 0x01
	beq t1, zero, mv_up_even_row
	la a0, mv_up_right_text
	j end_option_text_addr
	mv_up_even_row:
	la a0, mv_up_left_text
	j end_option_text_addr
	not_mv_up:

	la t0, mv_up_right
	bne a0, t0, not_mv_up_right
	la a0, mv_up_right_text
	j end_option_text_addr
	not_mv_up_right:

	la t0, mv_up_left
	bne a0, t0, not_mv_up_left
	la a0, mv_up_left_text
	j end_option_text_addr
	not_mv_up_left:

	la t0, mv_down
	bne a0, t0, not_mv_down
	la a0, mv_down_text
	j end_option_text_addr
	not_mv_down:

	la t0, mv_down_right
	bne a0, t0, not_mv_down_right
	la a0, mv_down_right_text
	j end_option_text_addr
	not_mv_down_right:

	la t0, mv_down_left
	bne a0, t0, not_mv_down_left
	la a0, mv_down_left_text
	j end_option_text_addr
	not_mv_down_left:

	la t0, eat_up
	bne a0, t0, not_eat_up
	la a0, eat_up_text
	j end_option_text_addr
	not_eat_up:

	la t0, eat_down
	bne a0, t0, not_eat_down
	la a0, eat_down_text
	j end_option_text_addr
	not_eat_down:

	la t0, eat_adj_up
	bne a0, t0, not_eat_adj_up
	la a0, eat_adj_up_text
	j end_option_text_addr
	not_eat_adj_up:

	la t0, eat_adj_down
	bne a0, t0, not_eat_adj_down
	la a0, eat_adj_down_text
	j end_option_text_addr
	not_eat_adj_down:

	la t0, reselect_piece
	bne a0, t0, not_reselect_piece
	la a0, reselect_piece_text
	j end_option_text_addr
	not_reselect_piece:

	la t0, stop_king
	bne a0, t0, not_stop_king
	la a0, stop_king_text
	j end_option_text_addr
	not_stop_king:

	la a0, error_text

	end_option_text_addr:

	lw s0, 0(sp)
	addi sp, sp, 4
	ret

# Params: No params
# Return: a0 (X Axis), a1(Y Axis)
# Reads user input for X and Y piece coordenates
select_piece:
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	reset_select_piece:
	print_string(piece_x)
	read_int() # Piece X Axis
	mv s0, a0
	# quit
	li t0, 11
	beq a0, t0, exit

	print_string(piece_y)
	read_int() # Piece Y Axis

	mv s1, a0

	mv a0, s0
	mv a1, s1
	jal in_board_human
	bne a0, zero, piece_in_board
	print_string(invalid_x_y)
	li t4, 3000
	sleep(t4)
	print_string(clear_line)
	j reset_select_piece

	piece_in_board:
	mv a0, s0
	mv a1, s1
	jal valid_space
	bne a0, zero, select_piece_succ
	print_string(invalid_x_y)
	li t4, 3000
	sleep(t4)
	print_string(clear_line)
	j reset_select_piece

	# Here we know space is valid so we translate X to the right index
	# 0 || 1 = 0
	# 2 || 3 = 1
	# 4 || 5 = 2
	# 6 || 7 = 3
	select_piece_succ:
	mv s2, zero
	li t0, 2
	blt s0, t0, end_select_piece
	addi s2, s2, 1
	li t0, 4
	blt s0, t0, end_select_piece
	addi s2, s2, 1
	li t0, 6
	blt s0, t0, end_select_piece
	addi s2, s2, 1

	end_select_piece:
	mv a0, s2
	mv a1, s1
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 16
	ret

# params: a0(X Axis), a1(Y Axis)
# Returns a0 = 1 if in board
# and a0 = 0 if out of board
in_board_human:
	li t0, 7
	blt a0, zero, in_board_human_fail
	bgt a0, t0, in_board_human_fail
	blt a1, zero, in_board_human_fail
	bgt a1, t0, in_board_human_fail
	in_board_human_succ:
	li a0, 1
	j end_in_board
	in_board_human_fail:
	li a0, 0
	end_in_board_human:
	ret

# params: a0(X Axis), a1(Y Axis)
# Returns a0 = 1 if valid space
# and a0 = 0 if invalid space
valid_space:
	addi t0, a0, 1
	andi t0, t0, 0x01
	andi t1, a1, 0x01
	xor a0, t0, t1
	ret
