// Function to retrieve a part of a string from two specified indexes: the beginning (inclusive) and the ending (exclusive).
// The function should return the address of the retrieved string in a dynamically allocated memory string.

// Parameters:
// X0 - The address of the string
// X1 - The beginning index as an integer value
// X2 - The ending index as an integer value
//
// Returns: X0 - Address of a dynamically allocated string used to store the retrieved substring.
// NO registers are preserved except AAPCS registers (X19-X29).
.data
ptrString: .quad 0 // Stores pointer of allocated string

.text
.global String_substring1
String_substring1:

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

	SUB X19, X2, X1 // The length of the substring = endIndex - beginIndex

	// Stores parameters values before malloc
	STR X0, [SP, #-16]!
	STR X1, [SP, #-16]!
	STR X2, [SP, #-16]!

	ADD X19, X19, #1    // Adds one to the substring's length and adds 1 to allocate for null terminator
	MOV X0, X19         // Moves the total bytes needed (substring's length + 1) to allocate memory for substring
	BL malloc	    // Calls function to allocate memory

	LDR X20, =ptrString // Loads pointer string into X20
	STR X0, [X20]	    // Stores the address of the allocated memory storage starting point at ptrString

	// Retrieves parameters values after malloc
	LDR X2, [SP], #16
	LDR X1, [SP], #16
	LDR X0, [SP], #16

	LDR X19, =ptrString  // Loads pointer address into X19
	LDR X19, [X19]	     // Loads the address pointing by the pointer

	SUB X20, X2, X1      // Substring's length = endIndex - begIndex (sentinel value)

	MOV X21, #0          // Loads byte offset to store char bytes into new allocated string
		             // The offset to retrieve character bytes is at X1 the begIndex
loop:
	LDRB W22, [X0, X1]   // Loads byte from string starting at BEGINNING index into X22
	STRB W22, [X19, X21] // Stores byte into allocated memory address at X0

	ADD X1, X1, #1       // Adds one to BEGINNING index
	ADD X21, X21, #1     // Adds one to the offset byte to store the characters

	SUB X20, X20, #1     // Subtracts one from substring length

	CMP X20, #0          // Compares the BEGINNING index to the substring's length
	B.GT loop            // If the substring's length reaches 0, then we go to the end
		             // Loop is rebranched otherwise
end:
	// Prints the allocated string contents
	LDR X0, =ptrString
	LDR X0, [X0]
	BL putstring

	// Frees memory
	LDR X0, =ptrString
	LDR X0, [X0]
	BL free

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
