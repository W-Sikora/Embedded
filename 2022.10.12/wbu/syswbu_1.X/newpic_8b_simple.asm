#include "p16f877a.inc"

; CONFIG
; __config 0xFFFB
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _BOREN_ON & _LVP_ON & _CPD_OFF & _WRT_OFF & _CP_OFF
; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START
    MOVLW 0x00 
    BCF STATUS, RP1
    BSF STATUS, RP0
    MOVWF TRISA
    BCF STATUS, RP0
    BCF STATUS, RP1
    MOVLW 0xff
    MOVWF PORTA
    GOTO $                          ; loop forever
    
    END