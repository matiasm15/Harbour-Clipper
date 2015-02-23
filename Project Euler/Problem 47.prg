/*

URL: https://projecteuler.net/problem=47

// English:

Find the first four consecutive integers to have four distinct prime factors.
What is the first of these numbers?

// Español:

Encuentra los cuatro primeros enteros consecutivos en tener cuatro factores primos distintos.
¿Cuál es el primero de estos números?

*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 47")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE nRes AS NUMERIC
PRIVATE nDivAnt AS NUMERIC
PRIVATE cAux AS NUMERIC
PRIVATE cDiv AS NUMERIC
PRIVATE sDiv AS CHARACTER
PRIVATE cPrm := 0
PRIVATE cNum := 1
PRIVATE cNumSig := 0
PRIVATE xNumIng := 4
PRIVATE vPrm := {}
PRIVATE bPas := .T.

WHILE .T.
	@ 3,2 SAY "Numero a verificar" GET xNumIng
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

DECLARE vDiv[xNumIng]

@ 6,2 SAY "Verificando numero:"
WHILE cNumSig <> xNumIng
	@ 6,22 SAY ++cNum
	IF IS_PRIME(cNum)
		++cPrm
		cNumSig = 0
		AADD(vPrm,cNum)
		AFILL(vDiv,"")
	ELSE
		nDivAnt = 0
		cAux = 0
		cDiv = 1
		nRes = cNum
		sDiv = ""
		WHILE .T.
			IF (nRes % vPrm[cDiv]) = 0
				nRes /= vPrm[cDiv]
				sDiv += "x" + NUMTRIM(vPrm[cDiv])
				IF vPrm[cDiv] <> nDivAnt
					IF ++cAux = xNumIng
						bPas = .F.
						vDiv[++cNumSig] = sDiv
						EXIT
					ENDIF
				ENDIF
				nDivAnt = vPrm[cDiv]
			ELSEIF ++cDiv > cPrm
				cNumSig = 0
				AFILL(vDiv, "")
				EXIT
			ENDIF
		END
	ENDIF

END

@ 6,0 CLEAR TO 6,99
@ 6,2 SAY "El resultado es "
FOR cAux := 1 TO (xNumIng)
	vDiv[cAux] = SUBSTR(vDiv[cAux], 2, (LEN(vDiv[cAux]) - 1))
	? "  " + NUMTRIM(cNum - xNumIng + cAux) + " = " + vDiv[cAux]
NEXT
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
