.data
input_s:	.asciiz	"Please enter a string: "
aiueo:	.asciiz	"aiueoAIUEO"
str:		.asciiz
.text
main:
	la		$a0, input_s
	la		$a2, str
	la		$a3, aiueo
	addi		$v0, $0, 4
	syscall				#print "Please enter a string: "
	la		$a0, str
	addi		$v0, $0, 8
	addi		$a1, $0, 100	#Max string len
	syscall
	addi		$t0, $0, 0		#length = 0
strlen:	#strlen(str)
	add		$a1, $a0, $t0
	lb		$t2, 0($a1)		#str[length]
	beq		$t2, $0, end_strlen	#if(str[length]=='\0') break;
	addi		$t0, $t0, 1		#length++
	j		strlen
end_strlen:
	addi		$v1, $0, 0				#count = 0
	addi		$t1, $0, 0				#i = 0
for_i:	bge	$t1, $t0, end_for_i		#for(int i=0;i<length;i++)
	add		$s1, $t1, $a2
	lb		$s1, 0($s1)			#str[i]
	addi		$t2, $0, 0				#j = 0
	addi		$t3, $0, 10			#strlen("aiueoAIUEO");
for_j:	bge	$t2, $t3, end_for_j		#for(int j=0;j<10;j++)
	add		$s2, $t2, $a3
	lb		$s2, 0($s2)			#aiueo[j]
if:	bne		$s1, $s2, end_if		#if(str[i] == aiueo[j])
	addi		$v1, $v1, 1			#count++
	j		end_for_j
end_if:
	addi		$t2, $t2, 1			#j++
	j		for_j
end_for_j:
	addi		$t1, $t1, 1			#i++
	j		for_i
end_for_i:
	addi		$v0, $0, 1
	add		$a0, $v1, $0
	syscall						#printf("%d", count);