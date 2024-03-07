.data 
	input:    .space 101
	message: .asciiz "So tu bat dau bang 'Ch' la: "
	ktra_C:  .byte 'C'
	ktra_h:	.byte 'h'
.text
	main:
	        la $a0,input       # gán $a0 là m?ng input
	        li $a1,101          #gi?i h?n ph?n t? c?a m?ng
	        li $v0,8            #gán $v0=8 b?t ??u m?ng 
	        syscall 	    # nh?p m?ng c?n ki?m tra
		nop
        	jal ktra_Ch         # l?u vào thanh ghi $ra r?i nh?y ??n linh ktra_Ch
        	li $v0, 56          
        	la $a0, message   
        	add $a1, $t3, $zero	# gán $a1=$t3 là s? ph?n t? Ch 
        	syscall			# in ra màn hình
        	nop
        	li $v0, 10      
	        syscall
	        nop
	ktra_Ch:
		la $s0, input		# gán $s0 ch? vào m?ng
        	la $s1, ktra_C          # $s1 ch? ??n link Ktra_C
		la $s2, ktra_h		# $s2 ch? ??n linh ktra_h
		lb $t1, 0($s1)          # gán $t1 là 'C' 
		lb $t2, 0($s2)          # gán $t2 là 'h' 
		li $t3, 0               # $t3=0
		subi $s0, $s0, 1 	#$s0=$s0-1  
	loop:
		addi $s0, $s0, 1       	#$s0=s0+1
		lb $t0, 0($s0)		#gán t0 là ph?n t? ??u tiên c?a m?ng
		beq $t0, $zero, endLoop # n?u $t0=0 thì nh?y ??n endloop
	sosanh_C:
		bne $t0, $t1, dung 	# n?u $t0 khác C thì s? nh?y d?ng
	sosanh_h:
		addi $s0, $s0, 1	# ??n ph?n t? ti?p sau 
		lb $t0, 0($s0)		# $t0 mang ??a ch? c?a $s0
		beq $t0, $zero, endLoop	# n?u $t0 =0 thì d?ng
		bne $t0, $t2, dung 	# ki?m tra n?u $t0 là h , n?u không nh?y ??n d?ng
		addi $t3, $t3, 1	# n?u c? t?n t?i C và h $t3 s? c?ng thêm 1
	dung:
		addi $s0, $s0, 1	# nh?y ??n ph?n t? ti?p theo trong chu?i 
		lb $t0, 0($s0)		
		beq $t0, $zero, endLoop # n?u $t0 =0 thì nh?y ??n endloop
		bne $t0, 32, dung	# nêu $t0 khác 32 là kho?ng tr?ng thì ch?y quay l?i link d?ng
		j loop			# n?u không ph?i kho?ng tr?ng thì ch?y quay l?i l?nh loop
	endLoop:
	dungktra_Ch:
		jr $ra


	
	        
