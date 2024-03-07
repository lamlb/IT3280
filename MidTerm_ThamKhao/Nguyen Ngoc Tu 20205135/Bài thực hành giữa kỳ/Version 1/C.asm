.data
Msg: 	.space 100 	# 100 byte chua chuoi ki tu can
Msg_out:	.asciiz		"So tu trong mang xuat hien chu [Ch] la: "

.text
	li 	$v0, 8
	la 	$a0, Msg
	li 	$a1, 100
	syscall
Main:
	la	$s0, Msg	# Nap dia chi cua Message vao s0
	li	$s4, 0		# sum = 0: tong so tu bat dau bang chu "Ch"
	li	$s3, 1		# s3: ki tu doang load
	li	$t1, 0		#i = t1 = 0
	li	$s6, 32		#s6 = (space = 32)
	
	#Vong lap kiem tra co bao nhieu tu "Ch"
	
# Lay ra chu cai 'C' va chu cai 'h'
Loop1:
	add	$s5, $s0, $t1		#Dia chi cua ky tu dang load
	lb	$s3, 0($s5)
	beq	$s3, $zero, EndLoop	#= NULL -> ket thuc vong lap 
	beq	$s3, $s6, Can_Loop1
	add	$s1, $zero, $s3		#Ki tu dau tien trong 1 tu: s1
	addi	$t1, $t1, 1
	add	$s5, $s0, $t1
	lb	$s2, 0($s5)		#Ki tu thu 2 trong 1 tu: s2
	beq	$s2, $zero, EndLoop	#= NULL -> Ket thuc vong lap 
	beq	$s2, $s6, Can_Loop1		#Space -> Tiep tuc voi tu moi
	jal	check
	nop
	
Loop2:
# Xet cac tu tiep theo cho den khi gap space
	addi	$t1, $t1, 1
	add	$s5, $s0, $t1		#Dia chi cua ky tu dang load
	lb	$s3, 0($s5)		#ki tu tiep theo cua tu $s3
	beq	$s3, $zero, EndLoop
	beq	$s3, $s6, Can_Loop1		#Gap space => Quay lai Joop1
	j	Loop2
	addi	$t1, $t1, 1
	j	Loop1

Can_Loop1:
	addi 	$t1, $t1, 1
	j	Loop1

EndLoop:
	#in ra SUM
	li	$v0, 4
	la	$a0, Msg_out
	syscall
	
	li 	$v0, 1 
	add	$a0, $zero, $s4
	syscall
	j	End
	
	
check:
	li	$t2, 67		#t2 = 'C'
	li	$t3, 104	#t3 = 'h'
	bne	$t2, $s1, fail_check	# neu ki tu 1 khac C -> loai
	bne	$t3, $s2, fail_check	# neu ki tu 2 khac h -> loai  
	addi	$s4, $s4, 1
	jr	$ra

fail_check:
	jr	$ra
	
End:
	
