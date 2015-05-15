; #########################################################################
;
;   rotate.asm - Assembly file for EECS205 Assignment 3
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

    include trig.inc		; Useful prototypes
    include rotate.inc		; 	and definitions


.DATA
	;; You may declare helper variables here, but it would probably be better to use local variables

.CODE
	BasicBlit PROC STDCALL lpBmp:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD    ;;Basic Blit puts in lpBmp into edx, xcenter into esi, and ycenter into edi and then calls BlitReg.
		mov edx, lpBmp
		mov esi, xcenter
		mov edi, ycenter
		INVOKE BlitReg
		ret
	BasicBlit ENDP

	RotateBlit PROC STDCALL lpBmp:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD, angle:DWORD
	LOCAL cosa:FIXED, sina:FIXED, shiftX:DWORD, shiftY:DWORD, dstWidth:DWORD, dstHeight:DWORD, dstX:DWORD, dstY:DWORD, srcX:DWORD, srcY:DWORD, xPos:DWORD, yPos:DWORD
		
		cmp angle, 0
		jne B
		INVOKE BasicBlit, lpBmp, xcenter, ycenter			;;Draws the initial blit onto the screen when the program starts.
		 
	B:
		INVOKE FixedCos, angle								;;Calls FixedCos with angle parameter.
		mov cosa, eax
		INVOKE FixedSin, angle								;;Calls FixedSine with angle parameter.
		mov sina, eax
		mov esi, [lpBmp]									;;Put address of lpBmp into esi.
		mov eax, (EECS205BITMAP PTR [esi]).dwWidth
		sal eax, 16											
		imul cosa	
		sar edx, 1							
		mov ecx, edx										;;(dwWidth * cosa)/2.
		mov eax, (EECS205BITMAP PTR [esi]).dwHeight
		sal eax, 16
		imul sina
		sar edx, 1
		mov ebx, edx										;;(dwHeight * sina)/2.
		sub ecx, ebx
		mov shiftX, ecx										;;ShiftX = (dwWidth * cosa)/2 - (dwHeight * sina)/2.
		mov eax, (EECS205BITMAP PTR [esi]).dwHeight
		sal eax, 16
		imul cosa
		sar edx, 1
		mov ecx, edx										;;(dwHeight * cosa)/2.
		mov eax, (EECS205BITMAP PTR [esi]).dwWidth
		sal eax, 16
		imul sina
		sar edx, 1
		mov ebx, edx										;;(dwWidth * sina)/2.
		add ecx, ebx
		mov shiftY, ecx										;;ShiftY = (dwHeight * cosa)/2 + (dwWidth * sina)/2.
		mov ebx, (EECS205BITMAP PTR [esi]).dwWidth
		mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
		add ecx, ebx
		mov dstWidth, ecx
		mov dstHeight, ecx									;;dstWidth and dstHeight = dwWidth + dwHeight.
		mov ebx, 0
		sub ebx, dstWidth
		mov dstX, ebx										;;dstX = -dstWidth.
		mov ebx, 0
		sub ebx, dstHeight
		mov dstY, ebx										;;dstY = -dstHeight.
		jmp L1

	LB:
		mov edi, [lpDisplayBits]							;;Put address of lpDisplayBits into edi.
		mov eax, dstX
		sal eax, 16
		imul cosa
		mov ebx, edx										;;(dstX * cosa).
		mov eax, dstY
		sal eax, 16
		imul sina
		mov ecx, edx										;;(dstY * sina).
		add ebx, ecx
		mov srcX, ebx										;;srcX = (dstX * cosa) + (dstY * sina).
		mov eax, dstY
		sal eax, 16
		imul cosa
		mov ebx, edx										;;(dstY * cosa).
		mov eax, dstX
		sal eax, 16
		imul sina
		mov ecx, edx										;;(dstX * sina).
		sub ebx, ecx
		mov srcY, ebx										;;srcY = (dstY * cosa) - (dstX * sina).
		cmp srcX, 0											;;If statements begin here.
		jl T
		cmp srcY, 0
		jl T
		mov ebx, (EECS205BITMAP PTR [esi]).dwWidth
		cmp srcX, ebx
		jge T
		mov ebx, (EECS205BITMAP PTR [esi]).dwHeight
		cmp srcY, ebx
		jge T												;;(0 =< srcX < dwWidth) && (0 =< srcY < dwHeight).
		mov ebx, xcenter
		add ebx, dstX
		sub ebx, shiftX
		mov xPos, ebx										;;xPos = xcenter + dstX - shiftX.
		mov ebx, ycenter
		add ebx, dstY
		sub ebx, shiftY
		mov yPos, ebx										;;yPos = ycenter + dstY - shiftY.
		cmp xPos, 0
		jl T
		cmp yPos, 0
		jl T
		cmp xPos, 639
		jge T
		cmp yPos, 479
		jge T												;;(0 =< xPos < 639) && (0 =< yPos < 479).
		mov eax, srcY
		mul (EECS205BITMAP PTR [esi]).dwWidth				;;srcY * dwWidth to get # of rows down.
		add eax, srcX										;;Add srcX to get # of columns across.
		add eax, (EECS205BITMAP PTR [esi]).lpBytes			
		mov bl, (BYTE PTR [eax])							;;Get the color byte at this pixel location from EECS205BITMAP.
		cmp bl, (EECS205BITMAP PTR [esi]).bTransparent		;;Check to see if the color byte is transparent.
		je T
		mov ecx, xcenter
		add ecx, dstX
		sub ecx, shiftX										;;xcenter + dstX - shiftX.
		mov eax, ycenter
		add eax, dstY
		sub eax, shiftY										;;ycenter + dstY - shiftY.
		mul dwPitch											;;Multiply by dwPitch to go down the screen vertically by (ycenter + dstY - shiftY).
		add eax, ecx
		add edi, eax										;;Add to address of lpDisplayBits
		mov (BYTE PTR [edi]), bl							;;Color the pixel on screen at location (xcenter + dstX - shiftX),(ycenter + dstY - shiftY) the byte from EECS205BITMAP.
		inc dstY											;;dstY++.
		jmp L2
	
	L2:
		mov ebx, dstHeight	
		cmp dstY, ebx										;;(dstY < dstHeight).
		jl LB												
		inc dstX											;;dstX++.
	L1:
		mov ecx, dstWidth
		mov ebx, 0											
		sub ebx, dstHeight
		mov dstY, ebx										;;Reset dstY.
		cmp dstX, ecx										;;(dstX < dstWidth).
		jl L2
		jmp P
	
	T:
		inc dstY											;;Increment dstY then continue.
		jmp L2	
	P:
		ret
	RotateBlit ENDP

END
