; #########################################################################
;
;   logic.asm - Assembly file for EECS205 Assignment 4/5
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

    include stars.inc	
    include blit.inc
    include rotate.inc	
    include game.inc
    include keys.inc		
	
.DATA
	sto0 DWORD 0
	sto1 DWORD 0
	sto2 DWORD 0
	sto3 DWORD 0
.CODE
	GameLogic PROC STDCALL xinc:DWORD, yinc:DWORD, angleinc:DWORD, arotationinc:DWORD, projY:DWORD, projX:DWORD
		cmp pExplode0, 1
		je QWERTY
		jmp SQW
	QWERTY:
		mov esi, OFFSET asteroid_000
		INVOKE ProjExplosion, esi, 200, 200
	SQW:
		cmp pExplode1, 1
		je QWERTY2
		jmp SQW2
	QWERTY2:
		mov esi, OFFSET asteroid_001
		INVOKE ProjExplosion, esi, sto0, sto1
	SQW2:
		cmp pExplode2, 1
		je QWERTY3
		jmp SQW3
	QWERTY3:
		mov esi, OFFSET asteroid_003
		INVOKE ProjExplosion, esi, sto2, sto3
	SQW3:
		mov esi, xCenter
		mov edi, yCenter
		mov edx, angle
		mov ecx, arotation
		add esi, xinc
		add edi, yinc
		add edx, angleinc
		add ecx, arotationinc
		mov xCenter, esi
		mov yCenter, edi
		add edi, projY
		add esi, projX
		mov pCenter, edi
		mov pCenterx, esi                  
		mov angle, edx
		mov arotation, ecx
		cmp xCenter, 210
		jg LV
		cmp xCenter, 190
		jl LV
		cmp yCenter, 210
		jg LV
		cmp yCenter, 190
		jl LV
		mov esi, OFFSET asteroid_000
		INVOKE GameExplosion, esi
	LV:
		cmp pCenterx, 210
		jg L
		cmp pCenterx, 190
		jl L
		cmp pCenter, 210
		jg L
		cmp pCenter, 190
		jl L
		mov esi, OFFSET asteroid_000
		mov pExplode0, 1

		INVOKE ProjExplosion, esi, 200, 200
	L:
		mov ebx, amovement2
		add ebx, 2
		cmp xCenter, ebx
		jg NW
		sub ebx, 4
		cmp xCenter, ebx
		jl NW
		mov ebx, amovement2y
		add ebx, 2
		cmp yCenter, ebx
		jg NW
		sub ebx, 4
		cmp yCenter, ebx
		jl NW
		mov esi, OFFSET asteroid_001
		INVOKE GameExplosion, esi
	NW:
		mov ebx, amovement2
		add ebx, 2
		cmp pCenterx, ebx
		jg N
		sub ebx, 4
		jl N
		mov ebx, amovement2y
		add ebx, 2
		cmp pCenter, ebx
		jg N
		sub ebx, 4
		cmp pCenter, ebx
		jl N
		mov esi, OFFSET asteroid_001
		mov pExplode1, 1
		mov ecx, amovement2
		mov edx, amovement2y
		mov sto0, ecx
		mov sto1, edx
		mov amovement2, -1000000
		mov amovement2y, -1000000
		INVOKE ProjExplosion, esi, sto0, sto1
	N:
		mov ebx, amovement
		add ebx, 20
		cmp xCenter, ebx
		jg OQ
		sub ebx, 40
		cmp xCenter, ebx
		jl OQ
		mov ebx, amovementy
		add ebx, 20
		cmp yCenter, ebx
		jg OQ
		sub ebx, 40
		cmp yCenter, ebx
		jl OQ
		mov esi, OFFSET asteroid_003
		INVOKE GameExplosion, esi
	OQ:
		mov ebx, amovement
		add ebx, 20
		cmp pCenterx, ebx
		jg O
		sub ebx, 40
		cmp pCenterx, ebx
		jl O
		mov ebx, amovementy
		add ebx, 20
		cmp pCenter, ebx
		jg O
		sub ebx, 40
		cmp pCenter, ebx
		jl O
		mov esi, OFFSET asteroid_003
		mov pExplode2, 1
		mov ecx, amovement
		mov edx, amovementy
		mov sto2, ecx
		mov sto3, edx
		INVOKE ProjExplosion, esi, sto2, sto3
		mov amovement, 100000
		mov amovementy, 100000
	O:
		ret
	GameLogic ENDP
;; Define the function GameLogic
;; Since we have thoroughly covered defining functions in class, its up to you from here on out...
	
END
