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
.macro read_int(%r) # lam thay doi v0
	.text
	li $v0, 5
	syscall
	move %r,$v0
.end_macro
.macro assign(%r,%pos)
	la %r,arr
	lhu %r,%pos(%r)	
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
	print_int1(6).macro print_int1 (%x) # lam thay doi v0, a0
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
.macro read_int(%r) # lam thay doi v0
	.text
	li $v0, 5
	syscall
	move %r,$v0
.end_macro
.macro assign(%r,%$a3)
	la %r,arr
	lhu %r,%$a3(%r)	
.end_macro
.macro print_board() # lam thay doi $v0, a0
	print_str "\n<---R    5     4     3     2     1    L--->\n _________________________________________\n"
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
	assign($a0,24)
	beqz $a0,if1
		print_str "\n|  A  |_____|_____|_____|_____|_____|  "
		j end_if1
	if1:
		print_str "\n|     |_____|_____|_____|_____|_____|  "
	end_if1:
	assign($a0,26)
	beqz $a0,if2
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
	print_str " |  " 
	print_int1(12)
	print_str " |   scores 1: " 
	print_int($s1)
	print_str "\n|_____|_____|_____|_____|_____|_____|_____|\n<---L    1     2     3     4     5    R--->"
	
.end_macro
.data
	arr: .half 0,5,5,5,5,5,0,5,5,5,5,5,10,10
.text
main:
	print_str "\nChon che do choi bang cach nhan 1 hoac 2: \n1. Choi voi may.\n2. 2 nguoi choi.\n"
	read_int $s0 # mode
	jal control


	j end_program
# arr,s1,s2,a0-deepth,a1-pos,a2-isRight,a3-isMax

control:
	li $s1,0 # diem nguoi choi 1
	li $s2,0 # diem nguoi choi 
	print_board
	li $s3,-1
	control_loop1:
		print_str "\n     ----* Luot cua nguoi choi 1 *----\n"
		control_loop2:
			print_str "     -> chon cac o tu 1-5 : "
			read_int($a1)
			blt $a1,1,control_loop2
			bgt $a1,5,control_loop2
			sll $t1,$a1,1
			la $t0,arr
			add $t1,$t0,$t1
			lhu $t0,0($t1)
			beqz $t0,control_loop2
		end_control_loop2:
		control_loop3:
			print_str "     -> chon 0 de sang trai, 1 de sang phai : "
			read_int($a2)
			beqz $a2,end_control_loop3
			beq $a2,1,end_control_loop3
			j control_loop3
		end_control_loop3:
		add $sp,$sp,-4
		sw $ra,0($sp)
		jal calculateArray
		print_board
		jal endGame
		lw $ra,0($sp)
		add $sp,$sp,4
		bne $v0,-1,end_control_loop1
		beq $s0,1,control_if1
			print_str "\n     ----* Luot cua nguoi choi 2 *----\n"
			control_loop4:
				print_str "     -> chon cac o tu 1-5 : "
				read_int($a1)
				add $a1,$a1,6
				blt $a1,7,control_loop4
				bgt $a1,11,control_loop4
				sll $t1,$a1,1
				la $t0,arr
				add $t1,$t0,$t1
				lhu $t0,0($t1)
				beqz $t0,control_loop4
			end_control_loop4:
			control_loop5:
				print_str "     -> chon 0 de sang trai, 1 de sang phai : "
				read_int($a2)
				beqz $a2,end_control_loop5
				beq $a2,1,end_control_loop5
				j control_loop5
			end_control_loop5:
			j end_control_if1	
		control_if1:
			print_str "\n     ----* Luot cua nguoi choi 2(AI) *----\n"
			li $v0,30
				syscall
				move $a1,$a0
				li $v0,40
				syscall
			control_loop6:
				li $v0,41
				syscall
				li $t0,5
				divu $a0,$t0
				mfhi $a1
				addi $a1,$a1,7
				sll $t1,$a1,1
				la $t0,arr
				add $t1,$t0,$t1
				lhu $t0,0($t1)
				beqz $t0,control_loop6
			end_control_loop6:
			print_str "     -> May chon o so : "
			move $t1,$a1
			addi $a1,$a1,-6
			print_int $a1
			control_loop7:
				li $v0,41
				syscall
				li $t0,2
				divu $a0,$t0
				mfhi $a2
				beqz $a2,end_control_loop7
				beq $a2,1,end_control_loop7
				j control_loop7
			end_control_loop7:
			print_str "\n     -> May chon huong : "
			print_int $a2
			move $a1,$t1
		end_control_if1:
		add $sp,$sp,-4
		sw $ra,0($sp)
		jal calculateArray
		print_board
		jal endGame
		lw $ra,0($sp)
		add $sp,$sp,4
		bne $v0,-1,end_control_loop1
		j control_loop1
	end_control_loop1:
	move $t0,$v0
	print_str "\nTro choi ket thuc!!!\nDiem nguoi choi 1: "
	print_int $s1
	print_str "\nDiem nguoi choi 2: "
	print_int $s2
	bgt $t0,0,control_if2
		print_str "\nHoa roi!! ^_^"
	j end_control_if2
	control_if2:
	bne $t0,1,control_else_if2
		print_str "\nNguoi choi 1 thang!!"
	j end_control_if2
	control_else_if2:
		print_str "\nNguoi choi 2 thang!!"
	end_control_if2:
	
end_control:	
jr $ra


# 4=a0 array
# 5=a1 _pos
# 6=a2 isRight
calculateArray:
	la $a0,arr
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
        				bnez $t0,end_calculateArray_if1
        			calculateArray_if4:
        			
        			bne $a3,6,calculateArray_if5 # if ($a3==0)
        				assign($t0,12)
        				assign($t1,26)
        				add $t0,$t0,$t1
        				bnez $t0,end_calculateArray_if1
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
        	j end_calculateArray_if1
        calculateArray_if1:
        	        	calculateArray_loop3:
        		addi $a3,$a3,-1
        		bne $a3,-1,calculateArray_if12
        			li $a3,11
        		calculateArray_if12:
        		
        		bnez $v1,calculateArray_if13
        			bne $a3,0,calculateArray_if14 # if ($a3==0)
        				assign($t0,0)
        				assign($t1,24)
        				add $t0,$t0,$t1
        				bnez $t0,end_calculateArray_if1
        			calculateArray_if14:
        			
        			bne $a3,6,calculateArray_if15 # if ($a3==0)
        				assign($t0,12)
        				assign($t1,26)
        				add $t0,$t0,$t1
        				bnez $t0,end_calculateArray_if1
        			calculateArray_if15:
        			sll $t1,$a3,1
        			add $t1,$a0,$t1
        			lhu $t0,0($t1)
        			beqz $t0,end_calculateArray_loop3
        			add $v1,$v1,$t0 #$v1+=a[$a3]
        			sh $0,0($t1) #a[$a3]=0
        			j calculateArray_loop3
        		calculateArray_if13:
        		sll $t1,$a3,1
        		add $t1,$a0,$t1
        		lhu $t0,0($t1)
        		addi $t0,$t0,1
        		sh $t0,0($t1)
        		addi $v1,$v1,-1
        		j calculateArray_loop3	
        	end_calculateArray_loop3:
        	
        	li $t9,0
        	calculateArray_loop4:
        		bnez $t9,end_calculateArray_loop4
      			addi $a3,$a3,-1
        		bne $a3,-1,calculateArray_if16
        			li $a3,11
        		calculateArray_if16:
        		sll $t1,$a3,1
        		add $t1,$a0,$t1
        		lhu $t0,0($t1) #t0=a[$a3]
        		sh $0,0($t1) # a[$a3]=0
        		bne $a3,0,calculateArray_if17 # if ($a3==0)
        			assign($t2,24)
        			add $t0,$t0,$t2
        			sh $0,24($a0)	
        		calculateArray_if17:
        			
        		bne $a3,6,calculateArray_if18 # if ($a3==6)
        			assign($t2,26)
        			add $t0,$t0,$t2
        			sh $0,26($a0)
        		calculateArray_if18:
        		beqz $t0,end_calculateArray_loop4
        		add $v0,$v0,$t0
        		addi $a3,$a3,-1
        		bne $a3,-1,calculateArray_if19
        			li $a3,11
        		calculateArray_if19:
        		sll $t1,$a3,1
        		add $t1,$a0,$t1
        		lhu $t9,0($t1)
      			bne $a3,0,calculateArray_if20 # if ($a3==0)
        			assign($t2,24)
        			add $t9,$t0,$t2
        		calculateArray_if20:
        			
        		bne $a3,6,calculateArray_if21 # if ($a3==6)
        			assign($t2,26)
        			add $t9,$t0,$t2
        		calculateArray_if21:
        		j calculateArray_loop4
        	end_calculateArray_loop4:
        end_calculateArray_if1:
        bgt $a1,6,calculateArray_if22
        	add $s1,$s1,$v0
         j end_calculateArray_if22
        calculateArray_if22:
        	add $s2,$s2,$v0
        end_calculateArray_if22:
        li $t0,0
        assign($t1,2)
        add $t0,$t0,$t1
        assign($t1,4)
        add $t0,$t0,$t1
        assign($t1,6)
        add $t0,$t0,$t1
        assign($t1,8)
        add $t0,$t0,$t1
        assign($t1,10)
        add $t0,$t0,$t1
        bnez $t0,calculateArray_if23
        	li $t1,1
        	sh $t1,2($a0)
        	sh $t1,4($a0)
        	sh $t1,6($a0)
        	sh $t1,8($a0)
        	sh $t1,10($a0)        		
        	add $s1,$s1,-5
        calculateArray_if23:	
     	li $t0,0
       	assign($t1,14)
       	add $t0,$t0,$t1
       	assign($t1,16)
       	add $t0,$t0,$t1
       	assign($t1,18)
       	add $t0,$t0,$t1
       	assign($t1,20)
       	add $t0,$t0,$t1
       	assign($t1,22)
       	add $t0,$t0,$t1
       	bnez $t0,calculateArray_if24
       		li $t1,1
       		sh $t1,14($a0)
        	sh $t1,16($a0)
        	sh $t1,18($a0)
       		sh $t1,20($a0)
       		sh $t1,22($a0)        		
       		add $s2,$s2,-5
   	calculateArray_if24:    
end_calculateArray:
jr $ra

endGame:
	add $sp,$sp,-8
	sw $t0,0($sp)
	sw $t1,4($sp)
	li $v0,-1
	li $t0,0
        assign($t1,0)
       	add $t0,$t0,$t1
       	assign($t1,12)
       	add $t0,$t0,$t1
       	assign($t1,24)
       	add $t0,$t0,$t1
       	assign($t1,26)
       	add $t0,$t0,$t1
        bnez $t0,endGame_if1
        	li $t0,0
        	assign($t1,2)
        	add $t0,$t0,$t1
        	assign($t1,4)
        	add $t0,$t0,$t1
        	assign($t1,6)
        	add $t0,$t0,$t1
        	assign($t1,8)
        	add $t0,$t0,$t1
        	assign($t1,10)
        	add $t0,$t0,$t1
        	add $s1,$s1,$t0
        	
        	li $t0,0
        	assign($t1,14)
        	add $t0,$t0,$t1
        	assign($t1,16)
        	add $t0,$t0,$t1
        	assign($t1,18)
        	add $t0,$t0,$t1
        	assign($t1,20)
        	add $t0,$t0,$t1
        	assign($t1,22)
        	add $t0,$t0,$t1
        	add $s2,$s2,$t0
        	li $v0,0
        	beq $s1,$s2,end_endGame
        	li $v0,1
        	bgt $s1,$s2,end_endGame
        	li $v0,2
        endGame_if1:
end_endGame:
lw $t0,0($sp)
lw $t1,4($sp)
add $sp,$sp,8
jr $ra

end_program:
