.text

# Params: a0(X Axis), a1 (Y Axis)
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
	
	j select_play_options

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
	
	select_play_options:
	end_play_options:
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

# Params: a0(X Axis), a1 (Y Axis)
play_mv_up:
	mv_up(a0,a1)
	ret
# Params: a0(X Axis), a1 (Y Axis)
play_mv_up_right:
	mv_up_right(a0,a1)
	ret
# Params: a0(X Axis), a1 (Y Axis)
play_mv_up_left:
	mv_up_left(a0,a1)
	ret
# Params: a0(X Axis), a1 (Y Axis)
play_mv_down:
	mv_down(a0,a1)
	ret
# Params: a0(X Axis), a1 (Y Axis)
play_mv_down_right:
	mv_down_right(a0,a1)
	ret
# Params: a0(X Axis), a1 (Y Axis)
play_mv_down_left:
	mv_down_left(a0,a1)
	ret

# Params: a0(X Axis), a1 (Y Axis), a2(Check Option label), a3(Option label), a4(Options counter)
check_play_option:
	addi sp, sp , -4
	sw ra, 0(sp)

	jalr a2, 0
	beq a0, zero, skip_option
	
	slli t0, a4, 2 # Calculate array pos
	la t1, play_options
	add t1, t1, t0
	sw a3, 0(t1)
	addi a0, a4, 1
	j end_check_play_option
	
	skip_option:
	mv a0, a4
	end_check_play_option:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret