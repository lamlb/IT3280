# 5. Nhập số nguyên dương N,
# in ra màn hình tổng các chữ số là số lẻ 
# và tổng các chữ số là số chẵn của N.
.data
	Message1: .asciiz "Tong chan: "
	Message2: .asciiz "\nTong le: "
.text
li $v0, 5 #nhap so nguyen N
syscall

add $s1, $0, $0 # Tong chan = 0
add $s2, $0, $0 # Tong le = 0
add $s0, $0, $v0 # dat $s0 = N
addi $t0, $0, 10 # $t0 = 10 
addi $t3, $0, 2 # $t3 = 2
while:	beqz $s0, print #$s0 = 0 thi j check 3
	nop
	div $s0, $t0 # lay $s0 chia cho 10 
	mflo $s0 # chuyen phan thuong vao $s0 
	mfhi $t1 # chuyen phan du vao $t1
	div $t1, $t3 # $t1/2
	mfhi $t4 # chuyen phan du vao $t4
	j check1
	nop
check1:
	beqz $t4, TongChan # neu phan du $t4 = 0 thi jumb tong chan 
	nop
	add $s2, $s2, $t1 # else cong $t1 vao tong le
	j while
	nop
TongChan:  
	add $s1, $s1, $t1
	j while
	nop
print: 
	# in ra dong Tong chan
	li $v0, 4 
	la $a0, Message1
	syscall
	
	#in ra gia tri tong chan
	move $a0, $s1
	li $v0, 1
	syscall
	
	#in ra dong Tong le
	li $v0, 4 
	la $a0, Message2
	syscall
	
	#in ra gia tri tong le
	move $a0, $s2
	li $v0, 1
	syscall
done: