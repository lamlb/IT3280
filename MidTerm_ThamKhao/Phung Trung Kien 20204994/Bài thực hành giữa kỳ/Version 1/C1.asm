.data
msg:	.asciiz	"Nhap xau: "
S:	.space	100

.text
main:
	li	$v0, 54		# Nhap xau
	la	$a0, msg	# In ra msg
	la	$a1, S		# Luu dia chi xau vao a1
	la 	$a2, 100	# Max-length = 100
	syscall
	la	$t4, S		# Dia chi dau cua tu ngan nhat
	la	$t5, S		# Dia chi cuoi cua tu ngan nhat
	la	$t6, 100	# Do dai cua tu ngan nhat
	
	la	$t0, S		# Dia chi dau cua tu dang xet
	la	$t1, S		# Dia chi cuoi cua tu dang xet
	la	$t3, 1		# Do dai cua tu dang xet
	
	f1:	# !!! f1 thuc hien tim vi tri cua tu be nhat
		lb $s1, 0($t1)		# load ki tu
		beq $s1, $zero, f13	# Neu ki tu == \0 thi den f13 roi thoat
		bne $s1, 32, f11	# Neu ki tu != space thi den f11
			blt $t6, $t3 ,f12	# If t3(lenght now string) < t6(Min lenght string)
				addi $t4, $t0, 0	# Luu dia chi dau cua tu be nhat
				sub $t5, $t1, 1		# Luu dia chi cuoi cua tu be nhat
				addi $t6, $t3, 0	# Luu do dai cua tu be nhat
			f12:  
			addi $t0, $t1, 1	# Dia chi dau cua tu dang xet t0 = t1 + 1
			la $t3, 0		# Do dai tu dang xet t3 = 0	
		f11:
		addi $t1, $t1, 1	# t1 += 1
		addi $t3, $t3, 1	# t3 += 1
		j f1			# jump to f1
	f13:
			blt $t6, $t3 ,fout		# If t3(lenght now string) < t6(Min lenght string)
				addi $t4, $t0, 0	# Luu dia chi dau cua tu be nhat
				sub $t5, $t1, 1		# Luu dia chi cuoi cua tu be nhat
				addi $t6, $t3, 0	# Luu do dai cua tu be nhat
			fout:  
	
	f2:	# !!! f2 thuc hien in tu do
		li 	$v0, 11
		lb 	$a0, 0($t4)	# in ra 1 ky tu
		syscall
		blt $t5, $t4, exit_f2	# Neu t5 < t4 vi tri cuoi thi thoat
		addi $t4, $t4, 1	# t4 += 1
		j f2
		
	exit_f2:
	
