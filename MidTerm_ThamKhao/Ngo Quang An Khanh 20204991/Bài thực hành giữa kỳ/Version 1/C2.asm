.data
return:		.asciiz	"\nSo ky tu khac nhau trong xau: "
tmpstr: 	.ascii
message:	.asciiz	"Nhap xau: "
string:		.asciiz

.text
# Nhap xau
input:
	li	$v0, 4
	la	$a0, message
	syscall
	
	li	$v0, 8
	la	$a0, string
	li	$a1, 100
	syscall			# Doc xau
	
prepare:
	li	$s0, 0		# $s0 luu so ky tu khac nhau
	la	$t0, string	# $t0 tro toi dia chi dang xet cua xau	
	la	$t2, tmpstr	
	addi	$t2, $t2, 1	# $t2 chua dia chi phia sau duoi cua xau luu cac ky tu khac nhau	

process:
	lb	$t3, 0($t0)	# Doc phan tu cua xau
	beq	$t3, '\n', end	# Dung khi $t3 la ky tu '\n' o cuoi xau
	la	$t1, tmpstr	# Dua $t1 tro vao dau xau luu cac ky tu khac nhau

# So sanh ky tu hien tai voi cac ky tu trong xau luu cac ky tu khac nhau	
compare:
	beq	$t1, $t2, found	# Dung vong lap khi phan tu dang xet nam ngoai xau
	
	lb	$t4, 0($t1)	# Doc phan tu tu xau luu cac ky tu khac nhau
	beq	$t3, $t4, set	# Neu phat hien trung, xet phan tu tiep theo tren xau chinh
	
	addi	$t1, $t1, 1	# Neu khong, tiep tuc so sanh
	j	compare

# Neu ky tu dang xet khong trung lap		
found:
	sb	$t3, 0($t2)	# Luu ky tu vao xau luu cac ky tu khac nhau
	addi	$t2, $t2, 1
	addi	$s0, $s0, 1	# Tang so ky tu khac nhau
	
set:
	addi	$t0, $t0, 1	# Xet ky tu tiep theo
	j	process
	
end:
	li	$v0, 4
	la	$a0, return
	syscall	
	
	li	$v0, 1
	add	$a0, $0, $s0
	syscall