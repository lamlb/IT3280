.data
message:	.asciiz	"Nhap so nguyen duong N: "
error:		.asciiz	"\nSo vua nhap khong hop le."
osum:		.asciiz	"\nTong cac chu so le: "
esum:		.asciiz	"\nTong cac chu so chan: "

.text
# Nhap so nguyen
input:
	li	$v0, 4
	la	$a0, message
	syscall			# Hien thong bao
	
	li	$v0, 5
	syscall			# Nhan so nguyen	
	move	$s0, $v0	# $s0 = N

# Kiem tra tinh hop le cua so nguyen
check:
	slt	$t0, $0, $s0	# $t0 = 1 khi va chi khi N nguyen duong
	beq	$t0, 1, prepare
	
	li	$v0, 4
	la	$a0, error
	syscall			
	j	end		# Thong bao co loi & ket thuc
		
prepare:
	li	$s1, 0		# $s1 chua tong chu so le
	li	$s2, 0		# $s2 chua tong chu so chan
	
process:	
	beq	$s0, $0, result	# Dung khi $s0 = 0
	div	$s0, $s0, 10	# Chia N cho 10 de lay chu so o phan du
	mfhi	$t0		# Chuyen du tu HI sang $t0
	
	andi	$t1, $t0, 1	# Lay bit cuoi cung cua $t0 luu vao $t1
	beq	$t1, $0, even	# Neu $t1 = 0, chu so thu duoc chan

odd:		
	add	$s1, $s1, $t0	# Neu nguoc lai, chu so thu duoc le
	j	process
	
even:
	add	$s2, $s2, $t0
	j	process

result:
	li	$v0, 4
	la	$a0, osum
	syscall
	
	li	$v0, 1
	add	$a0, $0, $s1
	syscall			# In tong cac chu so le
	
	li	$v0, 4
	la	$a0, esum
	syscall
	
	li	$v0, 1
	add	$a0, $0, $s2
	syscall			# In tong cac chu so chan
end: