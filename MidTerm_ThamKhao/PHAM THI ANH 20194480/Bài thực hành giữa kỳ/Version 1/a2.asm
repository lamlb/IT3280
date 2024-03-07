# 2. Nh?p 2 s? nguyên d??ng M và N t? bàn phím. In ra màn hình b?i s? chung nh? nh?t c?a M và N 
.data
	mess: .ascii "BCNN la: "
.text
	li $v0, 5
 	syscall 
 	add	$s0, $v0, 0		# M
 	
 	li $v0, 5
 	syscall 
 	add $s1, $v0, 0		#N
 	
 	li $t0, 0			#max
 	li $t1, 0			#step
 	li $t2, 0			#BCNN
 	
if:
 	ble $s0, $s1,else	#neu M <= N thi nhay
 	add $t0, $s0, 0		# max = M
 	add $t1, $s0, 0		# step = M
 	j loop
 	
else:
	add $t0, $s1, 0		# max = N
 	add $t1, $s1, 0		# step = N
 	
loop: 
	div $t0, $s0
	mfhi $a0			#neu max chia M du 0 thi tiep tuc lap
	bne $a0, $zero, endloop
	
	div $t0, $s1
	mfhi $a1			#neu max chia N du 0 thi tiep tuc lap
	bne $a1, $zero, endloop
	
	add $t2, $t0, 0		# BCNN = max
	j print

endloop:
	add $t0, $t0, $t1	# max += step
	j loop
	
print:
	li	$v0, 4
	la 	$a0, mess		#in chuoi
	syscall
	
	li	$v0, 1
	add $a0, $t2, 0		#in BCNN
	syscall
	

