.data
Input1: .asciiz "Nhap vao kich thuoc mang: "
Input2: .asciiz "Nhap danh sach cac phan tu (Nhap enter giua cac phan tu): "
space: .asciiz "\t"
message_solved: .asciiz "So chan nho nhat lon hon moi so le la: "
message_fail: .asciiz "Khong ton tai!"
arr: .word 0:100

.text
# Nhap so luong phan tu 
	li $v0, 4
	la $a0, Input1
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
# Nhap du lieu vao mang
	li $t1,0
	la $t2, arr
	
	li $v0, 4
	la $a0, Input2
	syscall
 nhap_mang:	
 	li $v0, 5
 	syscall
 	sw $v0, 0($t2)
 	addi $t1 ,$t1 ,1
 	addi $t2 ,$t2 ,4
 	
 	beq $t1, $t0, main
 	j nhap_mang
 	
 	
 main:	
 	la $t2, arr
 	li $t1, -1
 	addi $t2 ,$t2 ,-4
 	li $s2 ,0	# s2 la so le lon nhat
 	

 max_le:
 	addi $t2 ,$t2 ,4
 	addi $t1 ,$t1 ,1
 	beq $t1 ,$t0 ,remain
 	lw $s0 , ($t2)
 	andi $s1 ,$s0 ,1 	#Kiem tra so la so le hay chan
 	beq $s1 ,0 , max_le 	#Neu la chan thi bo qua
 	slt $t3 ,$s2 ,$s0 	#So sanh voi s2
 	beq $t3 ,0 ,max_le 	
 	addi $s2 ,$s0, 0 	#s2 = so le lon hon
 	j max_le
 	
remain:
 	la $t2, arr
 	li $t1, -1
 	addi $t2 ,$t2 ,-4
 	li $s3 ,1
 
min_chan:
 	addi $t2 ,$t2 ,4
 	addi $t1 ,$t1 ,1
 	beq $t1 ,$t0 ,success
 	lw $s0 , ($t2)
 	andi $s1 ,$s0 ,1 	#kiem tra so chan hay le
 	beq $s1 ,1 , min_chan 	
 	
 	slt $t3 ,$s2 ,$s0 	#so sanh voi so le lon nhat
 	beq $t3 ,0 ,min_chan 	#Neu sai quay lai vong lap
 				#Neu dung thi...
 	beq $s3 ,1 ,gan
 	slt $t3 ,$s0 ,$s3 	# Xet s0 < minchan 
 	beq $t3 ,0 ,min_chan 	
 gan:	addi $s3 ,$s0, 0 	
 	
	j min_chan

success:
  	beq $s3 ,1 ,fail
  	li $v0, 4
	la $a0, message_solved
	syscall 
 	
 	li $v0, 1
	addi $a0, $s3, 0
	syscall
	
	la $t3, space
	
	li $v0, 4
	addi $a0, $t3, 0
	syscall
 	
 	j end
fail:
 	li $v0, 4
	la $a0, message_fail
	syscall 
 	
end:		
 	
 	

 	
