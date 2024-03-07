.text
main:
	addi		$t1, $0, 10		#min = 10
	addi		$v0, $0, 5		#scan n=?
	syscall
	add		$s0, $v0, $0	#n = ?
	addi		$a0, $0, 10
	div		$s0, $a0
	mflo		$a0
	ble		$a0, $0, end_main	#Exit if n < 10
while:	addi	$a0, $0, 10		#while(
	div		$s0, $a0			#n/10
	mfhi		$t0				#a = n%10
	mflo		$s0				#n=n/10
	bne		$s0, $0, if			
	beq		$t0, $0, end_while	#if (n==0&&a==0) break
if:	bge		$t0, $t1, end_if	#if a < min then min = a
	add		$t1, $0, $t0
end_if:
	j		while			#while(n>0)
end_while:
	addi		$v0, $0, 1			#print min
	add		$a0, $t1, $0
	syscall
end_main: