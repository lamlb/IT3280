#Nhập vào xâu ký tự, in ra màn hình số ký tự nguyên âm có trong xâu.

.data
vowel: .asciiz "aeiou"
msg_prompt: .asciiz "Nhap xau ky tu: "
msg_out: .asciiz "So ky tu nguyen am la: "
msg_nl: .asciiz "\n"
str: .space 256 # Buffer 100 byte chua string
.text

main:
 # In "Nhap xau ky tu: "
 li $v0, 4
 la $a0, msg_prompt
 syscall

 #Nhap string
 li $v0, 8
 la $a0, str
 li $a1, 100
 syscall
 
 li $s2, 0 # vowelCount = 0
 la $s0, str # Dia chi tro den string
 
string_loop:
 lb $t0, 0($s0) # t0 = str[i]
 addiu $s0, $s0, 1 # i = i + 1
 beqz $t0, string_done # Da duyet het xau? 
 la $s1, vowel # Tro den vowel
vowel_loop:
 lb $t1, 0($s1) # t1 = vowel[j]
 beqz $t1, string_loop # Duyet het string vowel?
 addiu $s1, $s1, 1 # j = j + 1
 
 # Kiem tra co phai nguyen am hay khong?
 bne $t0, $t1, vowel_loop # str[i] == vowel[j]
 addi $s2, $s2, 1 # La nguyen am -> vowelCount++
 j string_loop # Duyet ky tu tiep theo
string_done: # Da duyet het xau
 # In "So ky tu nguyen am la: "
 li $v0, 4
 la $a0, msg_out
 syscall
 # In so ky tu nguyen am
 li $v0, 1
 move $a0, $s2
 syscall
 # Xuong dong moi
 li $v0, 4
 la $a0, msg_nl
 syscall
 # Thoat chuong trinh
 li $v0, 10
 syscall
