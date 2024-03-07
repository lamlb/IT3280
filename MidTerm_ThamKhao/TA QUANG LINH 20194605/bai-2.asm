.data  
	mess1: .asciiz "Nhap so phan tu cua mang:"
	mess2: .asciiz "Nhap cac phan tu cua mang: "
	mess3: .asciiz "Khong co phan tu am"
	mess4: .asciiz "So am lon nhat la: "
	mess5: .asciiz "\nVi tri: "
.text
	li 	$v0, 51 			# read integer
	la 	$a0, mess1
	syscall
	
	addi 	$s6, $s6, 0x10010000 	# s6 -> 0x10010000 = &A
	addi 	$s5, $s6, 0		# s5 -> 0x10010000 = &A
	
	addi 	$s0, $a0, 0 		# s0 = N
	addi 	$t1, $zero, 0		# i = 0
	
loop_scan:
	slt 	$t0, $t1, $s0 		# if (i < N)
	beq 	$t0, $zero, end_loop_scan
	
	li 	$v0, 51			# read integer
	la 	$a0, mess2
	syscall
	
	sw 	$a0, 0($s5)		# s5[i] = v0
	
	addi 	$t1, $t1, 1		# i++
	addi 	$s5, $s5, 4		# s5 -> &A[i]
	
	j 	loop_scan
end_loop_scan:

main:
	addi 	$t2, $zero, 0		# Lưu giá trị 0 hoặc 1, để kiểm tra mảng chứa phần tử âm hay không \
	addi 	$t1, $zero, 0		# i = 0
	
	addi 	$s5, $s6, 0		# s5 -> &A[0]
	
	addi 	$s1, $zero, 0x80000000	# max = giá trị 32 bit nhỏ nhất 
	addi 	$s2, $zero, -1		# Lưu vị trí giá trị lớn nhất trong mảng 
loop:
	slt	$t0, $t1, $s0		# if (i < N)
	beqz 	$t0, end_loop		
	
	lw 	$a0, 0($s5)		# a0 = A[i]
	
	slti	$t0, $a0, 0		# if (a0 >= 0) -> loop
	beq	$t0, $zero, continue	# Bỏ qua số dương và 0 
	
	addi 	$t2, $zero, 1		# Có số âm xuất hiện 
	
	slt 	$t0, $s1, $a0		# if (max >= A[i]) -> loop
	beqz 	$t0, continue
	
	addi 	$s1, $a0, 0		# max = A[i]
	addi 	$s2, $t1, 0		# s2 = i
	
continue:
	addi 	$t1, $t1, 1		# i++
	addi 	$s5, $s5, 4		# s5 -> &A[i]
	j 	loop
end_loop:
	
	beqz 	$t2, thong_bao
	
	li 	$v0, 4 		#print string
	la 	$a0, mess4
	syscall
	
	li 	$v0, 1		#print integer
	addi 	$a0, $s1, 0
	syscall
	
	li 	$v0, 4 		#print string
	la 	$a0, mess5
	syscall
	
	li 	$v0, 1		#print integer
	addi 	$a0, $s2, 0
	syscall

end_main:
	li 	$v0, 10		#exit
	syscall

thong_bao:
	li 	$v0, 55		#print mess
	la	$a0, mess3
	syscall
	j 	end_main