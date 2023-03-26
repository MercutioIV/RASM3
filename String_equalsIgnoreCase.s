// This function will pass two string as parameters. Both strings will be compared character by character.
// If both strings are equal, the function will print "TRUE" otherwise it would print "FALSE"
// NOT CASE SENSITIVE
//
// Parameters:
// X0 - Address of the first string to compare
// X1 - Address of the second string to compare
//
// Returns: Nothing, message is displayed on console and all registers are preserved except X0.
.data
szTrue:        .asciz "TRUE\n\n"
szFalse:       .asciz "FALSE\n\n"
szIgnoreCase1: .skip 22
szIgnoreCase2: .skip 22

.text
.global String_equalsIgnoreCase
String_equalsIgnoreCase:
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

	MOV X19, X0 // Moves the address of the first string into X19
	MOV X20, X1 // Moves the address of the second string into X20

	MOV X0, X19      // Moves the first string's address into X0
	BL String_length // Calls function to get the string's length and is returned into X0
	MOV X28, X0      // Moves the string length value into X28

	MOV X0, X20      // Moves the second string's address into X0
	BL String_length // Calls function to get the string's length and is returned into X0
	MOV X27, X0      // Moves the string length value into X27

	CMP X27, X28     // Compares both string's values
	B.NE notEqual    // If the length of both strings differs, then they are not equal

	MOV X0, X19           // Loads first string address into X0 to lowercase it
	BL String_toLowerCase // Calls function to lowercase string. String's address is returned at X0
	MOV X19, X0           // Moves the address of the lowercased string into X19

	MOV X0, X20           // Loads second string address into X0 to lowercase it
	BL String_toLowerCase // Calls function to lowercase string. String's address is returned at X0
	MOV X20, X0           // Moves the address of the lowercased string into X20

	MOV X21, #0      // Sets loop counter
	MOV X22, #0      // Sets offset for character byte loading

loop:
	LDRB W23, [X19, X22] // Loads char byte into X23 of the first string
	LDRB W24, [X20, X22] // Loads char byte into X24 of the second string

	CMP X23, X24       // Compares both char bytes
	B.NE notEqual      // If char bytes are not equal, branch to notEqual

	ADD X21, X21, #1   // Adds one to loop counter
	ADD X22, X22, #1   // Shifts once to byte offset index

	CMP X21, X27       // Compares loop counter to the string's length (this is skipped if not same length)
	B.NE loop          // If not equal, branches to loop again

equal:
	LDR X0, =szTrue // Loads address of the TRUE message
	BL putstring    // Calls function to print TRUE on console
	B end           // Branches to the end of the program

notEqual:
	LDR X0, =szFalse // Loads address of the FALSE message
	BL putstring	 // Calls function to print FALSE on console
	B end		 // Branches to the end the program

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
