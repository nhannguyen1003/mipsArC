.macro print_int1 (%x) # lam thay doi v0, a0
	assign($a0,%x)
	bnez $a0,if1
		print_str("  ")
		j if2
	if1: 
	assign($a0,%x)
	li $v0, 1
	syscall
	bgt $a0,9,if2
		print_str(" ")
	if2:
.end_macro

.macro print_int (%x) # lam thay doi v0, a0
	add $a0, $zero, %x
	li $v0, 1
	syscall
.end_macro

.macro print_str (%str) # lam thay doi v0, a0
	.data
	myLabel: .asciiz %str
	.text
	li $v0, 4
	la $a0, myLabel
	syscall
.end_macro
.macro assign(%r,%$a3)
	la %r,arr
	lhu %r,%$a3(%r)	
.end_macro
.macro print_board() # lam thay doi $v0, a0
	print_str "<---R    5     4     3     2     1    L--->\n _________________________________________\n"
	print_str "|     |  " 
	print_int1(22)
	print_str " |  " 
	print_int1(20)
	print_str " |  " 
	print_int1(18)
	print_str " |  " 
	print_int1(16)
	print_str " |  " 
	print_int1(14)
	print_str " |     |   scores 2: " 
	print_int($s2)
	beqz $s3,if1
		print_str "\n|  A  |_____|_____|_____|_____|_____|  "
		j end_if1
	if1:
		print_str "\n|     |_____|_____|_____|_____|_____|  "
	end_if1:
	beqz $s4,if2
		print_str "B  |\n"
		j end_if2
	if2:
		print_str "   |\n"
	end_if2:
	print_str "|  " 
	print_int1(0)
	print_str " |  " 
	print_int1(2)
	print_str " |  " 
	print_int1(4)
	print_str " |  " 
	print_int1(6)
	print_str " |  " 
	print_int1(8)
	print_str " |  " 
	print_int1(10)
	print_str " |     |   scores 1: " 
	print_int($s1)
	print_str "\n|_____|_____|_____|_____|_____|_____|_____|\n<---L    1     2     3     4     5    R--->"
	
.end_macro
.data
	arr: .half 0,1,2,3,4,5,0,0,8,9,10,11,10,10
.text

	
	la $a0,arr
	li $a1, 2
	li $a2,1
	jal calculateArray

	j end_program
# 4=a0 array
# 5=a1 _$a3
# 6=a2 isRight
calculateArray:
        sll     $v0,$a1,1
        addu    $v0,$a0,$v0
        lhu      $v1,0($v0) # v1=$v1
        sh      $0,0($v0)  # a[_$a3]=0
        move    $a3,$a1     # a3=$a3
        li $v0,0 # v0=scores
        
        beqz $a2,calculateArray_if1
        	calculateArray_loop1:
        		addi $a3,$a3,1
        		bne $a3,12,calculateArray_if2
        			li $a3,0
        		calculateArray_if2:
        		
        		bnez $v1,calculateArray_if3
        			bne $a3,0,calculateArray_if4 # if ($a3==0)
        				assign($t0,0)
        				assign($t1,24)
        				add $t0,$t0,$t1
        				bnez $t0,end_calculateArray
        			calculateArray_if4:
        			
        			bne $a3,6,calculateArray_if5 # if ($a3==0)
        				assign($t0,12)
        				assign($t1,26)
        				add $t0,$t0,$t1
        				bnez $t0,end_calculateArray
        			calculateArray_if5:
        			sll $t1,$a3,1
        			add $t1,$a0,$t1
        			lhu $t0,0($t1)
        			beqz $t0,end_calculateArray_loop1
        			add $v1,$v1,$t0 #$v1+=a[$a3]
        			sh $0,0($t1) #a[$a3]=0
        			j calculateArray_loop1
        		calculateArray_if3:
        		sll $t1,$a3,1
        		add $t1,$a0,$t1
        		lhu $t0,0($t1)
        		addi $t0,$t0,1
        		sh $t0,0($t1)
        		addi $v1,$v1,-1
        		j calculateArray_loop1	
        	end_calculateArray_loop1:
        	
        	li $t9,0
        	calculateArray_loop2:
        		bnez $t9,end_calculateArray_loop2
      			addi $a3,$a3,1
        		bne $a3,12,calculateArray_if6
        			li $a3,0
        		calculateArray_if6:
        		sll $t1,$a3,1
        		add $t1,$a0,$t1
        		lhu $t0,0($t1) #t0=a[$a3]
        		sh $0,0($t1) # a[$a3]=0
        		bne $a3,0,calculateArray_if7 # if ($a3==0)
        			assign($t2,24)
        			add $t0,$t0,$t2
        			sh $0,24($a0)	
        		calculateArray_if7:
        			
        		bne $a3,6,calculateArray_if8 # if ($a3==6)
        			assign($t2,26)
        			add $t0,$t0,$t2
        			sh $0,26($a0)
        		calculateArray_if8:
        		beqz $t0,end_calculateArray_loop2
        		add $v0,$v0,$t0
        		addi $a3,$a3,1
        		bne $a3,12,calculateArray_if9
        			li $a3,0
        		calculateArray_if9:
        		sll $t1,$a3,1
        		add $t1,$a0,$t1
        		lhu $t9,0($t1)
      			bne $a3,0,calculateArray_if10 # if ($a3==0)
        			assign($t2,24)
        			add $t9,$t0,$t2
        		calculateArray_if10:
        			
        		bne $a3,6,calculateArray_if11 # if ($a3==6)
        			assign($t2,26)
        			add $t9,$t0,$t2
        		calculateArray_if11:
        		j calculateArray_loop2
        	end_calculateArray_loop2:
        	
        calculateArray_if1:
        
	
end_calculateArray:
jr $ra
end_program: