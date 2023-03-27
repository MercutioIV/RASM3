// Function to replace all characters with another character within a string.
// Parameters:
// X0 - Address of the string to change
// X1 - Address of the char byte to replace within the string
// X2 - Address of the char byte to replace with
//
// Returns: X0 - Address of the new string with all characters selected replaced
.data
ptrString: .quad 0

.text
.global String_replace
String_replace:
	// Stores registers X19-X29 and link register LR on stack (AAPCS)
	STR X19, [SP, #-16]!
	STR X20, [SP, #-16]!
	STR X21, [SP, #-16]!
	STR X22, [SP, #-16]!
	STR X23, [SP, #-16]!
	STR X24, [SP, #-16]!
	STR X25, [SP, #-16]!
	STR X26, [SP, #-16]!
	STR X27, [SP, #-16]!
	STR X28, [SP, #-16]!
	STR X29, [SP, #-16]!
	STR LR, [SP, #-16]!

	MOV X29, SP // Sets stack frame

	MOV X19, X0 // Moves address of the string to change into X19
	MOV X20, X1 // Moves the old byte char address to replace
	MOV X21, X2 // Moves the new bye tchar address to replace with

	// Saves registers
	STR X19, [SP, #-16]!
	STR X20, [SP, #-16]!
	STR X21, [SP, #-16]!

	MOV X0, #17 // Allocates 17 bytes to allocate
	BL malloc

	// Pops registers
	LDR X21, [SP], #16
	LDR X20, [SP], #16
	LDR X19, [SP], #16

	// Loads address of new string into ptrString
	LDR X1, =ptrString
	STR X0, [X1]

	MOV X0, X19      // Loads string address
	BL String_length // Gets the string length
	MOV X22, X0      // String length is not at X22

	// X28 now has the address of malloc string
	LDR X28, =ptrString
	LDR X28, [X28]

	MOV X23, #0      // Initializes counter
loop1:
	LDRB W24, [X19, X23] // Loads byte char from string
	LDRB W25, [X20]      // Loads old byte

	CMP W24, W25         // Compares current byte with old byte
	B.EQ replace	     // If they are equal, then the byte is replaced with new byte

	STRB W24, [X28, X23] // Byte is stored if they are not the target character

	ADD X23, X23, #1     // Adds one to index offset
	SUB X22, X22, #1     // Subtracts one from string's length

	CMP X22, #0          // Compares string length with 0
	B.EQ end	     // If length is 0, we reach the end
	B loop1		     // loop is rebranched otherwise

replace:
	LDRB W26, [X21]      // Loads new byte into W26
        STRB W26, [X28, X23] // New byte is replaced and stored

        ADD X23, X23, #1     // Adds one to index offset
        SUB X22, X22, #1     // Subtracts one from string's length

        CMP X22, #0          // Compares string length with 0
        B.EQ end             // If length is 0, we reach the end
        B loop1              // loop is rebranched otherwise

end:
	// Moves malloc string address into X0 register
	LDR X0, =ptrString
	LDR X0, [X0]

// Restores preserved registers
	LDR LR, [SP], #16
	LDR X29, [SP], #16
	LDR X28, [SP], #16
	LDR X27, [SP], #16
	LDR X26, [SP], #16
	LDR X25, [SP], #16
	LDR X24, [SP], #16
	LDR X23, [SP], #16
	LDR X22, [SP], #16
	LDR X21, [SP], #16
	LDR X20, [SP], #16
	LDR X19, [SP], #16

	RET
