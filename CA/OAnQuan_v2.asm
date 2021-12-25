.macro print_int1 (%x) # lam thay doi v0, a0 # %x khác a0
	bnez %x,if1
		print_str("  ")
		j if2
	if1: 
	print_int %x
	bgt %x,9,if2
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

.macro assign(%d,%arr,%pos)
	add %d,%arr,%pos
	lhu %d,0(%d)
.end_macro 


.macro print_board(%arr,%s1,%s2,%temp1,%temp2) # lam thay doi $v0, a0
	print_str "\n<---R    5     4     3     2     1    L--->\n _________________________________________\n"
	print_str "|     |  " 
	lhu %temp1,22(%arr)
	print_int1(%temp1)
	print_str " |  " 
	lhu %temp1,20(%arr)
	print_int1(%temp1)
	print_str " |  " 
	lhu %temp1,18(%arr)
	print_int1(%temp1)
	print_str " |  " 
	lhu %temp1,16(%arr)
	print_int1(%temp1)
	print_str " |  " 
	lhu %temp1,14(%arr)
	print_int1(%temp1)
	print_str " |     |   scores 2: " 
	print_int(%s2)
	
	lhu %temp1,0(%arr)
	bnez %temp1,if3
		sh $0,24(%arr)
	if3:
	lhu %temp1,12(%arr)
	bnez %temp1,if4
		sh $0,26(%arr)
	if4:
	
	lhu %temp1,24(%arr)
	beqz %temp1,if1
		print_str "\n|  A  |_____|_____|_____|_____|_____|  "
		j end_if1
	if1:
		print_str "\n|     |_____|_____|_____|_____|_____|  "
	end_if1:
	lhu %temp1,26(%arr)
	beqz %temp1,if2
		print_str "B  |\n"
		j end_if2
	if2:
		print_str "   |\n"
	end_if2:
	
	print_str "|  " 
	lhu %temp1,0(%arr)
	lhu %temp2,24(%arr)
	sub %temp1,%temp1,%temp2
	print_int1(%temp1)
	
	print_str " |  " 
	lhu %temp1,2(%arr)
	print_int1(%temp1)
	print_str " |  " 
	lhu %temp1,4(%arr)
	print_int1(%temp1)
	print_str " |  " 
	lhu %temp1,6(%arr)
	print_int1(%temp1)
	print_str " |  " 
	lhu %temp1,8(%arr)
	print_int1(%temp1)
	print_str " |  " 
	lhu %temp1,10(%arr)
	print_int1(%temp1)
	print_str " |  " 
	
	lhu %temp1,12(%arr)
	lhu %temp2,26(%arr)
	sub %temp1,%temp1,%temp2
	print_int1(%temp1)
	
	print_str " |   scores 1: " 
	print_int(%s1)
	print_str "\n|_____|_____|_____|_____|_____|_____|_____|\n<---L    1     2     3     4     5    R--->"
	
.end_macro

.macro endGame(%result,%arr,%s1,%s2,  %temp1,%temp2)
	li %result,-2
	lhu %temp1,0(%arr)
	lhu %temp2,12(%arr)
	add %temp1,%temp1,%temp2
	bnez %temp1,if1
		lhu %temp1,2(%arr)
		add %s1,%s1,%temp1
		lhu %temp1,4(%arr)
		add %s1,%s1,%temp1
		lhu %temp1,6(%arr)
		add %s1,%s1,%temp1
		lhu %temp1,8(%arr)
		add %s1,%s1,%temp1
		lhu %temp1,10(%arr)
		add %s1,%s1,%temp1
		
		lhu %temp1,14(%arr)
		add %s2,%s2,%temp1
		lhu %temp1,16(%arr)
		add %s2,%s2,%temp1
		lhu %temp1,18(%arr)
		add %s2,%s2,%temp1
		lhu %temp1,20(%arr)
		add %s2,%s2,%temp1
		lhu %temp1,22(%arr)
		add %s2,%s2,%temp1
		li %result,1
		blt %s1,%s2,if1
		li %result,0
		beq %s1,%s2,if1
		li %result,-1
	if1:
.end_macro
.macro calculateArray  (%arr,%s1,%s2,%index,%delta,    %pos,%result,%count,%temp1,%temp2,%temp3) # &arr, &s1, &s2
	move %pos,%index
	assign(%count,%arr,%pos)
	add %temp1,%arr,%pos
	sh $0,0(%temp1)
	li %temp1,24
	loop1:
		add %pos,%pos,%delta
		div %pos,%temp1
		mfhi %pos
		bnez %count,if3
		 	bnez %pos,if1
		 		lhu %temp2,0(%arr)
		 		bnez %temp2,mid_calculateArray	
			if1:
			bne %pos,12,if2
				lhu %temp2,12(%arr)
				bnez %temp2,mid_calculateArray	
			if2:
			assign(%temp2,%arr,%pos)
			beqz %temp2,end_loop1
			add %count,%count,%temp2
			add %temp2,%arr,%pos
			sh $0,0(%temp2)
			j loop1
		if3:
		assign(%temp2,%arr,%pos)
		addi %temp2,%temp2,1
		add %temp3,%arr,%pos
		sh %temp2,0(%temp3)
		addi %count,%count,-1
		j loop1
	end_loop1:
	li %result,0
	loop2:
		add %pos,%pos,%delta
		div %pos,%temp1
		mfhi %pos
		assign(%temp2,%arr,%pos)
		beqz %temp2,end_loop2
		
		add %result,%result,%temp2
		add %temp2,%arr,%pos
		sh $0,0(%temp2)
		
		add %pos,%pos,%delta
		div %pos,%temp1
		mfhi %pos
		assign(%temp2,%arr,%pos)
		beqz %temp2,loop2
	end_loop2:
	bgt %index,12,else4
		add %s1,%s1,%result
	j end_if4
	else4:
		add %s2,%s2,%result
	end_if4:
	mid_calculateArray:
	li %temp1,0
	lhu %temp2,2(%arr)
	add %temp1,%temp1,%temp2
	lhu %temp2,4(%arr)
	add %temp1,%temp1,%temp2
	lhu %temp2,6(%arr)
	add %temp1,%temp1,%temp2
	lhu %temp2,8(%arr)
	add %temp1,%temp1,%temp2
	lhu %temp2,10(%arr)
	add %temp1,%temp1,%temp2
	bnez %temp1,if5
		addi %s1,%s1,-5
		li %temp2,1
		sh %temp2,2(%arr)
		sh %temp2,4(%arr)
		sh %temp2,6(%arr)
		sh %temp2,8(%arr)
		sh %temp2,10(%arr)
	if5:
	li %temp1,0
	lhu %temp2,14(%arr)
	add %temp1,%temp1,%temp2
	lhu %temp2,16(%arr)
	add %temp1,%temp1,%temp2
	lhu %temp2,18(%arr)
	add %temp1,%temp1,%temp2
	lhu %temp2,20(%arr)
	add %temp1,%temp1,%temp2
	lhu %temp2,22(%arr)
	add %temp1,%temp1,%temp2
	bnez %temp1,if6
		addi %s2,%s2,-5
		li %temp2,1
		sh %temp2,14(%arr)
		sh %temp2,16(%arr)
		sh %temp2,18(%arr)
		sh %temp2,20(%arr)
		sh %temp2,22(%arr)
	if6:
	
.end_macro
.macro control(%arr,%s1,%s2,%mode,%pos,%direct,%result,)
	.data 
		arr1: .half 10,5,5,5,5,5,10,5,5,5,5,5,10,10
	.text
	li %s1,0
	li %s2,0
	li %mode,2
	la %arr,arr1
	print_board(%arr,%s1,%s2,$t0,$t1)
	loop1:
		print_str "\n     ----* Luot cua nguoi choi 1 *----\n"
		loop1.1:
			print_str "    --> chon cac o tu 1-5 : "
			read_int %pos
			blt %pos,$0,loop1.1
			bgt %pos,5,loop1.1
			sll %pos,%pos,1
			assign($t0,%arr,%pos)
			beqz $t0,loop1.1
		end_loop1.1:
		
		loop1.2:
			print_str "    --> chon 0 de sang trai, 1 de sang phai : "
			read_int %direct
			beqz %direct,end_loop1.2
			beq %direct,1,end_loop1.2
			j loop1.2
		end_loop1.2:
		sll %direct,%direct,1
		bnez %direct,if1
			li %direct,22
		if1:
		print_int %pos
		print_int %direct
		calculateArray(%arr,%s1,%s2,%pos,%direct,$t0,$t1,$t2,$t3,$t4,$t5)
		print_board(%arr,%s1,%s2,$t0,$t1)
		endGame(%result,%arr,%s1,%s2,$t0,$t1)
		bne %result,-2,end_loop1
		bne %mode,2,else2
		
		print_str "\n     ----* Luot cua nguoi choi 2 *----\n"
		loop1.3:
			print_str "    --> chon cac o tu 1-5 : "
			read_int %pos
			blt %pos,$0,loop1.3
			bgt %pos,5,loop1.3
			sll %pos,%pos,1
			add %pos,%pos,12
			assign($t0,%arr,%pos)
			beqz $t0,loop1.3
		end_loop1.3:

		
		loop1.4:
			print_str "    --> chon 0 de sang trai, 1 de sang phai : "
			read_int %direct
			beqz %direct,end_loop1.4
			beq %direct,1,end_loop1.4
			j loop1.2
		end_loop1.4:
		sll %direct,%direct,1
		bnez %direct,if3
			li %direct,22
		if3:
		
		calculateArray(%arr,%s1,%s2,%pos,%direct,$t0,$t1,$t2,$t3,$t4,$t5)
		print_board(%arr,%s1,%s2,$t0,$t1)
		endGame(%result,%arr,%s1,%s2,$t0,$t1)
		bne %result,-2,end_loop1	
		
		j end_if2
		else2:
		
		end_if2:
		j loop1	
	end_loop1:
	print_str "\nTro choi ket thuc!!!\nDiem nguoi choi 1: "
	print_int %s1
	print_str "\nDiem nguoi choi 2: "
	print_int %s2
	bgt %result,0,control_if2
		print_str "\nHoa roi!! ^_^"
	j end_control_if2
	control_if2:
	bne %result,-1,control_else_if2
		print_str "\nNguoi choi 1 thang!!"
	j end_control_if2
	control_else_if2:
		print_str "\nNguoi choi 2 thang!!"
	end_control_if2:
.end_macro

.text
main:
	#print_str "\nChon che do choi bang cach nhan 1 hoac 2: \n1. Choi voi may.\n2. 2 nguoi choi.\n"
	#read_int $s0 # mode
	#jal control
	control($a1,$s1,$s2,$s0,$t7,$t8,$t9)

	j end_program
end_program:
