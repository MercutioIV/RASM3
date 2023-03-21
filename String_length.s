// Subroutine stringLength: Provided a pointer to a null terminated string.
// String_length will return the length of the strnig in X0
// X0: Must point to a null terminated string
// LR: Must contain the return address
// All registers are preserved, except X0
.text
.global String_length
String_length:
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
        MOV X29, SP          // Sets stack frame

        MOV X19, X0          // Moves string address to X19 register

        MOV X0, 0x00         // Loads null value into X0 for comparison
        LDRB W22, [X19]      // Loads the byte (char) at base address

        MOV X20, #0          // Initializes counter X20 = 0

        _loop:
        CMP X22, 0x00        // Checks if character byte is not a null
        B.EQ _exit           // If it is a null character, exits the loop

        LDRB W22, [X19], #1  // Moves the index pointer forward

        ADD X20, X20, #1     // Sums one to counter
        b _loop              // Re-enters loop branch

        _exit:
        SUB X20, X20, #1     // Subtracts the null terminator from string length counter
        MOV X0, X20          // Moves the total stringth length in X0
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
