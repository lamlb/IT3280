.data
	A:	.word	0:100
	Message1:	.asciiz "So phan tu cua mang: "
	Error:	.asciiz "phan tu phai lon hon 0\n"
	Message2:	.asciiz "phan tu thu "
	Message3:	.asciiz " la:"
	Message4:	.asciiz "Phan tu chan nho nhat lon hon tat ca cac so le trong mang la: "
	Message5:	.asciiz " Mang khong co phan tu le"
	space:	.asciiz"\t"
.text	
main:
# Nhap So Luong Phan Tu
la $a0,Message1
li $v0,4
syscall
# Chuyen qua thanh ghi $t0
li $v0,5
syscall
move $t0,$v0
# Nhap cac phan tu cua mang
li $v0,4
la $a0,Message2
syscall
li $t1,0
la $t2,A
lap:
li $v0,5
syscall
sw $v0,($t2)
addi $t1,$t1,1
addi $t2,$t2,4
blt $t1,$t0,lap
# xu ly
li $t1,0
la $t2,A
xuly:
lw $t4,($t2)
ble $t4,$t3,tiep
# input on display
li $v0,1
move $a0,$t4
syscall
# Khoang Trang
li $v0,4
la $a0,space
syscall
tiep:
addi $t1,$t1,1
addi $t2,$t2,4
blt $t1,$t0,xuly
li $v0,10
syscall
li $v0,10
syscall
Nhap_so_phan_tu:
	li $v0,4 
	la $a0,Message1		# print	string
	syscall 
	
	li $v0,5			# read integer
	syscall
	
	add $t5,$t5,$v0		# luu so phan tu cua mang vào $t5 (n phan tu)
	slt $t9,$t5,$zero	# kiem tra n < 0 thì lenh duoi se nhay den nhan loi ($t5<0 thi $t9=1)
	bne $t9,$zero,loi	# $t9 = 0, khong co loi 
	j ketthuc			
	
loi:
	li $v0,4 
	la $a0,Error		#in chuoi
	syscall
	
	j Nhap_so_phan_tu	#nhap lai
	
ketthuc:
	li $t1,0 			# i = 0
nhap_mang:
	beq $t1,$t5,end_nhapmang # i = n thi ket thuc vong lap
	
	li $v0,4 
	la $a0,Message2		#in chuoi
	syscall 
	
	li $v0,1 
	add $a0,$t1,$zero	# in i
	syscall
	
	li $v0,4 
	la $a0,Message3		#in chuoi
	syscall
	
	li $v0,5			# nhan 1 so nguyen nhap tu ban phim
	syscall
	
	sll $t2,$t1,2		# dich trai i sang 2 bit ($t1*4 = $t2)
	sw	$v0,A($t2)		# luu gia tri so vua nhap vao A[i]
	
	addi $t1,$t1,1		# i++
	j nhap_mang
	
end_nhapmang:
	li $t9,0 	#sum
	li $t1,0 	# i=0
	la $a0,A	#load dia chi mang A ( A[0] )
	li $t8,3 
	
khaibao:
	li $s0, 10000000		#max
	add $s2, $s0, 0		# min = max
	li 	$t1, 0			# i=0
	li	$s3, 2
	j loop
loop_up:
	addi $t1,$t1,1
	
loop:
	
