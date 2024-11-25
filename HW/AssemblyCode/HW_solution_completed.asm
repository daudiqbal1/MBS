; -----------------------------------------------------------
; Microcontroller Based Systems Homework
; Author name: Iqbal Daud
; Neptun code: X32SQC
; -------------------------------------------------------------------
; Task description: 
;   Multiplication of two 16-bit unsigned integers being in the internal memory. 
;   The result should be a 32-bit unsigned integer.
;   Inputs: Operand and result addresses (pointers)
;   Output: Result starting at the given address
; -------------------------------------------------------------------


; Definitions
; -------------------------------------------------------------------

; Address symbols for creating pointers

INPUT1_ADR  EQU 0x20
INPUT2_ADR  EQU 0x30
OUTPUT_ADR  EQU 0x40


; Test data for input parameters
; (Try also other values while testing your code.)

; Input 1: 300 (Hexadecimal: 0x012C)
INPUT1_H    EQU 0xA5    ; High byte
INPUT1_L    EQU 0x04    ; Low byte

; Input 2: 400 (Hexadecimal: 0x0190)
INPUT2_H    EQU 0x75    ; High byte
INPUT2_L    EQU 0x2B    ; Low byte


; Interrupt jump table
ORG 0x0000;
    SJMP  MAIN                  ; Reset vector

; Beginning of the user program
ORG 0x0033

; -------------------------------------------------------------------
; MAIN program
; -------------------------------------------------------------------
; Purpose: Prepare the inputs and call the multiplication subroutine
; -------------------------------------------------------------------

MAIN:

    ; Prepare input parameters for the subroutine

    MOV R0,  #INPUT1_ADR    ; Initialize operand 1 in the internal data memory
    MOV @R0, #INPUT1_H      ; (big endian: high byte to low address)
    INC R0                  ; Increment R0 to point to the low byte of operand 1
    MOV @R0, #INPUT1_L      ; Store low byte at next address

    MOV R1,  #INPUT2_ADR    ; Initialize operand 2 in the internal data memory
    MOV @R1, #INPUT2_H      ; (big endian: high byte to low address)
    INC R1                 ; Increment R1 to point to the low byte of operand 2
    MOV @R1, #INPUT2_L      ; Store low byte at next address

    MOV R0, #INPUT1_ADR     ; Set R0 to the address of operand 1
    MOV R1, #INPUT2_ADR     ; Set R1 to the address of operand 2
    MOV R2, #OUTPUT_ADR     ; Set R2 to the address for storing the 32-bit result

; Infinite loop: Call the subroutine repeatedly
LOOP:

    CALL MUL_U16

    SJMP  LOOP




; ===================================================================           
;                           SUBROUTINE(S)
; ===================================================================           


; -------------------------------------------------------------------
; MUL_U16
; -------------------------------------------------------------------
; Purpose: Multiplication of two 16-bit unsigned integers
; -------------------------------------------------------------------
; INPUT(S):
;   R0 - Address of operand 1 (big endian)
;   R1 - Address of operand 2 (big endian)
;   R2 - Address of 32-bit result (big endian)
; OUTPUT(S): 
;   Result at the given address (32-bit result)
; MODIFIES: 
;           A, B, R3, R4
; -------------------------------------------------------------------


MUL_U16:


	MOV A, 0x21;	//Moving Lower Byte from input 1 to Accumulator
	MOV B, 0x31;	//Moving Lower Byte from Input 2
	MUL AB;			//Multiplication
	MOV 0x43, A;	//Moving Result in Accumulator to Output Address
	MOV R2, B;		//Storing in R2 for later use
	MOV A, 0x20;	//Moving the next bytes in order
	MOV B, 0x30;
	MUL AB;
	MOV R3, A;		//Storing for later use
	MOV R4, B;		//Same
	MOV A, 0x20;	//Moving next byte in order to Accumulator
	MOV B, 0x31;
	MUL AB;	
	ADD A, R2;		//Adding Previously Stored byte to Accumulator Value
	MOV R2, A;		//Storing that sum in R2 for later use
	MOV A,B;		//Moved result of B to Accumulator to add the other byte
	ADDC A, R3;		//Added carry from previous addition to value stored in A and R3, and stored in A
	MOV R3, A;		//Stored the result in R3 
	MOV A, R4;		//Moving value stored in R4 to accumulator
	ADDC A, #00H; 	//This instruction is used to add carry in the accumulartor if any, in case there is not C=1 a 0 is added to A anyways.
	MOV R4, A;		//Storing Accumulator value in R4
	MOV A, 0x21;	//Multiplication Steps..
	MOV B, 0x30;
	MUL AB;
	ADD A, R2;		//Addition
	MOV 0x42, A;	//Storing accumulator result at output address
	MOV A, B;
	ADDC A, R3;		//Carry bit
	MOV 0x41, A;	//Storing in Output
	MOV A, R4;		
	ADDC A, #00H;	//Adding carry bit
	MOV 0x40, A;	//storing in output

	

END






///////Change Input values to actual one but same code



; -----------------------------------------------------------
; Microcontroller Based Systems Homework
; Author name: Iqbal Daud
; Neptun code: X32SQC
; -------------------------------------------------------------------
; Task description: 
;   Multiplication of two 16-bit unsigned integers being in the internal memory. 
;   The result should be a 32-bit unsigned integer.
;   Inputs: Operand and result addresses (pointers)
;   Output: Result starting at the given address
; -------------------------------------------------------------------


; Definitions
; -------------------------------------------------------------------

; Address symbols for creating pointers

INPUT1_ADR  EQU 0x20
INPUT2_ADR  EQU 0x30
OUTPUT_ADR  EQU 0x40


; Test data for input parameters
; (Try also other values while testing your code.)

; Input 1: 300 (Hexadecimal: 0x012C)
INPUT1_H    EQU 0x01    ; High byte
INPUT1_L    EQU 0x2C    ; Low byte

; Input 2: 400 (Hexadecimal: 0x0190)
INPUT2_H    EQU 0x01    ; High byte
INPUT2_L    EQU 0x90    ; Low byte


; Interrupt jump table
ORG 0x0000;
    SJMP  MAIN                  ; Reset vector

; Beginning of the user program
ORG 0x0033

; -------------------------------------------------------------------
; MAIN program
; -------------------------------------------------------------------
; Purpose: Prepare the inputs and call the multiplication subroutine
; -------------------------------------------------------------------

MAIN:

    ; Prepare input parameters for the subroutine

    MOV R0,  #INPUT1_ADR    ; Initialize operand 1 in the internal data memory
    MOV @R0, #INPUT1_H      ; (big endian: high byte to low address)
    INC R0                  ; Increment R0 to point to the low byte of operand 1
    MOV @R0, #INPUT1_L      ; Store low byte at next address

    MOV R1,  #INPUT2_ADR    ; Initialize operand 2 in the internal data memory
    MOV @R1, #INPUT2_H      ; (big endian: high byte to low address)
    INC R1                 ; Increment R1 to point to the low byte of operand 2
    MOV @R1, #INPUT2_L      ; Store low byte at next address

    MOV R0, #INPUT1_ADR     ; Set R0 to the address of operand 1
    MOV R1, #INPUT2_ADR     ; Set R1 to the address of operand 2
    MOV R2, #OUTPUT_ADR     ; Set R2 to the address for storing the 32-bit result

; Infinite loop: Call the subroutine repeatedly
LOOP:

    CALL MUL_U16

    SJMP  LOOP




; ===================================================================           
;                           SUBROUTINE(S)
; ===================================================================           


; -------------------------------------------------------------------
; MUL_U16
; -------------------------------------------------------------------
; Purpose: Multiplication of two 16-bit unsigned integers
; -------------------------------------------------------------------
; INPUT(S):
;   R0 - Address of operand 1 (big endian)
;   R1 - Address of operand 2 (big endian)
;   R2 - Address of 32-bit result (big endian)
; OUTPUT(S): 
;   Result at the given address (32-bit result)
; MODIFIES:
;		A, B, R3, R4 
; -------------------------------------------------------------------


MUL_U16:


	MOV A, 0x21;	//Moving Lower Byte from input 1 to Accumulator
	MOV B, 0x31;	//Moving Lower Byte from Input 2 to B
	MUL AB;			//Multiplication
	MOV 0x43, A;	//Moving Result in Accumulator to Output Address
	MOV R2, B;		//Storing in R2 for later calculations
	MOV A, 0x20;	//Storing the next byte for multiplication in order
	MOV B, 0x30;
	MUL AB;
	MOV R3, A;		//Storing for later calculation
	MOV R4, B;		//Same
	MOV A, 0x20;	//Moving next byte in order to Accumulator
	MOV B, 0x31;
	MUL AB;	
	ADD A, R2;		//Adding Previously Stored byte to Accumulator Value
	MOV R2, A;		//Storing that sum in R2 for later use
	MOV A,B;		//Moved result of B to Accumulator to add the other byte
	ADDC A, R3;		//Added carry from previous addition to value stored in A and R3, and stored in A
	MOV R3, A;		//Stored the result in R3 
	MOV A, R4;		//Moving value stored in R4 to accumulator
	ADDC A, #00H; 	//This instruction is used to add carry in the accumulartor if any, in case there is not C=1 a 0 is added to A anyways.
	MOV R4, A;		//Storing Accumulator value in R4
	MOV A, 0x21;	//Multiplication Steps..
	MOV B, 0x30;
	MUL AB;
	ADD A, R2;		//Addition
	MOV 0x42, A;	//Storing accumulator result at output address
	MOV A, B;
	ADDC A, R3;		//Carry bit
	MOV 0x41, A;	//Storing in Output
	MOV A, R4;		
	ADDC A, #00H;	//Adding carry bit
	MOV 0x40, A;	//storing in output


END