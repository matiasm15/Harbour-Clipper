* Determina el resto de dividir la base (A) a la potencia (B) modulo (C).

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Potencia y Modulo")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE nRes AS NUMERIC
PRIVATE cPot AS NUMERIC
PRIVATE xBase := 5
PRIVATE xPot := 50
PRIVATE xMod := 30

WHILE .T.
	@ 4,2 SAY "Base"
	@ 5,2 SAY "Potencia"
	@ 6,2 SAY "Modulo"
	@ 4,11 GET xBase
	@ 5,11 GET xPot
	@ 6,11 GET xMod
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xPot > 0 .AND. xMod > 1
		EXIT
	ENDIF
	ALERT( "Los numeros tienen que ser mayores a 1" )
END

nRes = xBase % xMod
@ 4,2 CLEAR TO 6,99

FOR cPot := 2 TO xPot
	nRes = (nRes * xBase) % xMod
NEXT
IF nRes < 0
	nRes += xMod
ENDIF

@ 4,2 SAY NUMTRIM(xBase) + " elevado a " + NUMTRIM(xPot)  + " modulo " + NUMTRIM(xMod) + " es " + NUMTRIM(nRes)
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pNum)
	pNum = LTRIM(STR(INT(pNum)))
RETURN pNum