.data 
	input:    .space 101
	message: .asciiz "So tu bat dau bang 'Ch' la: "
	ktra_C:  .byte 'C'
	ktra_h:	.byte 'h'
.text
	main:
	        la $a0,input       # g�n $a0 l� m?ng input
	        li $a1,101          #gi?i h?n ph?n t? c?a m?ng
	        li $v0,8            #g�n $v0=8 b?t ??u m?ng 
	        syscall 	    # nh?p m?ng c?n ki?m tra
		nop
        	jal ktra_Ch         # l?u v�o thanh ghi $ra r?i nh?y ??n linh ktra_Ch
        	li $v0, 56          
        	la $a0, message   
        	add $a1, $t3, $zero	# g�n $a1=$t3 l� s? ph?n t? Ch 
        	syscall			# in ra m�n h�nh
        	nop
        	li $v0, 10      
	        syscall
	        nop
	ktra_Ch:
		la $s0, input		# g�n $s0 ch? v�o m?ng
        	la $s1, ktra_C          # $s1 ch? ??n link Ktra_C
		la $s2, ktra_h		# $s2 ch? ??n linh ktra_h
		lb $t1, 0($s1)          # g�n $t1 l� 'C' 
		lb $t2, 0($s2)          # g�n $t2 l� 'h' 
		li $t3, 0               # $t3=0
		subi $s0, $s0, 1 	#$s0=$s0-1  
	loop:
		addi $s0, $s0, 1       	#$s0=s0+1
		lb $t0, 0($s0)		#g�n t0 l� ph?n t? ??u ti�n c?a m?ng
		beq $t0, $zero, endLoop # n?u $t0=0 th� nh?y ??n endloop
	sosanh_C:
		bne $t0, $t1, dung 	# n?u $t0 kh�c C th� s? nh?y d?ng
	sosanh_h:
		addi $s0, $s0, 1	# ??n ph?n t? ti?p sau 
		lb $t0, 0($s0)		# $t0 mang ??a ch? c?a $s0
		beq $t0, $zero, endLoop	# n?u $t0 =0 th� d?ng
		bne $t0, $t2, dung 	# ki?m tra n?u $t0 l� h , n?u kh�ng nh?y ??n d?ng
		addi $t3, $t3, 1	# n?u c? t?n t?i C v� h $t3 s? c?ng th�m 1
	dung:
		addi $s0, $s0, 1	# nh?y ??n ph?n t? ti?p theo trong chu?i 
		lb $t0, 0($s0)		
		beq $t0, $zero, endLoop # n?u $t0 =0 th� nh?y ??n endloop
		bne $t0, 32, dung	# n�u $t0 kh�c 32 l� kho?ng tr?ng th� ch?y quay l?i link d?ng
		j loop			# n?u kh�ng ph?i kho?ng tr?ng th� ch?y quay l?i l?nh loop
	endLoop:
	dungktra_Ch:
		jr $ra


	
	        
