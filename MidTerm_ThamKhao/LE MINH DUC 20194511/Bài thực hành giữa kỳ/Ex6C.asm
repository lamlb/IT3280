.data 
	input:          .space 201
	message:        .asciiz "So tu bat dau bang 'Ch' la: "
	check1:         .byte 'C'
	check2:	      .byte 'h'
.text
	main:
	        la $a0,input
	        li $a1,201          #gioi han chi duoc nhap 200 ky tu
	        li $v0,8            #do va luu vao $a0
	        syscall 
	        
		nop
		
        	jal countCh
        	
        	li $v0, 56
        	la $a0, message
        	add $a1, $t3, $zero
        	syscall
        	nop
        	
        	li $v0, 10
	syscall
	nop

	countCh:
		la $s0, input		#luu lai vao s0
		
		#Lay ra 2 ky tu C va h
        		la $s1, check1
		la $s2, check2
		
		lb $t1, 0($s1)
		lb $t2, 0($s2)
		
		li $t3, 0 # so tu bat dau bang 'Ch'
		subi $s0, $s0, 1 # tam thoi tru 1 de vong lap co the chi den ky tu dau tien
	loop:
		addi $s0, $s0, 1
		lb $t0, 0($s0)
		beq $t0, $zero, endLoop
	compareC:
		bne $t0, $t1, skip # neu ky tu dau tien ko bang vs chu C thi den skip de den tu tiep theo
	compareh:
		addi $s0, $s0, 1
		lb $t0, 0($s0)
		beq $t0, $zero, endLoop
		bne $t0, $t2, skip # neu ky tu tiep theo ko bang vs chu h thi den skip de den tu tiep theo
		addi $t3, $t3, 1
	skip:
		addi $s0, $s0, 1
		lb $t0, 0($s0)
		beq $t0, $zero, endLoop
		bne $t0, 32, skip
		j loop
	endLoop:
	endCountCh:
		jr $ra


	
	        