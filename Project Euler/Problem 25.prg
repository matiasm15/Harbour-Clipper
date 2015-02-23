/*

URL: https://projecteuler.net/problem=25

// English:

What is the first term in the Fibonacci sequence to contain 1000 digits?

// Español:

¿Cuál es el primer término de la sucesión de Fibonacci en contener 1000 dígitos?

*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 25")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cElem AS NUMERIC
PRIVATE cTerm AS NUMERIC
PRIVATE vAux AS LOGICAL
PRIVATE xNumIng := 1000

WHILE .T.
	@ 4,2 SAY "Cantidad de digitos" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumIng > 1
		EXIT
	ENDIF
	ALERT( "El numero tiene que ser mayor a 1" )
END

PRIVATE aNum_1[xNumIng],aNum_2[xNumIng]
PRIVATE aRes[xNumIng]

cTerm = 1
AFILL(aRes, 0)
AFILL(aNum_1, 0)
AFILL(aNum_2, 0)
aNum_2[1] = 1

@ 6,2 SAY "Digitos:"
@ 7,2 SAY "Terminos:"

WHILE aRes[xNumIng] = 0
	vAux = .F.
	FOR cElem := 1 TO xNumIng
		aRes[cElem] = aNum_1[cElem] + aNum_2[cElem]
		IF vAux
			++aRes[cElem]
		ENDIF
		IF aRes[cElem] > 9
			vAux = .T.
			aRes[cElem] %= 10
		ELSE
			vAux = .F.
		ENDIF
	NEXT
	ACOPY(aNum_2, aNum_1)
	ACOPY(aRes, aNum_2)

	FOR cElem = xNumIng TO 1 STEP -1
		IF aRes[cElem] = 0
			EXIT
		ENDIF
	NEXT
	@ 6,11 SAY cElem	
	@ 7,11 SAY ++cTerm

END

@ 9,2 SAY "El primer termino con " + NUMTRIM(xNumIng) + " digitos es " + NUMTRIM(cTerm)
INKEY(0)
CLEAR



FUNCTION NUMTRIM(pNum)
	pNum = LTRIM(STR(INT(pNum)))
RETURN pNum
