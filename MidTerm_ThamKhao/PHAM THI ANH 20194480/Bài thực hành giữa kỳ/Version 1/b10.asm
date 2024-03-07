#10. Nh?p m?ng s? nguyên t? bàn phím. In ra màn hình s? l? l?n nh?t nh? h?n m?i s? ch?n trong m?ng

.data
	A:word	0:100
	mess1:.asciiz "So phan tu cua mang: "
	error:.asciiz "phan tu phai lon hon 0\n"
	mess2:.asciiz "phan tu thu "
	mess3:.asciiz " la:"
	mess4:.asciiz "Phan tu le lon nhat nho hon tat ca cac so chan trong mang la: "
	mess5:.asciiz " Mang khong co phan tu chan"
.text	
	Nhap_so_phan_tu:
	li $v0,4 
	la $a0,mess1		# print	string
	syscall 
	
	li $v0,5			# read integer
	syscall
	
	add $t5,$t5,$v0		# luu so phan tu cua mang vào $t5 (n phan tu)
	slt $t9,$t5,$zero	# kiem tra n < 0 thì lenh duoi se nhay den nhan loi ($t5<0 thi $t9=1)
	bne $t9,$zero,loi	# $t9 = 0, khong co loi 
	j ketthuc			
	
loi:
	li $v0,4 
	la $a0,error		#in chuoi
	syscall
	
	j Nhap_so_phan_tu	#nhap lai
	
ketthuc:
	li $t1,0 			# i = 0
nhap_mang:
	beq $t1,$t5,end_nhapmang # i = n thi ket thuc vong lap
	
	li $v0,4 
	la $a0,mess2		#in chuoi
	syscall 
	
	li $v0,1 
	add $a0,$t1,$zero	# in i
	syscall
	
	li $v0,4 
	la $a0,mess3		#in chuoi
	syscall
	
	li $v0,5			# nhan 1 so nguyen nhap tu ban phim
	syscall
	
	sll $t2,$t1,2		# dich trai i sang 2 bit ($t1*4 = $t2)
	sw	$v0,A($t2)		# luu gia tri so vua nhap vao A[i]
	
	addi $t1,$t1,1		# i++
	j nhap_mang
	
end_nhapmang:
	la $a0,A	#load dia chi mang A ( A[0] )
	
khaibao:
	li $s0, 10000000		#max
	add $s2, $s0, 0		# min = max
	li 	$t1, 0			# i=0
	li	$s3, 2
	j loop
	
loop_up:
	addi $t1,$t1,1
	
loop:
	beq $t1,$t5,if	# i=n => endloop
	sll $t2,$t1,2			# $t2 = i*4
	add $t3,$t2,$a0			# lay dia chi A[i] luu vao $t3
	lw 	$t2,0($t3)			# lay gia tri A[i] luu vao $t2
	blt $s2, $t2, loop_up 	# nhay neu min < A[i]
	div $t2, $s3			#A[i] / 2
	mfhi $v1 				#lay du
	bne $v1, $zero, loop_up		# du khac khong thi nhay
	add $s2, $t2, 0			# min = A[i]
	j loop_up
if: 
	beq $s2, $s0,else 
	add $s4, $s2, -1		# return min - 1
	j main
else:
	li $v0,4 
	la $a0,mess5		# print	string
	syscall
	j end
	
main:
	li $v0,4 
	la $a0,mess4		# print	string
	syscall
	
	li $v0,1 
	add $a0,$s4,$zero	# in so
	syscall
	
end:
