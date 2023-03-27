// This function will converge two strings together into a single one.
// Parameters:
// X0 - Address of the first string
// X1 - Address of the second string
//
// Returns: X0 - Address of the allocated concanated single string
.data
ptrString: .quad 0

.text
.global String_concat
String_concat:
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

	MOV X19, X0 // Moves address of the first string into X19
	MOV X20, X1 // Moves address of the second string into X20

	MOV X0, X19      // Moves address of the first string into X0
	BL String_length // Gets the string's length
	MOV X21, X0	 // Moves the string length value into X21

	MOV X0, X20      // Moves the address of the second string into X0
	BL String_length // Gets the second string's length
	MOV X22, X0      // Moves the string length value into X22

	ADD X23, X22, X21 // Adds both string's length. This is our new string size
	ADD X23, X23, #1  // Adds one more byte for our new string size just in case

	// Store string addresses before malloc
	STR X19, [SP, #-16]!
	STR X20, [SP, #-16]!
	STR X21, [SP, #-16]!
	STR X22, [SP, #-16]!

	MOV X0, X23       // Moves the total new string size into X0
	BL malloc         // Calls function to malloc

	LDR X1, =ptrString // Loads address of the memory into X1
	STR X0, [X1]       // Loads the address of the new string into X0

	// Stores registers
	LDR X22, [SP], #16
	LDR X21, [SP], #16
	LDR X20, [SP], #16
	LDR X19, [SP], #16

	// Loads address of the malloc string
	LDR X23, =ptrString
	LDR X23, [X23]

	MOV X24, #0 // Sets index offset for loading byte for first string
	MOV X25, #0 // Sets index offset for loading byte for second string
	MOV X26, #0 // Sets index offset for storing bytes
loop1:
	LDRB W27, [X19, X24] // Loads byte from the string into W27
	STRB W27, [X23, X26] // Stores the byte into allocated memory address

	SUB X21, X21, #1     // Subtracts one from the first string's length
	ADD X24, X24, #1     // Adds one to loading byte offset
	ADD X26, X26, #1     // Moves index forwards by 1 byte to store char

	CMP X21, #0          // Compares first string's length to 0
	B.EQ loop2	     // If it has reached 0, we go to the next string
	B loop1	             // Loop is rebranched otherwise

loop2:
	LDRB W27, [X20, X25] // Loads byte from the string into W27
	STRB W27, [X23, X26] // Stores the byte into allocated memory address

	SUB X22, X22, #1     // Subtracts one to the second string's length
	ADD X25, X25, #1     // Adds one to loading byte offset index
	ADD X26, X26, #1     // Moves index forwards by 1 byte to store char

	CMP X22, #0	     // Compares second string's length to 0
	B.EQ end	     // If it has reached 0, we go to the end of the program
	B loop2	             // Loop is rebranched otherwise
end:
	LDR X0, =ptrString // Loads address of concatenated string into X0
	LDR X0, [X0]       // Loads the contents of the concatenated string address

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

