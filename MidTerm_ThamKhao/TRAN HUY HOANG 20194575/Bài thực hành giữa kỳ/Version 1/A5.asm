.data
A:.space 100
Message1:.asciiz  "Nhap so nguyen duong N"
Message2:.asciiz "Tong cac chu so la so le la: "
Message3:.asciiz "Tong cac chu so la so chan la: "
.text
main:
la $s0, A #Create array A
li $t0, 0 #Number first
li $t1, 1 #Number second
li $s2, 1 #count Number of array A
li $v0, 51 
la $a0, Message1 #Enter so nguyen N
syscall
add $s1, $zero, $a0 #N
syscall