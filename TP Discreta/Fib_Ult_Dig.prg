* Determina el ultimo digito del elemento elegido de la Sucesion de Fibonacci.

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Sucesion de Fibonacci")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE nRes AS NUMERIC
PRIVATE cElem AS NUMERIC
PRIVATE xNumIng := 100
PRIVATE nNum_1 := 0
PRIVATE nNum_2 := 1

WHILE .T.
	@ 4,2 SAY "Numero de elemento" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumIng > 2
		EXIT
	ENDIF
	ALERT( "El numero tiene que ser mayor a 2" )
END

@ 4,2 CLEAR TO 4,99

FOR cElem := 2 TO xNumIng
	nRes = (nNum_1 + nNum_2) % 10
	nNum_1 = nNum_2
	nNum_2 = nRes
NEXT

@ 4,2 SAY "El ultimo digito del elemento numero " + NUMTRIM(xNumIng) + " es " + NUMTRIM(nRes)
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pNum)
	pNum = LTRIM(STR(INT(pNum)))
RETURN pNum