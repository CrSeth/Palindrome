%include "io.mac"

.DATA				;Initialize Data
instructionMsg	db	"Enter a phrase to check if it is a palindrome: ", 0		
isPalindrome	db	"The phrase IS a palindrome!", 0
notPalindrome	db	"The phrase is NOT a palindrome!", 0
.UDATA
phrase		resb	16	;buffer to store word can't be over 15chars
.CODE				;Code area
	.STARTUP		
	PutStr	instructionMsg	
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
	jne 	len		
decEsi:
	dec	esi		;don't want 0
	shr	ecx, 1
reverse:	
	mov	al, [esi]	;move last char to al
	mov	ah, [ebx]	;move fist char to ah
	
	dec	esi		;decrease the counter and end char pointer
	dec	ecx
	inc	ebx		;inc the front running pointer
	PutInt	cx
	
	or	al, 20h		;change 5bit to 1 | Lower Case ASCII
	or	ah, 20h		

	cmp	al,ah		;if two chars are not equal
	jne	isFalse
	cmp	ecx, 1		;if copied over all chars it is a palindrome
	jle	isTrue
	jmp	reverse
isTrue:				;show result msg
	PutStr	isPalindrome
	nwln
	jmp	END
isFalse:
	PutStr	notPalindrome	
	nwln
	jmp	END	
END:	
	.EXIT
