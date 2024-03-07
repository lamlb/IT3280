.data 
	input:   .space 201
	string:  .asciiz "So tu trong xau bat dau bang 'Ch' la: "
	check1:  .byte 'C'
	check2:	 .byte 'h'
.text
	main:
	        la $a0,input
	        li $a1,201  #Gioi han chi duoc nhap 200 ky tu
	        li $v0,8    #Do va luu vao $a0
	        syscall 
		nop
		
        	jal coutCh  #jump and link
        	
        	li $v0, 56
        	la $a0, string
        	add $a1, $t3, $zero #Gan t3 = a1
        	syscall
        	nop
        	
        	li $v0, 10
	        syscall
	        nop

	coutCh:
		la $s0, input #Luu lai vao s0
	
	#Lay ra 2 ky tu C va h
        	la $s1, check1
		la $s2, check2
		
		lb $t1, 0($s1)
		lb $t2, 0($s2)
		
		li $t3, 0 # So tu bat dau bang 'Ch'
		subi $s0, $s0, 1 # Tam thoi tru 1 de vong lap co the chi den ky tu dau tien
	loop:
		addi $s0, $s0, 1
		lb $t0, 0($s0)
		beq $t0, $zero, endLoop
	compareC:
		bne $t0, $t1, skip # Neu ky tu dau tien khong bang voi ky tu 'C' thi nhay den skip de den tu tiep theo
	compareh:
		addi $s0, $s0, 1
		lb $t0, 0($s0)
		beq $t0, $zero, endLoop
		bne $t0, $t2, skip # Neu ky tu tiep theo khong bang voi ky tu 'h' thi nhay den skip de den tu tiep theo
		addi $t3, $t3, 1
	skip:
		addi $s0, $s0, 1
		lb $t0, 0($s0)
		beq $t0, $zero, endLoop
		bne $t0, 32, skip
		j loop	
	endLoop:
	endCoutCh:
		jr $ra


	
	        
