/*

URL: https://projecteuler.net/problem=50

// English:

Which prime, below one-million, can be written as the sum of the most consecutive primes?

// Español:

¿Qué primo, inferior a un millón, puede escribirse como la suma de más números primos consecutivos?

*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 50")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE aNum AS NUMERIC
PRIVATE cElem AS NUMERIC
PRIVATE nMaxNum := 0
PRIVATE nMaxElem := 0
PRIVATE nLim := 1
PRIVATE cPun := 1
PRIVATE cNum := 3
PRIVATE cNumPrim := 1
PRIVATE xNumIng := 1000000
PRIVATE vNum := {2}

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

@ 24,2 SAY "Generando numeros primos" COLOR "G+"
WHILE xNumIng > cNum
	IF PRIMO(cNum)
		++cNumPrim
		AADD(vNum,cNum)
	ENDIF
	cNum += 2
END

@ 24,0 CLEAR TO 24,99
@ 24,2 SAY "Sumando numeros primos" COLOR "G+"
WHILE nLim > nMaxElem
	aNum = 0
	cNum = cPun
	WHILE cNum < cNumPrim
		aNum += vNum[cNum]
		cElem = cNum - cPun + 1
		IF aNum >= xNumIng
			EXIT
		ELSEIF PRIMO(aNum) .AND. (cElem > nMaxElem)
			nMaxNum = aNum
			nMaxElem = cElem
		ENDIF
		++cNum
	END
	nLim = cNumPrim - cPun
	++cPun
END

@ 24,0 CLEAR TO 24,99
@ 6,2 SAY "El numero es " + NUMTRIM(nMaxNum) + " y es la suma de " + NUMTRIM(nMaxElem) + " numeros primos"
INKEY(0)
CLEAR




FUNCTION PRIMO(pnNum)
	LOCAL cDiv AS NUMERIC
	LOCAL nRaiz AS NUMERIC
	LOCAL bRes := .T.
	nRaiz = INT(SQRT(pnNum))
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