.data
	arr: .word 100
	Message: .asciiz "Ket qua can tim la:"
.text
main:
input:
	li	$v0, 5
	syscall
	addi	$a0, $v0, 0	#Nhap so phan tu trong mang ->$a0
	li	$t0, 0		#Khoi tao i=0
	la	$a1, arr	#Dia chi arr[0]
	la	$a2, arr	#Su dung trong CT con 'read'
read:
	li	$v0, 5		#Doc phan tu mang thu i
	syscall
	sw	$v0, 0($a2)	#Luu vao arr[i]
	addi	$t0, $t0, 1
	addi	$a2, $a2, 4
	blt	$t0, $a0, read
	nop

	jal	min_chan
	nop
	
exit:
	li	$v0, 10		#exit
	syscall
end_main:

min_chan:
	li	$t0, 0		#Khoi tao i=0 truoc khi vao vong lap
	li	$k0, 2		#Chuan bi cho phep chia cho 2
	li	$s0, 100	#Khoi tao so chan nho nhat trong mang
	la	$a2, arr	#Dia chi cua arr[0]
loop:
	lw	$v0, 0($a2)	#Lay gia tri arr[i]
	divu	$v0, $k0	#Thuc hien phep chia 2 de xet tinh chan le
	mfhi	$t1		#So du luu tai thanh ghi hi
	beqz	$t1, min	#Neu arr[i] la so chan thi xet min
	nop
	j	cont		
	nop
min:
	slt	$t2, $v0, $s0	#Neu arr[i] < min_tam_thoi thi
	bnez	$t2, update	#Doi min moi
	nop
	j	cont
	nop
update:
	addi	$s0, $v0, 0	#Gan min bang gia tri moi arr[i]
cont:				#Dieu kien de vong lap tiep tuc lap
	addi	$t0, $t0, 1	#i=i+1
	addi	$a2, $a2, 4	#dia chi arr[i+1]=dia chi cua arr[i]+4
	beq	$t0, $a0, max_le	#Sau khi tim xong so chan nho nhat trong mang thi bat dau tim so le lon nhat nho hon so chan nho nhat trong mang
	nop
	j	loop
	nop
max_le:
	li	$t0, 0		#Khoi tao i=0 truoc khi vao vong lap
	li	$k0, 2		#Chuan bi cho phep chia cho 2 de xet tinh chan le
	li	$s1, -99	#Khoi tao so le lon nhat can tim 
loop2:
	lw	$v0, 0($a1)	#Lay gia tri arr[i]
	divu	$v0, $k0	#Thuc hien chia 2 xet tinh chan le
	mfhi	$t1		#SO du luu o thanh ghi hi
	bnez	$t1, max	#Neu arr[i] la so le thi xet max
	nop
	j	cont2
	nop
max:
	slt	$t2, $s1, $v0	#if arr[i]>max_le
	slt	$t3, $v0, $s0	#and arr[i]<min_chan
	and	$t4, $t2, $t3
	bnez	$t4, update2	#then update max_le moi
	nop
	j	cont2
	nop
update2:
	addi	$s1, $v0, 0			
cont2:				#Dieu kien tiep tuc thuc hien vonng lap
	addi	$t0, $t0, 1
	addi	$a1, $a1, 4
	beq	$t0, $a0, print
	nop
	j	loop2
	nop
print:	
	li	$v0, 4		#In string output
	la	$a0, Message
	syscall
	li	$v0, 1		
	add	$a0, $s1, $zero	#In ket qua
	syscall
	
	jr 	$ra		#Tro ve main
	nop
	
	
