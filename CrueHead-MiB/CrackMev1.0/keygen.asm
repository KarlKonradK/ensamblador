.386
.MODEL flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib

.data
	titulo db "Keygen para CrackMe CrueHead/MiB v1.0--CLS--",0
	msg db "Introduce tu nombre(name):  ",0
	msg1 db 10,"Serial:  ",0
	msg2 db "Tu nombre tiene caracteres no validos",0
	buffer db 15 dup(0)
	buffer1 db 10 dup(0)
	
.code
principal:
	xor esi, esi
	xor edi, edi
	xor ebx, ebx
	invoke ClearScreen
	invoke SetConsoleTitle, offset titulo
	invoke StdOut, offset msg
	invoke StdIn, offset buffer, 15
	call serial
	invoke StdOut, offset msg1
	invoke StdOut, offset buffer1
	invoke wait_key
	invoke ExitProcess,0
	
		serial proc
			lea esi, buffer
			Check:
				mov al, [esi]
				test al,al
 				jz Sig
 				cmp al, 41h
 				jb error
 				cmp al, 5Ah
 				jnb Mayus
  				inc esi
  				jmp short Check
			Mayus:
 				sub al, 20h
				mov [esi], al
 				inc  esi
 				jmp short Check
 			Sig:
				mov  esi, offset buffer
			Check1:
				mov  bl, [esi]
				test bl, bl
				jz final
				add     edi, ebx
				inc     esi
				jmp short Check1
			error:
				invoke ClearScreen
				invoke StdOut, offset msg2
				invoke wait_key
				call principal
			final:
				cmp edi, 0
				je error
				xor edi, 444Ch
				invoke dwtoa, edi, offset buffer1
			ret
		serial endp

end principal
