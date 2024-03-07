
#for(int i=0,i<strlength,i++)
   #int j= 0;
   #do{
       #if(i = j) dem++;
       #else if(str[j] = str[i]) break;
       #else j++;
  #while(1)
.data
    mess1:    .asciiz   "Nhap xau: "
    mess2:    .asciiz   "so ki tu khong trung la : "
    str:    .space 100

.text
input:
    li $v0,4
    la $a0,mess1
    syscall
    
    li $v0,8
    la $a0,str
    li $a1,100
    syscall
main :
    li $t0,0          #i = 0
    li  $t5,0   #ket qua
    addi  $s6,$a0,0

loop:      #vong lap
    add  $s0,$s6,$t0
    lb   $s1,($s0)
    beq  $s1,'\n',print
    li   $t2,0            #vong lap con
    loop2:
        beq  $t2,$t0,count
        add  $s4,$t2,$s6
        lb   $s5,($s4)
        beq  $s5,$s1,continue
        addi $t2,$t2,1
        j    loop2
   continue:
        addi $t0,$t0,1
        j    loop
print:                  #in ket qua
    li  $v0,4
    la  $a0,mess2
    syscall
    
    
    li  $v0,1
    addi $a0,$t5,0
    syscall

count:                 #dem ki tu
    addi  $t5,$t5,1
    j     continue
end:                  #exit
    li  $v0,10
    syscall
