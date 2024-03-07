.data
nhap1:		.asciiz			"Nhap so nguyen duong N: "
nhap2:          .asciiz                "Nhap so nguyen duong M: "
msg: 		.asciiz			"\nBoi so chung : "
tich: .asciiz "  Tich = "
.text
main:
la $a0,nhap1
add $v0,$0,4
syscall
add $v0,$0,5
syscall
add $t0,$0,$v0

la $a0,nhap2
add $v0,$0,4
syscall
add $v0,$0,5
syscall
add $t1,$0,$v0
Tich:
la  $a0, tich
add $v0,$0,4
syscall
mult $t0,$t1
mflo $t3
add $a0,$0,$t3
add $v0,$0,1
syscall
add $s2,$s2,2
FOR:
slt $t4, $t3, $s2  # $t0 = i < n?
bne $t4, $0, END   # if !(i < n) goto END
div 	$s2, $t0	# divide for N
mfhi	$t2		# get remainder
bne	$t2, 0, remake	# if remainder === 0 then print
div 	$s2, $t1	# divide for M
mfhi	$t2		# get remainder 
beq	$t2, 0, equal	# if remainder === 0 then print
remake:
addi $s2, $s2, 1   # i = i + 1
j FOR
equal:
la 	$a0, msg
li 	$v0, 4
syscall
li  $v0, 1           # service 1 is print integer
    add $a0, $s2, $zero  # load desired value into argument register $a0, using pseudo-op
    syscall
END:

