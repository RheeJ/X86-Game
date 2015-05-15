; #########################################################################
;
;   game.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;; These are library routines that you will call (but do NOT have to implement)
BeginDraw PROTO
EndDraw PROTO

;; You should not need to modify these prototypes (actually, it would probably be bad)
GameInit PROTO
GameMain PROTO mouseStatus:DWORD, keyDown:DWORD, keyUp:DWORD

;; Useful Library Routines
DrawString PROTO x:DWORD, y:DWORD, string:PTR BYTE 
DrawInt PROTO x:DWORD, y:DWORD, value:DWORD

;; Feel free to modify the following
GameRender PROTO 
GameLogic PROTO xinc : DWORD, yinc : DWORD, angleinc : DWORD, arotationinc : DWORD, projY : DWORD, projX : DWORD
GameExplosion PROTO lpBitmap : PTR EECS205BITMAP
ProjExplosion PROTO lpBitmap : PTR EECS205BITMAP, xC : DWORD, yC : DWORD
GameProj PROTO

EXTERNDEF lpTyroneBmp : DWORD
EXTERNDEF xCenter : DWORD
EXTERNDEF yCenter : DWORD
EXTERNDEF angle : DWORD
EXTERNDEF arotation : DWORD
EXTERNDEF amovement : DWORD
EXTERNDEF amovementy : DWORD
EXTERNDEF amovement2 : DWORD
EXTERNDEF amovement2y : DWORD
EXTERNDEF pCenter : DWORD
EXTERNDEF pCenterx : DWORD
EXTERNDEF Explode : BYTE
EXTERNDEF pExplode0 : BYTE
EXTERNDEF pExplode1 : BYTE
EXTERNDEF pExplode2 : BYTE
EXTERNDEF anglestep : DWORD
EXTERNDEF spacepressed : BYTE
EXTERNDEF fighter_000:EECS205BITMAP
EXTERNDEF asteroid_000:EECS205BITMAP
EXTERNDEF asteroid_001:EECS205BITMAP
EXTERNDEF asteroid_002:EECS205BITMAP
EXTERNDEF asteroid_003:EECS205BITMAP
EXTERNDEF nuke_001:EECS205BITMAP
EXTERNDEF nuke_002:EECS205BITMAP
EXTERNDEF nuke_003:EECS205BITMAP