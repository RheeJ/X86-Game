; #########################################################################
;
;   render.asm - Assembly file for EECS205 Assignment 4/5
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
	
.DATA
count DWORD 0
pcount DWORD 0

.CODE
	GameRender PROC STDCALL
		INVOKE BeginDraw
		mov esi, OFFSET fighter_000
		INVOKE RotateBlit, esi, xCenter, yCenter, angle
		cmp pExplode0, 1
		je P1
		mov esi, OFFSET asteroid_000
		INVOKE BasicBlit, esi, 200, 200
		cmp pExplode1, 1
		je P2
	P1:
		mov esi, OFFSET asteroid_001
		INVOKE RotateBlit, esi, amovement2, amovement2y, arotation
		cmp pExplode2, 1
		je P3
	P2:
		mov esi, OFFSET asteroid_003
		INVOKE RotateBlit, esi, amovement, amovementy, arotation
	P3:
		mov esi, OFFSET asteroid_002
		INVOKE BasicBlit, esi, pCenterx, pCenter
		INVOKE EndDraw
		ret
	GameRender ENDP
	
	ProjExplosion PROC STDCALL lpBitmap:PTR EECS205BITMAP, xC:DWORD, yC:DWORD
		INVOKE BeginDraw
		mov esi, [lpBitmap]
		mov edi, (EECS205BITMAP PTR [esi]).dwWidth
		mov count, 0
	T2:
		cmp count, edi
		jl L2
		jmp P2
	L2:
		mov (BYTE PTR [esi]), 0ffh
		inc esi
		inc count
		jmp T2
	P2:
		mov esi, OFFSET nuke_001
 		INVOKE BasicBlit, esi, xC, yC
		mov esi, OFFSET nuke_002
		INVOKE BasicBlit, esi, xC, yC
		mov esi, OFFSET nuke_003
		INVOKE BasicBlit, esi, xC, yC
		INVOKE EndDraw
		ret
	ProjExplosion ENDP
		
	GameExplosion PROC STDCALL lpBitmap:PTR EECS205BITMAP
		INVOKE BeginDraw
		mov esi, OFFSET fighter_000
		mov edi, (EECS205BITMAP PTR [esi]).dwWidth
	T1:
		cmp count, edi
		jl L1
		jmp P1
	L1:
		mov (BYTE PTR [esi]), 0ffh
		inc esi
		inc count
		jmp T1
	P1:
		mov esi, [lpBitmap]
		mov edi, (EECS205BITMAP PTR [esi]).dwWidth
		mov count, 0
	T2:
		cmp count, edi
		jl L2
		jmp P2
	L2:
		mov (BYTE PTR [esi]), 0ffh
		inc esi
		inc count
		jmp T2
	P2:
		mov esi, OFFSET nuke_001
		INVOKE BasicBlit, esi, xCenter, yCenter
		mov esi, OFFSET nuke_002
		INVOKE BasicBlit, esi, xCenter, yCenter
		mov esi, OFFSET nuke_003
		INVOKE BasicBlit, esi, xCenter, yCenter
		INVOKE EndDraw
		mov Explode, 1
		ret
	GameExplosion ENDP

;; Define the function GameRender
;; Since we have thoroughly covered defining functions in class, its up to you from here on out...
	
END
