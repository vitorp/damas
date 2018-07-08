# Macros params can't be t0 - t3, a0
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

# params: piece1 reg, piece2 reg
# Returns a0 = piece1 != piece2
.macro compare(%piece1, %piece2)
	xor t0, %piece1, %piece2
	andi t0, t0, 0x02
	srl a0, t0, t1
.end_macro

.macro print_string_reg(%reg)
	mv a0, %reg
	li a7, 4
	ecall
.end_macro

.macro print_string(%label)
	la a0, %label
	li a7, 4
	ecall
.end_macro

.macro read_int()
	li a7, 5
	ecall
.end_macro

.macro print_int(%int)
	mv a0, %int
	li a7, 1
	ecall
.end_macro

