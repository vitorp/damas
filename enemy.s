enemy_turn:
	addi sp, sp, -12
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)

	jal movable_enemies # a0 = movable enemies count
	jal select_enemy # a0 = X axis, a1 = Y Axis
	mv s0, a0
	mv s1, a1
	jal load_mv_options
	mv a2, a0
	mv a0, s0
	mv a1, s1
	jal load_eat_options # a0 = option count
	jal select_option # a0 = selected option
	mv a1, s0
	mv a2, s1
	jal execute_option

	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	addi sp, sp, 12
	ret

# Params: Null
# Return: a0(Movable enemies count)
# Also stores coordenates of movable enemies in enemy_options
movable_enemies:
	addi sp, sp, -16
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw ra, 12(sp)

	mv s0, zero # s0 = X Axis
	mv s1, zero # s1 = Y Axis
	mv s2, zero # s2 = Movable enemy pieces counter
	
	movable_enemies_loop:
	li t0, 4
	blt s0, t0, no_row_reset
	mv s0, zero
	addi s1, s1, 1
	li t0, 7
	bgt s1, t0, end_movable_enemies
	no_row_reset:
	load_piece(s0,s1)
	li t0, WHITE
	beq a0, t0, no_enemy_option
	li t0, EMPTY
	beq a0, t0, no_enemy_option
	li t0, WHITE_KING
	beq a0, t0, no_enemy_option
	mv a0, s0
	mv a1, s1
	jal load_mv_options
	mv a2, a0
	mv a0, s0
	mv a1, s1
	jal load_eat_options # a0 =  Option Count
	beq a0, zero, no_enemy_option
	la t0, enemy_options
	slli t1, s2, 3 # Skips 2 words
	add t0, t0, t1
	sw s0, 0(t0) # Store X Axis
	sw s1, 4(t0) # Store Y Axis
	addi s2, s2, 1 # Increments movable enemies counter
	no_enemy_option:
	addi s0, s0, 1
	j movable_enemies_loop
	
	end_movable_enemies:
	mv a0, s2
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

# Params: a0 ( Movable enemies count)
# Return: a0 (X axis), a1 (Y axis)
# Selects randomly a movable enemy
select_enemy:
	addi sp, sp, -4
	sw s0, 0(sp)
	
	mv s0, a0
	mv a0, zero
	li a7, 41
	ecall
	bgt a0, t0, not_negative_select_enemy
	li t0, -1
	mul a0, a0, t0
	not_negative_select_enemy:
	rem t0, a0, s0
	slli t0, t0, 3
	la t1, enemy_options
	add t0, t0, t1
	lw a0, 0(t0)
	lw a1, 4(t0)
	
	lw s0, 0(sp)
	addi sp, sp, 4
	ret

# Params: a0 (Option count)
# Return: a0 (Option Label)
# Selects randomly an option
select_option:
	addi sp, sp, -4
	sw s0, 0(sp)
	
	mv s0, a0 # s0 = Option count
	mv a0, zero
	li a7, 41
	ecall
	bgt a0, t0, not_negative_select_option
	li t0, -1
	mul a0, a0, t0
	not_negative_select_option:
	rem t0, a0, s0 # selected option
	
	# Loads option
	slli t0, t0, 2
	la t1, play_options
	add t0, t0, t1
	lw a0, 0(t0)
	
	lw s0, 0(sp)
	addi sp, sp, 4
	ret
