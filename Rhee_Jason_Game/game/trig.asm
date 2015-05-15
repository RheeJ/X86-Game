; #########################################################################
;
;   trig.asm - Assembly file for EECS205 Assignment 3
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

    include trig.inc	

.DATA

;;  These are some useful constants (fixed point values that correspond to important angles)
PI_HALF = 102943           	;;  PI / 2
PI =  205887	                ;;  PI 
TWO_PI	= 411774                ;;  2 * PI 
PI_INC_RECIP =  5340353        	;;  256 / PI   (use this to find the table entry for a given angle
	                        ;;              it is easier to use than divison would be)

.CODE

	FixedSin PROC STDCALL dwAngle:FIXED 
	LOCAL NC: BYTE							;;Implement a binary negative checker.            
		mov NC, 0							
		mov eax, dwAngle					;;dwAngle into eax.
		cmp eax, 0							;;Check to see if dwAngle is negative
		jle N	
		jmp T
      
	N:										;;If negative run this.   
		xor NC, 1							
		mov ebx, 0FFFF0000h					
		imul ebx							;;Make dwAngle positive.
		shl edx, 16
		shr eax, 16
		xor eax, edx						;;Put the multiplication result into one register. Where the top half is integer value and bottom half is fraction value.
	
	T:										;;Run comparison tests.
		cmp eax, 0							;;Negative?
		jl N
		cmp eax, TWO_PI						;;Greater than 2pi?                
    	jge G2								
		cmp eax, PI							;;Greater than pi?		      
		jge G1
		cmp eax, PI_HALF					;;Greater than pi/2?
		jge GH         
		jmp L								;;If less than pi/2 than go to default line.

	G2:										;;Greater than 2pi.
		sub eax, TWO_PI						;;dwAngle - 2pi.
		cmp eax, TWO_PI						;;Still greater than 2pi?
		jge G2
		cmp eax, PI							;;Greater than pi?
		jge G1
		cmp eax, PI_HALF					;;Greater than pi/2?
		jge GH
		jmp L								;;If less than pi/2 than go to default line.

    G1:										;;Greater than pi.
		xor NC, 1							;;Negative sine values after this point until 2pi.
		sub eax, PI							;;dwAngle - pi.
		cmp eax, PI_HALF					;;Greater than pi/2?
		jge GH
		jmp L								;;If less than pi/2 than go to default line.

	GH:             
		mov ebx, PI							;;Greater than pi/2.
		sub ebx, eax						;;pi - dwAngle.
		mov eax, ebx
		jmp L								;;If less than pi/2 than go to default line.

	L:										;;Default line.
		mov ecx, PI_INC_RECIP
		imul ecx							;;dwAngle * 256/pi. Integer value held in edx.
		mov eax, 0
		mov ebx, 0
		mov bx, dx							;;Take integer value of the multiplication and put into a word.
		add ebx, ebx                                      
		mov ax, [SINTAB + ebx]				;;Use the word as an index for Sine Table.
		jmp P1

    P1:
		cmp NC, 0							;;See if the value is supposed to be negative
		je P2
		mov ebx, 0FFFF0000h					;;If it is, multiply by fixed value -1.
		imul ebx               
		shl edx, 16
		shr eax, 16
		xor eax, edx						;;Put result of multiplication into one register with integer value in top half and fraction value in bottom half.
	
	P2:
	ret
	FixedSin ENDP

	FixedCos PROC STDCALL dwAngle:FIXED
		mov esi, dwAngle
		add esi, PI_HALF
		INVOKE FixedSin, esi				;;Cosine is Sine(dwAngle + pi/2).
		ret
	FixedCos ENDP

END
