
.macro A1(%player)
	li a0, 0xff000000
	li t0, 60515
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro A2(%player)
	li a0, 0xff000000
	li t0, 60580
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro A3(%player)
	li a0, 0xff000000
	li t0, 60650
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro A4(%player)
	li a0, 0xff000000
	li t0, 60720
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
#------------------------------------------------------------------
.macro B1(%player)
	li a0, 0xff000000
	li t0, 50950
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro B2(%player)
	li a0, 0xff000000
	li t0, 51015
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro B3(%player)
	li a0, 0xff000000
	li t0, 51080
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro B4(%player)
	li a0, 0xff000000
	li t0, 51145
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
# -------------------------------------------------------------------

.macro C1(%player)
	li a0, 0xff000000
	li t0, 41325
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro C2(%player)
	li a0, 0xff000000
	li t0, 41386
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro C3(%player)
	li a0, 0xff000000
	li t0, 41447
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro C4(%player)
	li a0, 0xff000000
	li t0, 41508
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
#---------------------------------------------------------------	

.macro D1(%player)
	li a0, 0xff000000
	li t0, 33360
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro D2(%player)
	li a0, 0xff000000
	li t0, 33420
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro D3(%player)
	li a0, 0xff000000
	li t0, 33475
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro D4(%player)
	li a0, 0xff000000
	li t0, 33534	
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
#-------------------------------------------------------------	

.macro E1(%player)
	li a0, 0xff000000
	li t0, 25975
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro E2(%player)
	li a0, 0xff000000
	li t0, 26030
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro E3(%player)
	li a0, 0xff000000
	li t0, 26085
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
.macro E4(%player)
	li a0, 0xff000000
	li t0, 26142
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
	
#--------------------------------------------------------------

.macro F1(%player)
	li a0, 0xff000000
	li t0, 19603
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro F2(%player)
	li a0, 0xff000000
	li t0, 19660
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro F3(%player)
	li a0, 0xff000000
	li t0, 19712
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro F4(%player)
	li a0, 0xff000000
	li t0, 19767
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
#-----------------------------------------------------------	

.macro G1(%player)
	li a0, 0xff000000
	li t0, 13180
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro G2(%player)
	li a0, 0xff000000
	li t0, 13232
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro G3(%player)
	li a0, 0xff000000
	li t0, 13284
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro G4(%player)
	li a0, 0xff000000
	li t0, 13336
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro
#-----------------------------------------------------------	

.macro H1(%player)
	li a0, 0xff000000
	li t0, 7770
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro H2(%player)
	li a0, 0xff000000
	li t0, 7820
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro H3(%player)
	li a0, 0xff000000
	li t0, 7870
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

.macro H4(%player)
	li a0, 0xff000000
	li t0, 7920
	add a0, a0, t0 # a0 = local a ser printado no MMIO
	add a1, %player, zero # a1 = player escolhido
.end_macro

