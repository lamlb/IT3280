.data
array:		.word
message1:	.asciiz	"Nhap so phan tu cua mang: "
error1:		.asciiz	"\nSo vua nhap khong hop le."
message2:	.asciiz	"Nhap mang: "
error2:		.asciiz	"\nKhong ton tai phan tu thoa man."
result1:	.asciiz	"\nVi tri phan tu am lon nhat cua mang: "
result2:	.asciiz	"\nGia tri phan tu: "

.text
# Nhap so phan tu
input_num:
	li	$v0, 4
	la	$a0, message1
	syscall			# Hien thong bao
	
	li	$v0, 5
	syscall			# Nhan so phan tu	
	move	$s0, $v0	# $s0 = N
	
# Kiem tra tinh hop le cua so phan tu
check:
	slt	$t0, $0, $s0	# $t0 = 1 khi va chi khi N nguyen duong
	beq	$t0, 1, input_array
	
	li	$v0, 4
	la	$a0, error1
	syscall			
	j	end		# Thong bao co loi & ket thuc
	
# Nhap mang
input_array:
	li	$v0, 4
	la	$a0, message2
	syscall			# Hien thong bao
	
	add	$t0, $0, $s0	# $t0 tam thoi chua gia tri cua N
	la	$t1, array	# $t1 chua dia chi dau cua mang
	
input_loop:
	beq	$t0, $0, prep	# Dung doc khi $t0 = 0	
	li	$v0, 5
	syscall
	move	$t2, $v0
	sw	$t2, 0($t1)	# Doc va luu phan tu
	addi	$t1, $t1, 4	# Con tro toi dia chi tiep theo
	addi	$t0, $t0, -1	
	j	input_loop

prep:
	li	$s1, 0		# $s1 luu vi tri cua phan tu thoa man
	li	$s2, 0		# $s2 luu gia tri cua phan tu thoa man
	la	$t1, array	# $t1 chua dia chi dau cua mang
	li	$t2, 1		# $t2 tro vao vi tri hien tai dang xet o mang 

process:
	beq	$s0, $0, result	# Dung khi $s0 = 0
	lw	$t0, 0($t1)	# Lay phan tu cua mang tu bo nho
	
	slt	$t3, $t0, $0	# $t3 = 1 khi va chi khi $t0 < 0
	beq	$t3, $0, set

	beq	$s2, $0, change	# Neu $s2 = 0, dua $s2 = $t0	
	
	slt	$t3, $s2, $t0	# $s3 = 1 khi va chi khi $s2 < $t0
	beq	$t3, $0, set

change:
	add	$s2, $0, $t0
	add	$s1, $0, $t2	# Vi tri va gia tri moi
	
set:
	addi	$t1, $t1, 4	
	addi	$t2, $t2, 1
	addi	$s0, $s0, -1	# Thay doi bo dem, vi tri va dia chi sang phan tu tiep theo
	
	j	process

result:
	beq	$s2, 0, no_sol	# Thong bao khi khong co phan tu thoa man
	
	li	$v0, 4
	la	$a0, result1
	syscall
	
	li	$v0, 1
	add	$a0, $0, $s1
	syscall
		
	li	$v0, 4
	la	$a0, result2
	syscall
	
	li	$v0, 1
	add	$a0, $0, $s2
	syscall			# In vi tri va gia tri cua phan tu can tim
	j	end
	
no_sol:
	li	$v0, 4
	la	$a0, error2
	syscall
		
end: