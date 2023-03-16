//
// RASM3 written by Dylan Werelius and Diego Caste
//

.data
	// String outputs
	szDescription:	.asciz	"RASM3 Written by Dylan Werelius & Diego Caste"

	// Variables

	// Misc
	chCr:		.byte	10

.text
.global _start
_start:

	// Print Description
	ldr 	x0, =szDescription
	bl 	putstring

_end:
	// Print final return statement
	ldr x0, =chCr
	bl putch

	// End Services
	mov	x0, #0
	mov	x8, #93
	svc	0
