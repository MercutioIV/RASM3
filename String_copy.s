// Function to copy a string into another string variable/address.
// Parameters:
// X0 - Address of the string to copy
// X1 - Address to store the copy of the string
//
// Returns: Nothing. Copy of string is stored into the address of X1's label. All registers preserved except X0.
.data

.text
.global String_copy
String_copy:

// Preserves registers X19-X30 (AAPACS)
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

	MOV X19, X0 // Moves the address of the string to copy into X19
	MOV X20, X1 // Moves the address location to store the string copy into X20

	MOV X0, X19      // Moves the address of the string to copy into X0
	BL String_length // Calls function to get the string's length. Value is returned at X0
	MOV X21, X0      // Stores string's length value into X21

	MOV X22, #0      // Initializes 0 to register X22 for loading and storing bytes (offset)
Copy_Loop:
	LDRB W23, [X19, X22] // Loads char byte from the string to copy into W23
	STRB W23, [X20, X22] // Stores the char byte into the address location to store the string copy

	ADD X22, X22, #1     // Moves offset onwards once
	SUB X21, X21, #1     // Subtracts one from string's length (sentinel value)

	CMP X21, #0          // Compares string's length to 0
	B.GT Copy_Loop       // If substring's length reaches 0, then we go to the end of the loop
			     // Loop is rebranched otherwise
End_Copy:
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

        RET // Returns to calling function
