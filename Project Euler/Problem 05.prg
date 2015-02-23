/*

URL: https://projecteuler.net/problem=5

// English:

What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?


// Español:

¿Cuál es el menor número positivo que es divisible entre todos los números del 1 al 20?

*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 05")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cDiv AS NUMERIC
PRIVATE nAux AS NUMERIC
PRIVATE xNumIng := 20
PRIVATE aRes := 1

WHILE .T.
	@ 3,2 SAY "Numero a verificar" GET xNumIng
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

FOR cDiv := 2 TO xNumIng
	IF IS_PRIME(cDiv)
		nAux = cDiv
		WHILE nAux <= xNumIng
			aRes *= cDiv
			nAux *= cDiv
		END
	ENDIF
NEXT

@ 6,2 SAY "El resultado es " + NUMTRIM(aRes)
INKEY(0)
CLEAR




FUNCTION IS_PRIME(pnNum)
	LOCAL cDiv AS NUMERIC
	LOCAL nRaiz := INT(SQRT(pnNum))
	LOCAL bRes := .T.
	
	FOR cDiv := 2 TO nRaiz
		IF (pnNum % cDiv) = 0
			bRes = .F.
			EXIT
		ENDIF
	END
	
RETURN bRes



FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
