.data
msg_input: .asciiz "Nhap so phan tu cua mang: "
msg_input2: .asciiz "Nhap phan tu: "
space: .asciiz "\t"
arr: .word 0:100
.text
main:
# Nhap So Luong Phan Tu
	la $a0,msg_input
	li $v0,4
	syscall
# Chuyen qua thanh ghi $t0
	li $v0,5
	syscall
	move $t0,$v0
# Nhap cac phan tu cua mang
	li $v0,4
	la $a0,msg_input2
	syscall
	li $t1,0
	la $t2,arr
lap:
	li $v0,5
	syscall
	sw $v0,($t2)
	addi $t1,$t1,1
	addi $t2,$t2,4
	blt $t1,$t0,lap
# xu ly
	li $t1,0
	la $t2,arr
xuly:
	lw $t4,($t2)
	ble $t4,$t3,tiep
# input on display
	li $v0,1
	move $a0,$t4
	syscall	
# KHoang Trang
	li $v0,4
	la $a0,space
	syscall
tiep:
	addi $t1,$t1,1
	addi $t2,$t2,4
	blt $t1,$t0,xuly
	li $v0,10
	syscall
