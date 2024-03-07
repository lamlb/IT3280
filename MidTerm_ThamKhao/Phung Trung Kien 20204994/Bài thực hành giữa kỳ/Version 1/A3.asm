.data
msg: 		.asciiz 	"Nhap so:"
tontai:		.asciiz		"Chu so do la: "
khongtontai:	.asciiz		"Khong ton tai chu so lap lai 2 lan"
.text	
main:
	li	$v0, 51		
	la	$a0, msg	# In ra msg va cho so nhap vao a0
	syscall
	addi	$t0, $a0, 0		# t0 = a0 + 0
	li	$a1, 10			# a1 = 10
	f1:	# !!! ham f1 su dung de quy la f2 de duyet tat ca cac truong hop
		beqz	$t0, no		# Neu t0 == 0 thi thoat
		div 	$t0, $a1		# Lay t0 / 10
		mflo 	$t0 			# Lay thuong (bo di hang don vi)
		mfhi 	$t1 			# So du khi chia 10
		li	$t3, 0			# t3 = 0
		addi	$s1, $t0, 0		# s1 = t0
		f2:
			beqz	$s1, f1		# Neu s1 == 0 thi thoat
			div	$s1, $a1	# Lay s1 / 10
			mflo	$s1		# Lay thuong (bo di hang don vi)
			mfhi	$s2		# So du khi chia 10
			beq	$s2, $t1, yes	# If s2 == s1 => thoat
			j	f2		# Neu khong thi tiep tuc de quy
		
yes:
	li	$v0, 56
	la	$a0, tontai
	addi 	$a1, $s2, 0
	syscall
	j	end
no:
	li	$v0, 55
	la	$a0, khongtontai
	syscall
end:
