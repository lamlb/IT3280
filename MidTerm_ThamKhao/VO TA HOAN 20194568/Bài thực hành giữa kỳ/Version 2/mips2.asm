.data
	str1:	.asciiz	"Nhap so phan tu cua mang: "
	str2:	.asciiz	"Nhap phan tu cua mang: \n"
	str3:	.asciiz	"Mang sau khi duoc sap xep: "
.text
	la	    $a0, str1
	li	    $v0, 4
	syscall
	li 	    $v0, 5 			# so luong phan tu cua mang
	syscall
	
	addi 	$s6, $s6, 0x10010000 		# s6 -> 0x10010000 = &A : luu dia chi cua bo nho
	addi 	$s5, $s6, 0		# s5 -> 0x10010000 = &A : luu dia chi cua bo nho	
	
	addi 	$k1, $v0, 0 		# k1 = N
	addi 	$t1, $zero, 0		# i = 0
	
	addi 	$sp , $sp, 8   #thua
	la	    $a0, str2
	li	    $v0, 4
	syscall
loop_scan:
	slt 	$t0, $t1, $k1 		# if (i < N)
	beq 	$t0, $zero, end_loop_scan 	# neu i = N thi ket thuc nhap
	
	li 	    $v0, 5			# doc so nguyen 
	syscall
	sw 	    $v0, 0($s5)		# s5[i] = v0, luu so nguyen vua doc duoc vao s5
	
	addi 	$t1, $t1, 1		# i++
	addi 	$s5, $s5, 4		# s5 -> &A[i], tang dia chi cua s5 len 4 byte
	
	j 	    loop_scan
end_loop_scan:

main:
	addi 	$a0, $s6, 0 		# a0 = &A[0]
	jal	    sort
	
	addi 	$t1, $zero, 0 		# i = 0
	addi 	$s5, $s6, 0		# s5 = s6 -> &A[0]
	
	la	    $a0, str3
	li	    $v0, 4
	syscall
	
loop_print:
	slt 	$t0, $t1, $k1 		# if (i < N)
	beq 	$t0, $zero, end_loop_print
	
	li 	    $v0, 1 		# print integer
	lw 	    $a0, 0($s5)		# a0 = A[i]
	syscall
	
	li 	    $v0, 11 		# print character
	addi 	$a0, $zero, 44	
	syscall  
	
	addi	$t1, $t1, 1		# i++
	addi 	$s5, $s5, 4		# s5 -> &A[i] 
	
	j 	    loop_print
end_loop_print:
end_main:
	j 	    exit
swap: 
	sw	    $s0,0($t9)		# A[j] = A[i] truoc day
	sw	    $s1,0($t8)		# A[i] = A[j] truoc day
	jr	    $ra			# Quay lai va tiep tuc vong lap
sort:
	la 		$k0 , ($ra)
	
	addi 	$t1, $zero, 0		# i = 0
	addi 	$t2, $zero, 0		# j = 0
	addi 	$t8, $a0, 0		# t8 -> &A[0]
	loop_i: 
		slt 	$t0, $t1, $k1		# if (i < n)
		beq	    $t0, $zero, end_loop_i
	
		lw 	    $s0, 0($t8)		# s0 = A[i]
		bltz 	$s0, continue_i 		# if (A[i] < 0)
	
		addi  	$t2, $t1, 1		# j = i+1
		addi 	$t9, $t8, 4		# t9 -> A[i+1]	
	
		loop_j:
			slt 	$t0, $t2, $k1		# if (j < n)
			beq 	$t0, $zero, end_loop_j
	
			lw 	$s1, 0($t9)		# s1 = A[j]
			bltz 	$s1, continue_j		# if (s1 < 0) -> continue_j
	
			slt     $t0, $s1, $s0		# if (A[i] < A[j]) -> swap
			bne 	$t0, $zero, continue_j	# neu A[i] > A[j] thi nhay den contimue_j 
			jal 	swap
		continue_j:
			addi 	$t2, $t2, 1		# j++
			addi 	$t9, $t9, 4		# t9 -> &A[j]
			lw 	    $s0, 0($t8)		# t8 = A[i]
			j	    loop_j	
		end_loop_j:
	continue_i:
		addi 	$t1, $t1, 1		# i++
		addi 	$t8, $t8, 4		# t8 -> &A[i], nhay den vi tri tiep theo trong mang
		j	    loop_i	
	end_loop_i:
	la 	    $ra, 0($k0)
	jr 	    $ra
end_sort:
exit:

