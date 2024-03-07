.data
    mess1:         .asciiz     "Enter a: "
    mess2:         .asciiz     "Enter b: "
    mess3:         .asciiz     "Enter c: "
    right:         .asciiz     "Day la 3 canh cua tam giac"
    no:            .asciiz     "Day khong phai 3 canh tam giac"
.text
    #Nhap so a
    li    $v0,4
    la    $a0,mess1
    syscall
    li    $v0,5
    syscall
    move  $t1,$v0 
    
    bltu  $t1,0,print       #kiem tra so am
    #Nhap so b
    li    $v0,4
    la    $a0,mess2
    syscall
    li    $v0,5
    syscall
    move  $t2,$v0
    
    bltu  $t1,0,print      #kiem tra so am
    #Nhap so c
    li    $v0,4
    la    $a0,mess3
    syscall
    li    $v0,5
    syscall
    move  $t3,$v0
    
    bltu  $t1,0,print      #kiem tra so am
    
    add   $s1,$t1,$t2     #tong cua 2 canh a, b
    add   $s2,$t2,$t3     #tong cua 2 canh b, c
    add   $s3,$t3,$t1     #tong cua 2 canh c, a
    
    sub   $s4,$t1,$t2     #hieu cua 2 canh a, b
    bltu  $s4,0,swap1
    sub   $s5,$t2,$t3     #hieu cua 2 canh b, c
    bltu  $s5,0,swap2
    sub   $s6,$t3,$t1     #hieu cua 2 canh b, c
    bltu  $s6,0,swap3
    j     check
check:
    blt   $s1,$t3,print   #so tong a + b voi c , a + b < c thi nhay xuong ham print
    blt   $s2,$t1,print   #so tong b + c voi a , b + c < a thi nhay xuong ham print
    blt   $s3,$t2,print   #so tong c + a voi b , c + a < b thi nhay xuong ham print
    
    bgt   $s4,$t3,print
    bgt   $s5,$t1,print
    bgt   $s6,$t2,print
    
    li    $v0,4           #thoa man 3 dieu kien tren thi hien dung
    la    $a0,right
    syscall
    
    li    $v0,55          #in ra man hinh
    la    $a0,right
    la    $a1,4
    syscall
    
    li    $v0,10          #exit
    syscall
    
swap1:   
     sub $s4,$t2,$t1
     j   check
swap2:   
     sub $s5,$t3,$t2
     j   check
swap3:   
     sub $s6,$t1,$t3
     j   check
    
print:         
    li    $v0,4           #khong thoa man 3 dieu kien thi hien sai
    la    $a0,no
    syscall
    
    li    $v0,55           #in ra man hinh
    la    $a0,no
    la    $a1,4
    syscall
    
    li    $v0,10         #exit
    syscall
    
