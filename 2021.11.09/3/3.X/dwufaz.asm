; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
; Assembly source line config statements

#include "p16f877a.inc"

; CONFIG
; __config 0x3FFB
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _BOREN_ON & _LVP_ON & _CPD_OFF & _WRT_OFF & _CP_OFF
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program
 

START
 bcf STATUS, RP1
 bsf STATUS, RP0
 
 clrf TRISC
 bsf TRISC, 5
 bsf TRISC, 6
 bsf TRISC, 7
 
 clrf TRISA
  
 bcf STATUS, RP1
 bcf STATUS, RP0
 
; clrf PORTC
 
 clrf PORTA
 bsf PORTA, 0
 
; clrf PORTC
 
 PETLA_GLOWNA
; btfsc PORTC, 5
; btfsc PORTC, 6
; call ZMIANA_PREDKOSCI
 btfsc PORTC, 7
 goto ZMIANA_PREDKOSCI
 btfsc PORTC, 5
 call KREC_W_LEWO
 btfsc PORTC, 6
 call KREC_W_PRAWO
; clrf PORTC 
 goto PETLA_GLOWNA

 
 KREC_W_LEWO
 bcf PORTC, 3
 bcf PORTC, 4
 bsf PORTC, 1
 bsf PORTC, 2
 call przerywnik
 bcf PORTC, 1
 bcf PORTC, 4
 bsf PORTC, 2
 bsf PORTC, 3
 call przerywnik
 bcf PORTC, 1
 bcf PORTC, 2
 bsf PORTC, 3
 bsf PORTC, 4
 call przerywnik
 bcf PORTC, 2
 bcf PORTC, 3
 bsf PORTC, 1
 bsf PORTC, 4
 call przerywnik
 return
 
 KREC_W_PRAWO
 bcf PORTC, 2
 bcf PORTC, 1
 bsf PORTC, 4
 bsf PORTC, 3
 call przerywnik
 bcf PORTC, 1
 bcf PORTC, 4
 bsf PORTC, 3
 bsf PORTC, 2
 call przerywnik
 bcf PORTC, 4
 bcf PORTC, 3
 bsf PORTC, 2
 bsf PORTC, 1
 call przerywnik
 bcf PORTC, 3
 bcf PORTC, 2
 bsf PORTC, 1
 bsf PORTC, 4
 call przerywnik
 return
 
 
 ZMIANA_PREDKOSCI
 btfsc PORTA, 2
 goto zmiana_1
 btfsc PORTA, 1
 goto zmiana_3
 btfsc PORTA, 0
 goto zmiana_2
 
 
 
 zmiana_1
 bsf PORTA, 0
 bcf PORTA, 1
 bcf PORTA, 2
 goto PETLA_GLOWNA
 
 zmiana_2
 bsf PORTA, 0
 bsf PORTA, 1
 bcf PORTA, 2
 goto PETLA_GLOWNA
 
 zmiana_3
 bsf PORTA, 0
 bsf PORTA, 1
 bsf PORTA, 2
 goto PETLA_GLOWNA
 
 
 
przerywnik
    btfsc PORTA, 0
    movlw 0xff
    btfsc PORTA, 1
    movlw 0xff
    btfsc PORTA, 2
    movlw 0x01
    movwf 0x25
    goto lp1
powrot
    return
lp1
    
    btfsc PORTA, 0
    movlw 0xff
    btfsc PORTA, 1
    movlw 0x01
    btfsc PORTA, 2
    movlw 0x01
    movwf 0x26
    decf 0x25
    btfsc STATUS, Z
    goto powrot
    
lp2
    decf 0x26
    btfsc STATUS, Z
    goto lp1
    goto lp2
 
    GOTO $                          ; loop forever

    END