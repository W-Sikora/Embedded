; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
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
    clrf TRISB
    movlw 0xff
    movwf TRISC 
    bcf STATUS, RP0
    bcf STATUS, RP1
    clrf 0x20
    
PETLAGOWNA
    btfsc PORTC, 0
    goto USTAWW1
    btfsc PORTC, 1
    goto USTAWW2
    btfsc PORTC, 2
    goto USTAWW3
    btfsc PORTC, 3
    goto USTAWW4
    btfsc PORTC, 4
    goto USTAWW5
    btfsc PORTC, 5
    goto USTAWW6
    btfsc PORTC, 6
    goto USTAWW7
    btfsc PORTC, 7
    goto USTAWW8
POWROT
    btfsc 0x20, 0
    goto WZOR1
    btfsc 0x20, 1
    goto WZOR2
    btfsc 0x20, 2
    goto WZOR3
    btfsc 0x20, 3
    goto WZOR4
    btfsc 0x20, 4
    goto WZOR5
    btfsc 0x20, 5
    goto WZOR6
    btfsc 0x20, 6
    goto WZOR7
    btfsc 0x20, 7
    goto WZOR8
    goto PETLAGOWNA
        
WZOR1
POWROTWZOR1
    movf 0x25, W
    movwf PORTB
    RLF 0x25
    decf 0x24
    btfsc STATUS, Z
    goto PRZESKOKWZOR1
POWROTWZOR1_2
    goto PRZERWAWZOR1

WZOR2
LOOPWZOR2
    movf 0x24, W
    movwf PORTB
    goto PRZERWAWZOR2_1
POWROTWZOR2_1
    RlF 0x25
    movf 0x25, W
    movwf PORTB
    decf 0x23
    btfsc STATUS, Z
    goto PRZESKOKWZOR2
POWROTWZOR2PRZESKOK
    goto PRZERWAWZOR2_2

    
WZOR3
    movf 0x25, W
    movwf PORTB
    rlf 0x25
    rlf 0x25
    decf 0x23
    btfsc STATUS, Z
    goto PRZESKOKWZOR3
POWROTWZOR3PRZESKOK
    goto PRZERWAWZOR3

    
WZOR4
LOOPWZOR4
    movf 0x24, W
    iorwf 0x25, 0
    movwf PORTB
    goto PRZERWAWZOR4
POWROTWZOR4
    rlf 0x24,1
    decf 0x22
    btfsc STATUS, Z
    goto PRZESKOKWZOR4_1
POWROTWZOR4PRZESKOK_1
    rlf 0x25,1
    decf 0x23
    btfsc STATUS, Z
    goto PRZESKOKWZOR4_2
POWROTWZOR4PRZESKOK_2
    goto PETLAGOWNA

WZOR5
POWROTWZOR5
    movf 0x25, W
    movwf PORTB
    RrF 0x25
    decf 0x24
    btfsc STATUS, Z
    goto PRZESKOKWZOR5
POWROTWZOR5_2
    goto PRZERWAWZOR5
   
WZOR6
LOOPWZOR6
    movf 0x24, W
    movwf PORTB
    goto PRZERWAWZOR6_1
POWROTWZOR6_1
    movf 0x25, W
    movwf PORTB
    RRF 0x25
    decf 0x23
    btfsc STATUS, Z
    goto PRZESKOKWZOR6
POWROTWZOR6PRZESKOK
    goto PRZERWAWZOR6_2
    
WZOR7
    movf 0x25, W
    movwf PORTB
    rrf 0x25
    rrf 0x25
    decf 0x23
    btfsc STATUS, Z
    goto PRZESKOKWZOR7
POWROTWZOR7PRZESKOK
    goto PRZERWAWZOR7
    
WZOR8
LOOPWZOR8
    movf 0x24, W
    iorwf 0x25, 0
    movwf PORTB
    goto PRZERWAWZOR8
POWROTWZOR8
    rrf 0x24,1
    decf 0x22
    btfsc STATUS, Z
    goto PRZESKOKWZOR8_1
POWROTWZOR8PRZESKOK_1
    rrf 0x25,1
    decf 0x23
    btfsc STATUS, Z
    goto PRZESKOKWZOR8_2
POWROTWZOR8PRZESKOK_2
    goto PETLAGOWNA

    
PRZERWAWZOR1
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO PETLAGOWNA

PRZERWAPRZERWA1
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR1
    GOTO PRZERWAPRZERWA1

PRZERWAWZOR2_1
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO POWROTWZOR2_1

PRZERWAPRZERWA2_1
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR2_1
    GOTO PRZERWAPRZERWA2_1
    
PRZERWAWZOR2_2
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO PETLAGOWNA

PRZERWAPRZERWA2_2
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR2_2
    GOTO PRZERWAPRZERWA2_2
    
PRZERWAWZOR3
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO PETLAGOWNA

PRZERWAPRZERWA3
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR3
    GOTO PRZERWAPRZERWA3    
    
PRZERWAWZOR4
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO POWROTWZOR4

PRZERWAPRZERWA4
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR4
    GOTO PRZERWAPRZERWA4    

    
PRZERWAWZOR5
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO PETLAGOWNA

PRZERWAPRZERWA5
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR5
    GOTO PRZERWAPRZERWA5    

    
PRZERWAWZOR6_1
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO POWROTWZOR6_1

PRZERWAPRZERWA6_1
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR6_1
    GOTO PRZERWAPRZERWA6_1    

    
PRZERWAWZOR6_2
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO PETLAGOWNA

PRZERWAPRZERWA6_2
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR6_2
    GOTO PRZERWAPRZERWA6_2    

    
PRZERWAWZOR7
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO PETLAGOWNA

PRZERWAPRZERWA7
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR7
    GOTO PRZERWAPRZERWA7    

   
PRZERWAWZOR8
    MOVLW 0xff
    MOVWF 0x27
    DECF 0x26
    BTFSC STATUS, Z
    GOTO POWROTWZOR8

PRZERWAPRZERWA8
    DECF 0x27
    BTFSC STATUS, Z
    GOTO PRZERWAWZOR8
    GOTO PRZERWAPRZERWA8    
 
USTAWW1
    clrf 0x20
    bsf 0x20, 0
    movlw 0x01
    movwf 0x25
    movlw 0x08
    movwf 0x24
    goto POWROT
USTAWW2
    clrf 0x20
    bsf 0x20, 1
    movlw 0x01
    movwf 0x25
    movlw 0x01
    movwf 0x24
    movlw 0x07
    movwf 0x23
    goto POWROT
USTAWW3
    clrf 0x20
    bsf 0x20, 2
    movlw 0x01
    movwf 0x25
    movlw 0x04
    movwf 0x23
    goto POWROT
USTAWW4
    clrf 0x20
    bsf 0x20, 3
    movlw 0x01
    movwf 0x24
    movlw 0x02
    movwf 0x25
    movlw 0x08
    movwf 0x22
    movlw 0x07
    movwf 0x23
    goto POWROT
USTAWW5
    clrf 0x20
    bsf 0x20, 4
    movlw 0x80
    movwf 0x25
    movlw 0x08
    movwf 0x24
    goto POWROT
USTAWW6
    clrf 0x20
    bsf 0x20, 5
    movlw 0x80
    movwf 0x25
    movlw 0x01
    movwf 0x24
    movlw 0x07
    movwf 0x23
    goto POWROT
USTAWW7
    clrf 0x20
    bsf 0x20, 6
    movlw 0x80
    movwf 0x25
    movlw 0x04
    movwf 0x23
    goto POWROT
USTAWW8
    clrf 0x20
    bsf 0x20, 7
    movlw 0x80
    movwf 0x24
    movlw 0x40
    movwf 0x25
    movlw 0x08
    movwf 0x22
    movlw 0x07
    movwf 0x23
    goto POWROT
    
PRZESKOKWZOR1
    rlf 0x25
    movlw 0x08
    movwf 0x24
    goto POWROTWZOR1_2

PRZESKOKWZOR2
    rlf 0x25
    rlf 0x25
    movlw 0x07
    movwf 0x23
    goto POWROTWZOR2PRZESKOK
    

PRZESKOKWZOR3
    rlf 0x25
    rlf 0x25
    movlw 0x08
    movwf 0x23
    goto POWROTWZOR3PRZESKOK
    
PRZESKOKWZOR4_1
    rlf 0x24
    movlw 0x08
    movwf 0x22
    goto POWROTWZOR4PRZESKOK_1

PRZESKOKWZOR4_2
    rlf 0x25
    movlw 0x08
    movwf 0x23
    goto POWROTWZOR4PRZESKOK_2

PRZESKOKWZOR5
    rrf 0x25
    movlw 0x08
    movwf 0x24
    goto POWROTWZOR5_2
    
PRZESKOKWZOR6
    rrf 0x25
    rrf 0x25
    movlw 0x07
    movwf 0x23
    goto POWROTWZOR6PRZESKOK
    
PRZESKOKWZOR7
    rrf 0x25
    rrf 0x25
    movlw 0x08
    movwf 0x23
    goto POWROTWZOR7PRZESKOK
    
    
PRZESKOKWZOR8_1
    rrf 0x24
    movlw 0x08
    movwf 0x22
    goto POWROTWZOR8PRZESKOK_1

PRZESKOKWZOR8_2
    rrf 0x25
    movlw 0x08
    movwf 0x23
    goto POWROTWZOR8PRZESKOK_2

    
    GOTO $                          ; loop forever
    END