/*

URL: https://projecteuler.net/problem=3

// English:

The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?

// Español:

Los factores primos de 13.195 son 5, 7, 13 y 29.

¿Cuál es el factor primo más grande del número 600851475143?

*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 03")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE nRaiz AS NUMERIC
PRIVATE nRes AS NUMERIC
PRIVATE nMax AS NUMERIC
PRIVATE cDiv := 1
PRIVATE xNumIng := 600851475143

WHILE .T.
	@ 3,2 SAY "Numero a verificar" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	@ 3,2 CLEAR TO 3,99
	IF xNumIng > 1
		EXIT
	ENDIF
	ALERT( "El numero tiene que ser mayor a 1" )
END

* Por si el numero es primo.
nMax = xNumIng

nRaiz = SQRT(xNumIng)
FOR cDiv := 2 TO nRaiz
	IF (xNumIng % cDiv) = 0
		nRes = xNumIng / cDiv
		IF IS_PRIME(nRes)
			nMax = nRes
			EXIT
		ENDIF
		IF IS_PRIME(cDiv)
			nMax = cDiv
		ENDIF
	ENDIF
NEXT

@ 3,2 SAY "El resultado es " + NUMTRIM(nMax)
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
