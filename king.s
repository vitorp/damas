# Params: a0(Option Address) a1(X Axis), a2(Y axis)
king_loop:
	addi sp, sp, -32
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)
	sw s4, 20(sp)
	sw s5, 24(sp)
	sw s6, 28(sp)
	
	mv s0, a1 # s0 = X Axis
	mv s1, a2 # s1 = Y Axis
	mv s6, zero # s6 = Options Counter
	j king_execute
	next_king_option:
	mv s0, s2
	mv s1, s3
	mv s6, zero

	king_execute:
	mv a1, s0
	mv a2, s1
	jal execute_option
	mv s2, a0 # s2 = Destiny X Axis
	mv s3, a1 # s3 = Destiny Y Axis
	jal print_step
	sub s4, s3, s1 # s4 = UP || DOWN
	sub s5, s2, s0 # s5 = RIGHT || LEFT || 0
	
	
	li t0, 1
	bgt s4, t0, eat_option
	li t0, -1
	blt s4, t0, eat_option
	beq s5, zero, y_axis_move
	j move_option
	
	eat_option:
	andi t0, s3, 0x01
	beq t0, zero, king_even_eat 
	king_odd_eat:
	bgt s5, zero, y_axis_move
	j move_option
	king_even_eat:
	blt s5, zero, y_axis_move

	move_option:
	mv a0, s2
	mv a1, s3
	mv a3, s4
	jal load_mv_options_y_axis
	mv s6, a0
	j end_king_load
	
	y_axis_move:
	mv a0, s2
	mv a1, s3
	mv a3, s4
	jal load_mv_options_x_axis
	mv s6, a0
	end_king_load:
	la t0, line_control
	li t1, 0
	sw t1, 0(t0)
	mv a0, s6
	jal load_stop_option
	mv a1, s3
	jal choose_option # a0 = Option address
	j next_king_option

	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	lw s3, 16(sp)
	lw s4, 20(sp)
	lw s5, 24(sp)
	lw s6, 28(sp)
	addi sp, sp, 32
	ret

# Params: a0(X Axis), a1 (Y Axis), a3 ( UP || DOWN )
# Returns: a0( Options count )
load_mv_options_y_axis:
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	
	mv s0, a0 # s0 = X Axis
	mv s1, a1 # s1 = Y Axis
	mv s2, zero # s2 = Options counter

	blt a3, zero, going_up
	
	going_down:
	mv a0, s0
	mv a1, s1
	la a2, can_mv_down
	la a3, mv_down
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	mv a0, s0
	mv a1, s1
	la a2, can_eat_down
	la a3, eat_down
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	j end_load_options_y_axis
	going_up:
	mv a0, s0
	mv a1, s1
	la a2, can_mv_up
	la a3, mv_up
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	mv a0, s0
	mv a1, s1
	la a2, can_eat_up
	la a3, eat_up
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	end_load_options_y_axis:
	mv a0, s2

	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 16
	ret

# Params: a0(X Axis), a1 (Y Axis), a3 ( UP || DOWN )
# Returns: a0( Options count )
load_mv_options_x_axis:
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	
	mv s0, a0 # s0 = X Axis
	mv s1, a1 # s1 = Y Axis
	mv s2, zero # s2 = Options counter

	blt a3, zero, going_adj_up
	
	going_adj_down:
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
	
		
	mv a0, s0
	mv a1, s1
	la a2, can_eat_adj_down
	la a3, eat_adj_down
	mv a4, s2
	jal check_play_option
	add s2, s2, a0

	j end_load_options_x_axis
	going_adj_up:
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
	
	mv a0, s0
	mv a1, s1
	la a2, can_eat_adj_up
	la a3, eat_adj_up
	mv a4, s2
	jal check_play_option
	add s2, s2, a0
	
	end_load_options_x_axis:
	mv a0, s2
	
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 16
	ret

# Params: a0 (Option Count)
# Return: a0 (option Count)
load_stop_option:
	addi sp, sp, -4
	sw s0, 0(sp)
	
	mv s0, a0 # s0 = Options Counter
	
	slli t0, s0, 2 # Calculate array pos
	addi s0, s0, 1
	la t1, play_options
	add t1, t1, t0
	la t2, stop_king
	sw t2, 0(t1)
	
	mv a0, s0
	lw s0, 0(sp)
	addi sp, sp, 4
	ret
