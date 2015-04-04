%include "io.mac"

.DATA				;Initialize Data
instructionMsg	db	"Enter a phrase to see check if it is a palindrome: ", 0		
isPalindrome	db	"The phrase IS a palindrome!", 0
notPalindrome	db	"The phrase is NOT a palindrome!", 0
.UDATA
phrase		resb	16	;buffer to store word can't be over 15chars
.CODE				;Code area
	.STARTUP		
	PutStr	instructionMsg	
	GetStr	phrase,16	;read the word
	
	mov	esi, phrase
	mov	ebx, phrase
	xor	ecx, ecx
len:				;chars in phrase
	mov	al, [esi]	;mov char to al
	cmp	al, 0		;if null char
	je	decEsi		;end len
	inc	esi		;increment index
	jne 	len
decEsi:
	dec	esi		;don't want 0
	mov	eax, esi
	shr	eax, 1
reverse:	
	mov	al, [esi]	;move first char to ah
	mov	ah, [ebx]
	
	dec	esi
	dec	ecx
	inc	ebx		

	cmp	al,ah		;if two chars are not equal
	jne	isFalse
	cmp	ecx, 1	;if copied over all chars it is a palindrome
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
