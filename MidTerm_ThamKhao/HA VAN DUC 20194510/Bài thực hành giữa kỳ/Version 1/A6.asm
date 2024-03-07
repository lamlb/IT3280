.data
Message1: .asciiz "Input a: "
Message2: .asciiz "Input b: "
Message3: .asciiz "Input c: "
Message4: .asciiz "Khong phai la 3 canh tam giac!"
Message5: .asciiz "La 3 canh tam giac!"
.text
check_input_a:	addi $v0, $zero, 51		# Doc gia tri a
		la $a0, Message1
		syscall
		bne $a1, $zero, check_input_a	# Neu $a1 != 0 thi gia tri a khong phai la so nguyen, nhap lai
		nop				# Giai quyet van de delay branching
		add $s1, $zero, $a0		# Luu gia tri a vao thanh ghi $s1
		
check_input_b:	addi $v0, $zero, 51		# Doc gia tri b
		la $a0, Message2
		syscall
		bne $a1, $zero, check_input_b	# Neu $a1 != 0 thi gia tri b khong phai la so nguyen, nhap lai
		nop
		add $s2, $zero, $a0		# Luu gia tri b vao thanh ghi $s2
		
check_input_c:	addi $v0, $zero, 51		# Doc gia tri c
		la $a0, Message3
		syscall
		bne $a1, $zero, check_input_c	# Neu $a1 != 0 thi gia tri c khong phai la so nguyen, nhap lai
		nop
		add $s3, $zero, $a0		# Luu gia tri c vao thanh ghi $s3
		
main:
		blt $s1, 1, NotTriangle			# Neu a < 0 thi khong phai la tam giac	
		blt $s2, 1, NotTriangle			# Neu b < 0 thi khong phai la tam giac	
		blt $s3, 1, NotTriangle			# Neu c < 0 thi khong phai la tam giac
		
		add $t1, $s1, $s2			# $t1 = a + b
		bge $s3, $t1, NotTriangle		# Neu c >= a + b thi khong phai la tam giac
		nop
		add $t1, $s2, $s3			# $t1 = b + c
		bge $s1, $t1, NotTriangle		# Neu a >= b + c thi khong phai la tam giac
		nop
		add $t1, $s1, $s3			# $t1 = a + c
		bge $s2, $t1, NotTriangle		# Neu b >= a + c thi khong phai la tam giac
		nop
			
IsTriangle:		
		addi $v0, $zero, 55		# Hien thi Message5 ra man hinh
		la $a0, Message5
		addi $a1, $zero, 1
		syscall		
		j done
		nop	
NotTriangle:
		addi $v0, $zero, 55		# Hien thi Message4 ra man hinh
		la $a0, Message4
		addi $a1, $zero, 0
		syscall
done:
