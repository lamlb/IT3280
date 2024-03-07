.data
Message: 	.asciiz 	"Input value:"
Error:		.asciiz		"Input error!"
Success:	.asciiz		"Co cap so trung va 1 trong so do la so: "
Failure:	.asciiz		"Value not found!"
.text	
	li	$v0, 51			# Get number
	la	$a0, Message
	syscall
	
	add	$s0, $a0, $zero		# Store value at $s0
	
	slt	$t1, $zero, $s0	
	beq	$t1, $zero, error 	# If $s0 is negative then show error message
	
	
	li	$a1, 10			# We'll divide by 10 so load it first to a1
	li	$t2, 9			# We'll divide by 9 to check whether it has more than 2 characters
	div 	$s0, $a1		# Divide by 10
	mflo 	$t1 			# quotient to $s0 (so chia)
	beqz	$t1, error		# If number inputted has less than 2 character than error and exit
	
	j	loop

error:
	li	$v0, 55
	la	$a0, Error
	syscall

	j	end
	
	
loop:
	beqz	$s0, no_end		# end loop if quotient equals to 0
	
	div 	$s0, $a1		# Divide by 10
	mfhi 	$a2 			# remainder to $a2 (so du)
	mflo 	$s0 			# quotient to $s0 (so chia)
	
	li	$t3, 0			# Index for 2nd loop
	add	$s1, $s0, $zero		# quotient store in $s1
	j	loop_2
	
loop_2:
	beqz	$s1, loop		# end loop if quotient equals to 0
	div	$s1, $a1		# divide quotient $s1 by 10
	mfhi	$s2			# Remainder to $s2
	mflo	$s1			# Quotient to $s1
	beq	$s2, $a2, yes_end	# If encountered, end loop
	j	loop_2			# If not, keep on looping
	
	
# If found value, print out with one of the character that is valid		
yes_end:
	li	$v0, 56
	la	$a0, Success
	add 	$a1, $s2, $zero
	syscall
	j	end

# If not, print out failure
no_end:
	li	$v0, 55
	la	$a0, Failure
	syscall

# End program
end:
	li	$v0, 10
	syscall
