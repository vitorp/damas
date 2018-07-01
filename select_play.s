.text

# Params: a0(X Axis), a1 (Y Axis)
# Returns: a0( Options count )
load_play_options:
	addi sp, sp, -16
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw ra, 12(sp)
	
	mv s0, a0
	mv s1, a1
	mv s2, zero

	load_piece(s0,s1)
	li t0, BLACK
	beq a0, t0, black_options

	white_options:
	
	mv a0, s0
	mv a1, s1
	la a2, can_mv_up
	la a3, play_mv_up
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	mv a0, s0
	mv a1, s1
	la a2, can_mv_up_right
	la a3, play_mv_up_right
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	mv a0, s0
	mv a1, s1
	la a2, can_mv_up_left
	la a3, play_mv_up_left
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	j end_play_options

	black_options:
	mv a0, s0
	mv a1, s1
	la a2, can_mv_down
	la a3, play_mv_down
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	mv a0, s0
	mv a1, s1
	la a2, can_mv_down_right
	la a3, play_mv_down_right
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	mv a0, s0
	mv a1, s1
	la a2, can_mv_down_left
	la a3, play_mv_down_left
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	end_play_options:
	slli t0, s2, 2 # Calculate array pos
	addi s2, s2, 1
	la t1, play_options
	add t1, t1, t0
	la t2, reselect_piece
	sw t2, 0(t1)
	
	mv a0, s2
	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

# Params: a0(Options count)
# Returns: a0 (Option address)
choose_option:
	addi sp, sp, -16
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw ra, 12(sp)
	
	mv s0, a0 # s0= options count
	mv s1, zero # s1 = counter
	la s2, play_options

	print_option_loop:
	beq s1, s0, read_option
	
	# Print option index
	li a7, 1
	mv a0, s1
	ecall

	
	slli t1, s1, 2 # Option index
	add t0, s2, t1 # Option full address
	lw a0, 0(t0)
	jal option_text_addr # a0 = text addr
	li a7, 4
	ecall # Print option text
	addi s1, s1 ,1
	j print_option_loop
	
	read_option:
	li a7, 5
	ecall # Reading option
	slli t0, a0, 2
	add t0, s2, t0
	lw a0, 0(t0)
	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

# Params: a0 (Options Adress), a1(X Axis), a2 (Y Axis)
execute_option:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	jalr a0, 0 # Execute option
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
# Params: a1(X Axis), a2 (Y Axis)
play_mv_up:
	mv_up(a1,a2)
	ret
# Params: a1(X Axis), a2 (Y Axis)
play_mv_up_right:
	mv_up_right(a1,a2)
	ret
# Params: a1(X Axis), a2 (Y Axis)
play_mv_up_left:
	mv_up_left(a1,a2)
	ret
# Params: a1(X Axis), a2 (Y Axis)
play_mv_down:
	mv_down(a1,a2)
	ret
# Params: a1(X Axis), a2 (Y Axis)
play_mv_down_right:
	mv_down_right(a1,a2)
	ret
# Params: a1(X Axis), a2 (Y Axis)
play_mv_down_left:
	mv_down_left(a1,a2)
	ret

reselect_piece:
	j turn_loop

# Params: a0(X Axis), a1 (Y Axis), a2(Check Option label), a3(Option label), a4(Options counter)
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

# Params: a0(Option address)
# Return: a0 (Option text adress)
option_text_addr:
	la t0, play_mv_up
	bne a0, t0, not_mv_up
	la a0, mv_up_text
	ret
	not_mv_up:
	
	la t0, play_mv_up_right
	bne a0, t0, not_mv_up_right
	la a0, mv_up_right_text
	ret
	not_mv_up_right:
	
	la t0, play_mv_up_left
	bne a0, t0, not_mv_up_left
	la a0, mv_up_left_text
	ret
	not_mv_up_left:
	
	la t0, play_mv_down
	bne a0, t0, not_mv_down
	la a0, mv_down_text
	ret
	not_mv_down:
	
	la t0, play_mv_down_right
	bne a0, t0, not_mv_down_right
	la a0, mv_down_right_text
	ret
	not_mv_down_right:
	
	la t0, play_mv_down_left
	bne a0, t0, not_mv_down_left
	la a0, mv_down_left_text
	ret
	not_mv_down_left:
	
	la t0, reselect_piece
	bne a0, t0, not_reselect_piece
	la a0, reselect_piece_text
	ret
	not_reselect_piece:
	
	la a0, error_text
	ret

# Params: No params
# Return: a0 (X Axis), a1(Y Axis)
# Reads user input for X and Y piece coordenates
select_piece:
	addi sp, sp, -12
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	reset_select_piece:
	print_string(piece_x)
	li a7, 5
	ecall # Piece X Axis
	mv s0, a0
	
	print_string(piece_y)
	li a7, 5
	ecall # Piece Y Axis
	mv s1, a0
	
	mv a0, s0
	mv a1, s1
	jal in_board
	bne a0, zero, select_piece_succ
	
	print_string(invalid_x_y)
	j reset_select_piece

	select_piece_succ:
	mv a0, s0
	mv a1, s1
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	addi sp, sp, 12
	ret
