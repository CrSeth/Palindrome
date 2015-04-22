;-------------------------------------------------------
;This program asks the user for a word or phrase and then
;determines whether it is a palindrome or not.
;---
;Instituto Tecnologico de Costa Rica - 2015 
;Course: Computer Achitecture
;-------------------------------------------------------

%include "io.mac"

.DATA				;Initialize Data
instructionMsg	db	"Enter a phrase to check if it is a palindrome: ", 0		;initial instruction
isPalindrome	db	"The phrase IS a palindrome!", 0				;if phrase is a palindrome show this
notPalindrome	db	"The phrase is NOT a palindrome!", 0				;else show this
.UDATA
phrase		resb	16	;buffer to store word can't be over 15chars
.CODE				;Code area
	.STARTUP		;Code starts here	
	PutStr	instructionMsg	;show instruction to user
	GetStr	phrase,16	;read the word
	
	mov	esi, phrase	;initialize pointesr to beginning of phrase
	mov	ebx, phrase
	xor	ecx, ecx	;clear counter
len:				;chars in phrase
	mov	al, [esi]	;mov char to al
	cmp	al, 0		;if null char
	je	decEsi		;end len
	inc	esi		;increment index
	inc	ecx		;inc counter
	jne 	len		;keep looping if not at end of phrase
decEsi:
	dec	esi		;don't want 0
	shr	ecx, 1		;cut the "len" in half because we are moving in from both sides
reverse:	
	mov	al, [esi]	;move last char to al
	mov	ah, [ebx]	;move fist char to ah
	
	dec	esi		;decrease the counter and end char pointer
	dec	ecx	
	inc	ebx		;inc the front running pointer
	
	or	al, 20h		;change 5bit to 1 | Lower Case ASCII
	or	ah, 20h		;do same for other char

	cmp	al,ah		;if two chars are not equal
	jne	isFalse		;then not a palindrome
	cmp	ecx, 1		;if copied over all chars it is a palindrome
	jle	isTrue		;then is a palindomre
	jmp	reverse		;keep comparing chars from each end
isTrue:				;show result msg
	PutStr	isPalindrome
	nwln			;a new line
	jmp	END		;end
isFalse:
	PutStr	notPalindrome	
	nwln			;a new line
	jmp	END		;end
END:	
	.EXIT			;tell OS we are done
