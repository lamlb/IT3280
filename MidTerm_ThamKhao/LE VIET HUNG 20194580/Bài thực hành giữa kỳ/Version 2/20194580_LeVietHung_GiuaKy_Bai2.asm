
.data
space:	.asciiz " "		# a space string.
line:	.asciiz	"\n"		# a newline string.
colonsp:	.asciiz ": "	# a colon string with space.
array:	.word	0 : 1000	# an array of word, for storing values.
size:	.word	5	# actual count of the elements in the array.
param_info_string:	.asciiz	"Input number of array (0 < N < 1000): "
receive_values_loop_info_string:	.asciiz	"Input each value: \n"
receive_values_loop_iter_string:	.asciiz	"Input value #"
sorted_array_string:	.asciiz "Sorted:"

.text

la $s6, array		#s6 = $array[0]
li $v0, 4
la $a0, param_info_string
syscall
li $v0, 5		#read N
syscall

addi $s5, $s6, 0	#s5 = $A[0]

addi $s0, $v0, 0 	#s0 = N
addi $t1, $zero 0	#i = 0

#mul $s1, $s0, 4		#s1 = 4 * N
#sub $sp, $sp, $s1	#Khoi tao bo nho stack 4 * n byte
li $v0, 4
la $a0, receive_values_loop_info_string
syscall

loop_scan:
slt $t0, $t1, $s0	#if ( i < N)
beq $t0, $zero, end_loop_scan
nop
li $v0, 4
la $a0, receive_values_loop_iter_string
syscall

li $v0, 1
add $a0, $t1, 1
syscall

print_colonsp:
li $v0, 11		#print character
li $a0, ' '
syscall

li $v0, 5		#read int
syscall	
sw $v0, 0($s5)		#s5[i] = v0

addi $t1, $t1, 1	#i++
addi $s5, $s5, 4	#s5 = &A[i]

j loop_scan
nop

end_loop_scan:

main:

addi $a0, $s6, 0	#a0 = $a[0]
addi $a1, $s0, 0	#s1 = N
jal sort
nop
addi $t1, $zero, 0	#i = 0
addi $s5, $s6, 0	#s5 = s6 = &A[0]

loop_print:

slt $t0, $t1, $s0	#if ( i < N)
beq $t0, $zero, end_loop_print
nop
li $v0, 1		#Print int
lw $a0, 0($s5)		#a0 = A[i]
syscall

li $v0, 11		#print char
li $a0, ' '
syscall

addi $t1, $t1, 1
addi $s5, $s5, 4

j loop_print
nop

end_loop_print:
end_main:

j exit
nop

swap:
 sw $s0, 0($t9)		#A[j] = A[j]
 sw $s1, 0($t8)		#A[i] = A[j]
 jr $ra
 nop		#Quay lai vong lap
 
sort:

addi $sp, $sp, -8 	#Khoi tao vung nho
sw $ra, 4($sp)		#Luu $ra vao stack
sw $s0, 0($sp)		#Luu $s0 vao stack


addi $t1, $zero, 0	#i = 0
addi $t2, $zero, 0	#j = 0
addi $t8, $a0, 0	#$t8 = $A[0]

loop_i:
slt $t0, $t1, $a1	#if( i < N)
beq $t0, $zero, end_loop_i
nop

lw $s0, 0($t8)		#s0 = A[i]
bltz $s0, continue_i	#if A[i] < 0 
nop

addi $t2, $t1, 1	#j = i + 1
addi $t9, $t8, 4	#v1 = A[i + 1] = A[j]

loop_j:

slt $t0, $t2, $a1	#if j < n
beq $t0, $zero, end_loop_j
nop

lw $s1, 0($t9)		#s1 = A[j]
bltz $s1 , continue_j	#if s1 < 0
nop	

slt $t0, $s0, $s1	#if A[i] > A[j]
beq $t0, $zero, continue_j
nop
jal swap
nop

continue_j:
addi $t2, $t2, 1	#j++
addi $t9, $t9, 4	#t9 = &A[j]
lw $s0, 0($t8)		#s0 = A[i]
j loop_j
nop

end_loop_j:
continue_i:
addi $t1, $t1, 1
addi $t8, $t8, 4
j loop_i
nop

end_loop_i:
lw $s0, 0($sp)
lw $ra, 4($sp)
jr $ra
nop
end_sort:
exit:
