
//
// RASM3 written by Diego Caste and Dylan Werelius
//

.data
	// String outputs
	szDescription:	.asciz	"RASM3 Written by Dylan Werelius & Diego Caste\n"
	szPrompt:	.asciz	"Enter 3 strings:\n"

	sz1Length:	.asciz	"s1.length() =                         "
	sz2Length:	.asciz	"s2.length() =                         "
	sz3Length:	.asciz	"s3.length() =                         "

	szSEQ1:		.asciz	"String_equals(s1,s3) =                "
	szSEQ2:		.asciz	"String_equals(s1,s1) =                "

	szSEQI1:	.asciz	"String_equalsIgnoreCase(s1,s3) =      "
	szSEQI2:	.asciz	"String_equalsIgnoreCase(s1,s2) =      "

	szCopy:		.asciz	"s4 = String_copy(s1)\n"

	szSub1:		.asciz	"String_substring_1(s3,4,14) =         "
	szSub2:		.asciz	"String_substring_2(s3,7) =            "

	szCharAt:	.asciz	"String_charAt(s2,4) =                 "

	szStartW1:	.asciz	"String_startsWith_1(s1,11,\"hat.\") =   "
	szStartW2:	.asciz	"String_startsWith_2(s1,\"Cat\") =       "

	szEndsW:	.asciz	"String_endsWIth(s1,\"in the hat.\") =   "

	szIO1:		.asciz	"String_indexOf_1(s2,\'g\') =          "
	szIO2:		.asciz	"String_indexOf_2(s2,\'g\',9) =        "

	szLIO1:		.asciz	"String_lastIndexOf_1(s2,\'g\') =      "
	szLIO2:		.asciz	"String_lastIndexOf_2(s2,\'g\') =      "
	szLIO3:		.asciz	"String_lastIndexOf_3(s2,\"egg\") =    "

	szReplace:	.asciz	"String_replace(s1,\'a\',\'o\') =      "

	szLower:	.asciz	"String_toLowerCase(s1) =              "
	szUpper:	.asciz	"String_toUpperCase(s1) =              "

	szConcat1:	.asciz	"String_concat(s1, \" \");"
	szConcat2:	.asciz	"String_concat(s1, s2) =               "

	szS1:		.asciz	"s1 = "
	szS2:		.asciz	"s2 = "
	szS3:		.asciz	"s3 = "
	szS4:		.asciz	"s4 = "

	// Variables
	szInput:	.skip	22

	sz1:		.skip	22
	sz2:		.skip	22
	sz3:		.skip	22
	sz4:		.skip	22

	szOutput:	.skip	22

	// Misc
	szHat:		.asciz	"hat."
	szCat:		.asciz	"Cat"
	szInHat:	.asciz	"in the hat."
	chCr:		.byte	10
	chCharAt:	.byte	0

.text
.global _start
_start:

// Description and Input

	// Print Description
	ldr 	x0, =szDescription
	bl 	putstring

	// Print Prompt
	ldr	x0, =szPrompt
	bl	putstring

	// Get sz1
	ldr	x0, =sz1
	mov 	x1, #22
	bl	getstring

	// Get sz2
	ldr	x0, =sz2
	mov 	x1, #22
	bl	getstring

	// Get sz3
	ldr	x0, =sz3
	mov 	x1, #22
	bl	getstring

	// Newline
	ldr 	x0, =chCr
	bl 	putch

// Lengths

	// Print the heading of sz1
	ldr	x0, =sz1Length	// THIS IS NOT THE NUMBER THIS IS THE HEADING
	bl	putstring

	// Get the Length
	ldr 	x0, =sz1
	bl	strLength

	// Convert Length to ascii
	ldr	x1, =szOutput
	bl	int64asc

	// Print length of string
	ldr	x0, =szOutput
	bl 	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// print length of sz2
	ldr	x0, =sz2Length	// AGAIN THIS IS THE HEADING, NOT THE ACTUAL LENGTH
	bl	putstring

	// Get the Length
	ldr 	x0, =sz2
	bl	strLength

	// Convert Length to ascii
	ldr	x1, =szOutput
	bl	int64asc

	// Print length of string
	ldr	x0, =szOutput
	bl 	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// print length of sz3
	ldr	x0, =sz3Length
	bl 	putstring

	// Get the Length
	ldr 	x0, =sz3
	bl	strLength

	// Convert Length to ascii
	ldr	x1, =szOutput
	bl	int64asc

	// Print length of string
	ldr	x0, =szOutput
	bl 	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

// Print the equals

	// Print first s1 = s3
	ldr	x0, =szSEQ1
	bl	putstring

	// Call the .equals function
	ldr	x0, =sz1
	ldr	x1, =sz3
	bl	String_equals 	// This function prints true or false

	// Print s1 = s1
	ldr	x0, =szSEQ2
	bl	putstring

	// Call the .equals function
	ldr	x0, =sz1
	ldr	x1, =sz1
	bl	String_equals	// This function prints true or false

	// Print s1 = s3 (ignore case)
	ldr	x0, =szSEQI1
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print s1 = s2
	ldr	x0, =szSEQI2
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

// String Copy

	// Print string copy
	ldr	x0, =szCopy
	bl	putstring

	// Print resut
	ldr	x0, =szS1
	bl	putstring
	ldr	x0, =sz1
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print other result
	ldr	x0, =szS4
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

// Substring

	// Print first substring
	ldr	x0, =szSub1
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print the second
	ldr	x0, =szSub2
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

// CharAt

	// Print the charAt
	ldr 	x0, =szCharAt
	bl	putstring

	// Print the character
	ldr 	x0, =sz2
	mov	x1, #4
	bl	String_charAt
	ldr	x1, =chCharAt
	str	x0, [x1]
	ldr	x0, =chCharAt
	bl	putch

	// newline
	ldr	x0, =chCr
	bl	putch

// Print starts with

	// Print the first
	ldr	x0, =szStartW1
	bl	putstring

	// Call the function
	ldr	x0, =sz1
	ldr	x1, =szHat
	mov	x2, #11
	bl	String_startsWith1

	// Print the second
	ldr	x0, =szStartW2
	bl	putstring

	// Call the function
	ldr	x0, =sz1
	ldr	x1, =szCat
	bl	String_startsWith2

// Ends with

	// Print the ends with
	ldr	x0, =szEndsW
	bl	putstring

	// Call the function
	ldr	x0, =sz1
	ldr	x1, =szInHat
	bl	String_endsWith

// Index of

	// Print the first index of
	ldr	x0, =szIO1
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print the second index of
	ldr	x0, =szIO2
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

// Last index of

	// Print the first
	ldr	x0, =szLIO1
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print the second
	ldr	x0, =szLIO2
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print the third
	ldr	x0, =szLIO3
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

// Replace

	// Print Replace
	ldr	x0, =szReplace
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

// Upper and lower

	// Print Lower
	ldr	x0, =szLower
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print Upper
	ldr	x0, =szUpper
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

// Concats

	// Print the first
	ldr	x0, =szConcat1
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print the second
	ldr	x0, =szConcat2
	bl	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

// Print the strings

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print sz1
	ldr 	x0, =sz1
	bl 	putstring

	// newline
	ldr	x0, =chCr
	bl	putch

	// Print sz2
	ldr 	x0, =sz2
	bl 	putstring

	// Newline
	ldr 	x0, =chCr
	bl 	putch

	// Print sz3
	ldr 	x0, =sz3
	bl 	putstring

_end:
	// Print final return statement
	ldr 	x0, =chCr
	bl 	putch

	// End Services
	mov	x0, #0
	mov	x8, #93
	svc	0
