# A. So nguyen
# Cau 6

.data
	message1:	.asciiz	"Nhap canh thu nhat: a = "
	a:		.word	0
	message2:	.asciiz	"Nhap canh thu hai: b = "
	b:		.word	0
	message3:	.asciiz	"Nhap canh thu ba: c = "
	c:		.word	0
	message4:	.asciiz	"a, b, c la 3 canh cua tam giac"
	message5:	.asciiz	"a, b, c khong phai la 3 canh cua tam giac"
.text
	# Xuat message 1
	li	$v0, 4
	la	$a0, message1
	syscall
	# Nhap a
	li	$v0, 5
	syscall
	
	sw	$v0, a	# Luu a
	lw	$s1, a	# Nap a vao $s1
	
	# Xuat message 2
	li	$v0, 4
	la	$a0, message2
	syscall
	# Nhap b
	li	$v0, 5
	syscall
	
	sw	$v0, b	# Luu b
	lw	$s2, b	# Nap b vao $s2
	
	# Xuat message 3
	li	$v0, 4
	la	$a0, message3
	syscall
	# Nhap c
	li	$v0, 5
	syscall
	
	sw	$v0, c	# Luu c
	lw	$s3, c	# Nap c vao $s3
	
	slt	$t1, $zero, $s1	# t1 = 1 neu 0 < a
	slt	$t2, $zero, $s2	# t2 = 1 neu 0 < b
	slt	$t3, $zero, $s2	# t3 = 1 neu 0 < c
	
	beq	$t1, $zero, not_triangle
	beq	$t2, $zero, not_triangle
	beq	$t3, $zero, not_triangle
	
	add	$a1, $s1, $s2	# a1 = a + b
	add	$a2, $s2, $s3	# a2 = b + c
	add	$a3, $s3, $s1	# a3 = c + a
	
	slt	$t4, $s3, $a1	# t4 = 1 neu c < a+b
	slt	$t5, $s1, $a2	# t5 = 1 neu a < b+c
	slt	$t6, $s2, $a3	# t6 = 1 neu b < c+a
	
	beq	$t4, $zero, not_triangle
	beq	$t5, $zero, not_triangle
	beq	$t6, $zero, not_triangle
	
	# Print if triangle
	li	$v0, 4
	la	$a0, message4
	syscall
	li	$v0, 10
	syscall
	
	not_triangle:
		li	$v0, 4
		la	$a0, message5
		syscall
