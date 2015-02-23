#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Sucesion de Fibonacci modulo n")
SET CURSOR OFF
CLEAR

PRIVATE nAux_1,nAux_2 AS NUMERIC
PRIVATE cElem AS NUMERIC
PRIVATE nRes := 0
PRIVATE nNum_1 := 1
PRIVATE nNum_2 := 1
PRIVATE xNumIng := 6

SET KEY 28 TO TECLAF1
WHILE .T.
	@ 4,2 SAY "Modulo" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumIng > 2
		EXIT
	ENDIF
	@ 6,2 SAY "El numero tiene que ser mayor a 2" COLOR "R+"
END
SET KEY 28 TO

CLEAR
nAux_1 = xNumIng * xNumIng
nAux_2 = nAux_1 * 2
DECLARE aVec[nAux_1]
DECLARE aSuc[nAux_2]
aSuc[1] = nNum_1
aSuc[2] = nNum_2

FOR cElem := 3 TO nAux_2
	aSuc[cElem] := (nNum_1 + nNum_2) % xNumIng
	nNum_1 = nNum_2
	nNum_2 = aSuc[cElem]
NEXT

nRes = 0
cElem = 0
WHILE nRes < 1
	++cElem
	IF cElem = nAux_1
		nRes = 2
	ELSE
		aVec[cElem] = aSuc[cElem]
		? " " + NUMTRIM(aVec[cElem])
		nRes = 0
		nNum_1 = 0
		nNum_2 = 0
		WHILE nRes = 0
			nNum_1 %= cElem
			++nNum_1
			++nNum_2
			IF aVec[nNum_1] # aSuc[nNum_2]
				nRes = -1
			ELSEIF nNum_2 = nAux_2
				nRes = 1
			ENDIF
		END
	ENDIF
END

?
IF nRes = 1
	? " La sucesion tiene " + NUMTRIM(cElem) + " elementos"
ELSE
	? " No se pudo encontrar la sucesion"
ENDIF
INKEY(0)
CLEAR



FUNCTION NUMTRIM(pNum)
	pNum = LTRIM(STR(INT(pNum)))
RETURN pNum



PROCEDURE TECLAF1
	STATIC sPaso := .T.
	IF sPaso
		sPaso = .F.
		@ 24,1 SAY "Realizado por Matias Mangiantini" COLOR "G+"
	ELSE
		sPaso = .T.
		@ 24,0 CLEAR TO 24,95
	ENDIF
RETURN