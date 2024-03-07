.data
msgInput: .asciiz "Nhap so N(N >= 10): "
msgOutput: .asciiz "Output: "
N: .word 0
max: .word 0


.text
input:
la $s7, N	#load N address
lw $t7, 0($s7)	#load value N into $t7
la $s5, max	#load max address
lw $t5, 0($s5)	#loas value of max into $t5
li $v0, 4	#Print message msgInput
la $a0, msgInput
syscall
li $v0, 5	#Input of number N from user
syscall	
add $t7, $zero, $v0	
add $a0, $zero, $t7	#input of funtion findMax $a0 = N = $t7
jal findMax	#jump to funtion findMax
nop

li $v0, 4
la $a0, msgOutput
li $v0, 1 # service 1 is print integer
add $a0, $zero, $t5 # the interger to be printed is $t5
syscall
li $v0, 17 # exit
li $a0, 3 # with error code = 3
syscall
#Chuong trinh con tim chu so lon nhat cua so $s0 = para[in]
#Khong tra ve gia tr?, ch? s? l?n nh?t c?a $a0 ???c l?u ngay vào bi?n max
findMax :
add $t0, $zero, 10 #$t0 = 10
while:
beqz $a0, end_while 	#Neu $a0 = 0, ket thuc while
nop
div $a0, $t0		#lo = $a0 / 10, hi = $a0 % 10
mfhi $s0		#$s0 = hi
mflo $a0		#$a0 = lo
slt $t1, $t5, $s0	#Neu max < $s0?
beqz $t1, while		#Neu khong thi quay lai vong lap
nop
add $t5, $zero, $s0	#Neu co thi max = $s0
j while
nop
end_while:
jr $ra	#jump to $ra address
nop



