.data
	msg1:	.asciiz	"Nhap phan tu thu "
	msg2:	.asciiz " : "
	msg3:	.asciiz "Nhap so phan tu cua mang: "
	msg4:	.asciiz "So am lon nhat la "
	msg5:	.asciiz	" o vi tri thu "
	msg6:	.asciiz "Mang khong co so am"

.text
main:
		add	$t0, $0, 0	# i
		la	$a0, msg3	# in ra msg3
		li	$v0, 4	
		syscall
		li	$v0, 5
		syscall
		add	$s3, $0, -999999	#max
		add	$s1, $v0, $0	#n
		sub	$s4, $s1, 1
		add	$s5, $0, 0	# check
	f1:	beq	$t0, $s1, end_input
		la	$a0, msg1
		li	$v0, 4
		syscall
		add	$a0, $t0, 1
		li	$v0, 1
		syscall
		la	$a0, msg2
		li	$v0, 4
		syscall
		li	$v0, 5
		syscall
		sll	$s2, $t0, 2
		add	$s2, $s0, $s2
		add	$s0, $v0, $0
		slt	$a1, $s0, $0
		beq	$a1, 1, f2
		j	end_loop
	f2:	add	$s5, $0, 1	
		slt	$a1, $s3, $s0
		beq	$a1, 0, end_loop
		add	$s3, $s0, $0
		add	$t1, $t0, 1	# max_index
	end_loop:
		add	$t0, $t0, 1
		j	f1
	end_input:
		beq 	$s5, 0, end
		la	$a0, msg4
		li	$v0, 4
		syscall
		li	$v0, 1
		add	$a0, $0, $s3
		syscall
		la	$a0, msg5
		li	$v0, 4
		syscall
		li	$v0, 1
		add	$a0, $0, $t1
		syscall
		j end_all
	end:	la	$a0, msg6
		li	$v0, 4
		syscall
	end_all:

		
	