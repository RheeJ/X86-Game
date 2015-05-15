; #########################################################################
;
;   stars.asm - Assembly file for EECS205 Assignment 1
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

    include stars.inc

.CODE

; Routine which uses DrawStarReg to create all the stars
DrawAllStars PROC 

    ;; Place your code here

	;; 2 Immediate to Register Instructions and 1 Procedure Call Instruction for each star

	mov esi, 50 ;; puts a value into the GPR ESI which is passed as the argument for x-coordinate in the procedure DrawStarReg
	mov edi, 50 ;; puts a value into the GPR EDI which is passed as the argument for y-coordinate in the procedure DrawStarReg
	call DrawStarReg ;; calls the procedure DrawStarReg with the two arguments from ESI and EDI

	;; repeat the process by changing values to overwrite the contents in ESI and EDI and call DrawStarReg to make 23 more stars
	mov esi, 100 
	mov edi, 70
	call DrawStarReg

	mov esi, 400
	mov edi, 75
	call DrawStarReg

	mov esi, 550
	mov edi, 75
	call DrawStarReg

	mov esi, 180
	mov edi, 20
	call DrawStarReg

	mov esi, 250
	mov edi, 100
	call DrawStarReg

	mov esi, 352
	mov edi, 215
	call DrawStarReg

	mov esi, 104
	mov edi, 25
	call DrawStarReg

	mov esi, 510
	mov edi, 400
	call DrawStarReg

	mov esi, 29
	mov edi, 27
	call DrawStarReg

	mov esi, 100
	mov edi, 100
	call DrawStarReg

	mov esi, 200
	mov edi, 248
	call DrawStarReg

	mov esi, 321
	mov edi, 123
	call DrawStarReg

	mov esi, 78
	mov edi, 270
	call DrawStarReg

	mov esi, 300
	mov edi, 200
	call DrawStarReg

	mov esi, 27
	mov edi, 400
	call DrawStarReg

	mov esi, 479
	mov edi, 57
	call DrawStarReg

	mov esi, 10
	mov edi, 500
	call DrawStarReg

	mov esi, 500
	mov edi, 10
	call DrawStarReg

	mov esi, 270
	mov edi, 123
	call DrawStarReg

	mov esi, 330
	mov edi, 370
	call DrawStarReg

	mov esi, 370
	mov edi, 350
	call DrawStarReg

	mov esi, 457
	mov edi, 300
	call DrawStarReg

	mov esi, 600
	mov edi, 200
	call DrawStarReg

	mov esi, 579
	mov edi, 257
	call DrawStarReg

    ret             ;; Don't delete this line
    
DrawAllStars ENDP

END
