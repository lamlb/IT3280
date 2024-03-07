.data
msg_input: .asciiz "Nhap Vao So cac chu so: "
msg_output: .asciiz "tong cac chu so le : "
msg_input2: .asciiz "Nhap Vao Phan Tu: "
msg_output3: .asciiz "   tong cac chu so chan : "
int_array: .word 0:100
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
la $a0,msg_input2
li $v0,4
syscall

xor $t1,$t1,$t1
la $t2,int_array

loop_input:
li $v0,5
syscall

sw $v0,($t2)
addi $t1,$t1,1
addi $t2,$t2,4
blt $t1,$t0,loop_input


# Tinh tong cac chu so le

xor $t1,$t1,$t1
la $t2,int_array
li $t4,0
li $t5,2

loop_tong:
lw $t3,($t2)
div $t3,$t5
mfhi $t6
beqz $t6,end_if
add $t4,$t4,$t3

end_if:
addi $t1,$t1,1
addi $t2,$t2,4

blt $t1,$t0,loop_tong
la $a0,msg_output
li $v0,4
syscall

move $a0,$t4
li $v0,1
syscall

#li $v0,10
#syscall
 
#tinh tong cac chu so chan
xor $t1,$t1,$t1
la $t2,int_array
li $t4,0
li $t5,2
li $a2,1
loop_tong1:
lw $t3,($t2)
div $t3,$t5
mfhi $t6
beq $t6,$a2 ,end_if1
add $t4,$t4,$t3

end_if1:
addi $t1,$t1,1
addi $t2,$t2,4

blt $t1,$t0,loop_tong1
la $a0,msg_output3
li $v0,4
syscall

move $a0,$t4
li $v0,1
syscall

li $v0,10
syscall