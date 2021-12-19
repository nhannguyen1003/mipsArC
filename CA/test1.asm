.data
	arr: .half 0,1,2,3,4,5,0,0,8,9,10,11,10,10
.text

	
	la $a0,arr
	li $a1, 2
	li $a2,1
	jal calculateArray

j end_calculateArray
# 4=a0 array
# 5=a1 _pos
# 6=a2 isRight
calculateArray:
        sll     $v0,$a1,1
        addu    $v0,$a0,$v0
        lhu      $v1,0($v0) # v1=temp
        sh      $0,0($v0)  # a[_pos]=0
        move    $a3,$a1     # a3=pos
        li $v0,0 # v0=scores
        
        beqz $a2,calculateArray_if1
        	calculateArray_loop1:
        		addi pos,pos,1
        		bne pos,12,calculateArray_if2
        			li pos,0
        		calculateArray_if2:
        		
        		bnez temp,calculateArray_if3
        			bne pos,0,calculateArray_if4 # if (pos==0)
        				assign($t0,0)
        				assign($t1,24)
        				add $t0,$t0,$t1
        				bnez $t0,end_calculateArray
        			calculateArray_if4:
        			
        			bne pos,6,calculateArray_if5 # if (pos==0)
        				assign($t0,12)
        				assign($t1,26)
        				add $t0,$t0,$t1
        				bnez $t0,end_calculateArray
        			calculateArray_if5:
        			sll $t1,pos,1
        			add $t1,$a0,$t1
        			lhu $t0,0($t1)
        			beqz $t0,end_calculateArray_loop1
        			add temp,temp,$t0 #temp+=a[pos]
        			sh $0,0($t1) #a[pos]=0
        			j calculateArray_loop1
        		calculateArray_if3:
        		sll $t1,pos,1
        		add $t1,$a0,$t1
        		lhu $t0,0($t1)
        		addi $t0,$t0,1
        		sh $t0,0($t1)
        		addi temp,temp,-1
        		j calculateArray_loop1	
        	end_calculateArray_loop1:
        	
        	li curr,0
        	calculateArray_loop2:
        		bnez curr,end_calculateArray_loop2
      			addi pos,pos,1
        		bne pos,12,calculateArray_if6
        			li pos,0
        		calculateArray_if6:
        		sll $t1,pos,1
        		add $t1,$a0,$t1
        		lhu $t0,0($t1) #t0=a[pos]
        		sh $0,0($t1) # a[pos]=0
        		bne pos,0,calculateArray_if7 # if (pos==0)
        			assign($t2,24)
        			add $t0,$t0,$t2
        			sh $0,24($a0)	
        		calculateArray_if7:
        			
        		bne pos,6,calculateArray_if8 # if (pos==6)
        			assign($t2,26)
        			add $t0,$t0,$t2
        			sh $0,26($a0)
        		calculateArray_if8:
        		beqz $t0,end_calculateArray_loop2
        		add $v0,$v0,$t0
        		addi pos,pos,1
        		bne pos,12,calculateArray_if9
        			li pos,0
        		calculateArray_if9:
        		sll $t1,pos,1
        		add $t1,$a0,$t1
        		lhu curr,0($t1)
      			bne pos,0,calculateArray_if10 # if (pos==0)
        			assign($t2,24)
        			add curr,$t0,$t2
        		calculateArray_if10:
        			
        		bne pos,6,calculateArray_if11 # if (pos==6)
        			assign($t2,26)
        			add cur,$t0,$t2
        		calculateArray_if11:
        		j calculateArray_loop2
        	end_calculateArray_loop2:
        	
        calculateArray_if1:
        
	
 
end_calculateArray:
jr $ra