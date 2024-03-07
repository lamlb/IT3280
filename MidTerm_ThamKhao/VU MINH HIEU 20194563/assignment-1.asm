# Nhập 2 số nguyên dương M và N từ bàn phím.
# In ra màn hình ước số chung lớn nhất của M và N.
.data
msg_m: .asciiz "Nhap nguyen duong M: "
msg_n: .asciiz "Nhap nguyen duong N: "
msg_out: .asciiz "Uoc chung lon nhat cua "
msg_and: .asciiz " va "
msg_is: .asciiz " la: "
.text
mInput:
 # Nhap M
 li $v0, 51
 la $a0, msg_m 
 syscall
 
 sne $t0, $a1, $zero # Ktra nhap thanh cong
 beq $t0, 1, mInput
 slti $t0, $a0, 0 # Kiem tra M > 0?
 bne $t0, $zero, mInput
 
 addi $t0, $a0, 0 # $t0 = M
 add $s0, $t0, $zero
 
nInput:
 # Nhap N
 li $v0, 51
 la $a0, msg_n 
 syscall
 
 sne $t1, $a1, $zero # Ktra nhap thanh cong
 beq $t1, 1, nInput
 slti $t1, $a0, 0 # Kiem tra N > 0?
 bne $t1, $zero, nInput
 
 addi $t1, $a0, 0 # $t1 = N
 add $s1, $t1, $zero
 
loop: 
 seq $t2, $t0, $t1
 beq $t2, 1, print
 sgt $t2, $t0, $t1 # $t2=1 neu M>N
 beq $t2, 1, MgtN
 slt $t2, $t0, $t1 # $t2=1 neu N<M
 beq $t2, 1, NgtM 
MgtN:
 sub $t2, $t0, $t1 # M->M-N
 add $t0, $t2, $zero
 j loop
NgtM:
 sub $t2, $t1, $t0 # N->N-M
 add $t1, $t2, $zero
 j loop
 
print:
 # In "Uoc chung lon nhat cua "
 la $a0, msg_out
 li $v0, 4
 syscall
 
 # In M
 la $a0, ($s0)
 li $v0, 1
 syscall
 
 # In " va "
 la $a0, msg_and
 li $v0, 4
 syscall
 
 # In N
 la $a0, ($s1)
 li $v0, 1
 syscall
 
 # In "la "
 la $a0, msg_is
 li $v0, 4
 syscall
 
 # In ket qua
 la $a0, ($t0)
 li $v0, 1
 syscall

 #Thoat chuong trinh
 li $v0, 10
 syscall
