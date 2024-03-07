.data
A: .space 100					# Mang A co do dai 25 luu tru cac chu so cua so nguyen N
Message: .asciiz "Nhap N (Nhap so co tu hai chu so tro len va nho hon 25 chu so): "
Message2: .asciiz "N co it nhat 2 chu so trung nhau!"
Message3: .asciiz "N khong co chu so nao trung nhau!"
.text
main:

input_N:
	li	$v0, 51
	la	$a0, Message
	syscall
	
	beq $a1, -1, input_N		# nhap lai neu khong phai so nguyen
	beq $a1, -3, input_N		# nhap lai neu khong phai so nguyen
	beq $a1, -2, exit			# thoat khi nguoi dung an cancel
	blt $a0, 10, input_N		# nhap lai neu nguoi dung nhap so nho hon 10

	add $a1, $a0, 0
	
	li $t0, 0					# i la index trong mang A
	li $s0, 0					# do dai mang A hien tai
	
check:
		li $t3, 10
loop1:	beq $a1, 0, end_loop1
		div $a1, $t3			# chia N cho 10 de lay cac chu so 
		mflo $a1				# lay phan thuong
		mfhi $t1				# lay phan du
		li $t0, 0				# i = 0
loop2:	beq $t0, $s0, end_loop2	# tim xem chu so hien tai da co trong mang A chua
								# neu chua co trong mang A thi them vao cuoi mang A va tang do dai mang A len 1
								# neu da co trong mang A thi so nguyen N co it nhat 2 chu so giong nhau 
		sll $t2, $t0, 2			# 4*i
		lw $t2, A($t2)			# A[i]
		beq $t1, $t2, N_co_2cs_trung_nhau	# neu chu so hien tai dang xet(phan du cua phep chia N voi 10) da co trong mang A
											# thi in ra N co 2 chu so trung nhau
		add $t0, $t0, 1
		j loop2
end_loop2:
		sll $t4, $s0, 2			# neu chu so hien tai dang xet chua co trong mang A
								# thi them vao cuoi mang A va tang do dai mang A len 1 ($s0++)
		sw $t1, A($t4)
		add $s0, $s0, 1
		j loop1
end_loop1:
N_ko_co_cs_trung_nhau:			# in ra N ko co chu so giong nhau
	li $v0, 4
	la $a0, Message3
	syscall
	j exit
N_co_2cs_trung_nhau:			# in ra N co it nhat 2 chu so giong nhau
	li $v0, 4
	la $a0, Message2
	syscall
exit: