.data
str1: .asciiz "Nhap So Luong Phan Tu Mang: "
str2: .asciiz "Nhap Phan Tu: "
space: .asciiz " "
str3: .asciiz "Cap phan tu lien ke co tich nho nhat la: "
arr: .word 0:100

.text
# Input so phan tu 
	li $v0, 4
	la $a0, str1
	syscall

	li $v0, 5
	syscall
	move $t0, $v0	#n
	
#Input cac phan tu
	li $t1,0	#$t1 = i
	la $t2, arr
	
	li $v0, 4
	la $a0, str2
	syscall
	
Input:	
 	li $v0, 5
 	syscall
 	sw $v0, 0($t2)
 	addi $t1 ,$t1 ,1
 	addi $t2 ,$t2 ,4
 	beq $t1, $t0, Main	#i = n -> bat dau thuc hien
 	j Input

Main:	
 	la $t2 ,arr
 	li $t1 ,0
 	lw $s1 ,0($t2)	#$s1 = A[0]
 	lw $s2 ,4($t2)	#$s2 = A[1]
 	mul $t3 ,$s1 ,$s2	#$t3 = A[0]*A[1]
 	addi $t2 ,$t2, 4	#tang dia chi cua t2 sang thanh ghi tiep theo
 	addi $t1 ,$t1 ,1	#i = 1
 	move $s4 ,$s1	#$s4 = A[0]
 	move $s5 ,$s2	#$s5 = A[1]
 	
Loop:	#i = 1
 	lw $s1 ,0($t2)	#$s1 = A[i]
 	lw $s2 ,4($t2)	#$s2 = A[i+1]
 	mul $t4 ,$s1 ,$s2	#$t4 = A[i]*A[i+1]
 	addi $t2 ,$t2, 4	#tang dia chi cua t2 sang thanh ghi tiep theo
 	addi $t1 ,$t1 ,1	#i=i+1
 	
 	slt $s3 , $t4 , $t3	#tich moi > tich cu -> Loop
 	beq $t1 ,$t0 ,print	#i = n -> ket thuc Loop
 	beq $s3 , 0 , Loop
 	move $s4 ,$s1	#$s4 = A[i]
 	move $s5 ,$s2	#$s5 = A[i+1]
 	addi $t3 ,$t4 ,0	#Gan $t3 sang tich moi vua tinh duoc 
 	j Loop
 
print:
	li $v0, 4
	la $a0, str3
	syscall
 	
 	li $v0, 1
	addi $a0, $s4, 0
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	li $v0, 1
	addi $a0, $s5, 0
	syscall

End:
