# 2021.10.12

## Info
- programy: PICSmLab, MPLAB
- [dokumentacja](https://ww1.microchip.com/downloads/en/devicedoc/39582b.pdf)
- lista instrukcji: rozdział 15 dokumentacji (str. 162)
- mikrokontroler: PIC16F877A
  
## Zadanie do realizacji (termin: 19.10.21)
**Zestaw A**  
Bloki: LEDs, Push buttons.  
Opis sterownika: diody mają migać zgodnie z zadanym wzorcem.  
Migać, czyli kolejno świecić i gasnąć.  
Wzorce są wybierane przyciskami i są jak następuje (numery diód):  
- 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, ... itd.
- 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 2, ... itd.
- 1, 3, 5, 7, 2, 4, 6, 8, 1, 3, 5, 7, ... itd.
- (1, 2), (2, 3), (3, 4), ..., (7, 8), (8, 1), (1, 2), ... itd.
- i wszystkie w drugą stronę (czyli np. 8, 7, 6, 5, ... itd.).  
**Razem 8 wzorców**.  
W nawiasach mamy kombinacje diód do jednoczesnego mignięcia.  
**Prędkość migania 1s** (czyli co sekundę kolejna dioda lub grupa diód).

## Wskazówki
-  [materiały z wykładu](#)
