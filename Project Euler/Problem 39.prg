/*	Si p es el perímetro de un triángulo rectángulo con lados de longitud entera, {a,b,c}.
	¿Para qué valor de p <= 1000, hay un mayor número de soluciones?						*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 39")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cNum AS NUMERIC
PRIVATE cSol AS NUMERIC
PRIVATE nRes AS NUMERIC
PRIVATE nHip AS NUMERIC
PRIVATE nCat_1 AS NUMERIC
PRIVATE nCat_2 AS NUMERIC
PRIVATE nMaySol AS NUMERIC
PRIVATE cMaySol := 0
PRIVATE xNumIng := 1000

WHILE .T.
	@ 3,2 SAY "Numero a verificar" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumIng > 5
		EXIT
	ENDIF
	ALERT( "El numero tiene que ser mayor a 5" )
END

@ 3,2 CLEAR TO 3,99
@ 3,2 SAY "Verificando numero"

cNum = xNumIng

FOR cNum := 3 TO xNumIng
	cSol = 0
	FOR nCat_1 := 1 TO cNum
		FOR nCat_2 := 1 TO nCat_1
			nHip = SQRT(nCat_1 * nCat_1 + nCat_2 * nCat_2)
			IF (nHip + nCat_1 + nCat_2) = cNum
				++cSol
			ENDIF
		NEXT
	NEXT
	IF cSol > cMaySol
		cMaySol = cSol
		nMaySol = cNum
	ENDIF
	@ 3,21 SAY cNum
NEXT

@ 5,2 SAY "El resultado es " + NUMTRIM(nMaySol) + " con " + NUMTRIM(cMaySol) + " soluciones"
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
