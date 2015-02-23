* Suma todos los números naturales menores a mil que sean múltiplos de 3 o 5.

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 01")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cNum AS NUMERIC
PRIVATE nRes := 0
PRIVATE xNumIng := 1000

WHILE .T.
	@ 3,2 SAY "Numero a verificar" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumIng > 3
		EXIT
	ENDIF
	ALERT( "El numero tiene que ser mayor a 3" )
END

@ 6,2 SAY "Verificando numero"
@ 8,2 SAY "El resultado es"
FOR cNum := 2 TO (xNumIng - 1)
	IF (cNum % 3 = 0) .OR. (cNum % 5 = 0)
		nRes += cNum
		@ 6,21 SAY cNum
		@ 8,21 SAY nRes
	ENDIF
NEXT
@ 6,21 SAY cNum

INKEY(0)
CLEAR



FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
