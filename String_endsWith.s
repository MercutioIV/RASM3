// This function will check whether a string ENDS with a specified suffix string
// starting from the end of the first string always
// Parameters:
// X0 - Address of the string to check
// X1 - Address of the prefix string to compare
//
// Returns: Nothing. Function prints TRUE/FALSE depending on the result. All register preserved except X0.
.data
szTrue:  .asciz "TRUE\n\n"
szFalse: .asciz "FALSE\n\n"

.text
.global String_endsWith
String_endsWith:
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

	MOV X19, X0 // Moves address of the string to check into X19
	MOV X20, X1 // Moves address of the suffix string to compare into X20

	MOV X0, X19 	 // Moves address of the string to check into X19
	BL String_length // Calls function to get the string's length. Value is returned at X0
	MOV X22, X0      // Moves the string's length at X22

	MOV X0, X20      // Moves address of the prefix string into X0
	BL String_length // Calls function to get the string's length. Value is returned at X0
	MOV X23, X0      // Moves the suffix string's length at X23

	CMP X23, X22     // Compares string length of the prefix to the string to check
	B.GT false       // If the suffix's length is greater than the string, then returns false

loop:
	LDRB W25, [X19, X22] // Loads char byte of the string to check from index at the end
	LDRB W26, [X20, X23] // Loads char byte of the suffix string to compare to first string

	CMP X25, X26         // Compares first two characters of string and prefix string
	B.NE false           // If they are not equal, skips to the false branch

	SUB X23, X23, #1     // Moves downwards on the suffix byte offset once

	CMP X23, #0          // Compares suffix' string length with 0 to see if it has reached the end
	B.EQ true	     // If suffix is already traversed entirely, then the string ends with suffix

	SUB X22, X22, #1 // Moves downwards on the string starting byte offset once
	B loop

true:
	LDR X0, =szTrue // Loads address of the true message string
	BL putstring    // Calls function to print the string
	B end           // Branches to the end of the program

false:
	LDR X0, =szFalse // Loads address of the false message string
	BL putstring     // Calls fcuntion to print the string
	B end            // Branches to the end of the program

end:
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
