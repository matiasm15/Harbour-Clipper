/* Tras 40755, ¿cuál es el siguiente número triangular que es también pentagonal y hexagonal?						*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 45")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE nTrg AS NUMERIC
PRIVATE nPnt AS NUMERIC
PRIVATE nRes AS NUMERIC
PRIVATE nSeg AS NUMERIC
PRIVATE cNum AS NUMERIC
PRIVATE cRes := 0
PRIVATE cElem := 1
PRIVATE vTrg := {}
PRIVATE vPnt := {}
PRIVATE vHxg := {}
PRIVATE vRes[3]

AFILL(vRes,0)
nSeg = SECONDS()

@ 6,2 SAY "Llenando vectores:"
@ 7,2 SAY "Verificando numeros:"
WHILE cRes <> 3
	FOR cNum := cElem TO (cElem + 99999)
		@ 6,23 SAY cNum
		AADD(vTrg,(cNum * (cNum + 1) / 2))
		AADD(vPnt,(cNum * (3 * cNum - 1) / 2))
		AADD(vHxg,(cNum * (2 * cNum - 1)))
	NEXT
	cElem = cNum
	
	FOR cNum := 1 TO (cElem - 1)
		@ 7,23 SAY cNum
		nRes = vHxg[cNum]
		nTrg = ASCAN(vTrg,nRes)
		nPnt = ASCAN(vPnt,nRes)
		IF (nTrg <> 0) .AND. (nPnt <> 0) .AND. (nPnt <> 0) .AND. (ASCAN(vRes,nRes) = 0)
			vRes[++cRes] = nRes
			@ (8 + cRes),2 SAY " " + NUMTRIM(vHxg[cNum]) + " = T(" + NUMTRIM(nTrg) + ") = P(" + NUMTRIM(nPnt) + ") = H(" + NUMTRIM(cNum) + ")"
			IF cRes = 3
				EXIT
			ENDIF
		ENDIF
	NEXT
END

nSeg = SECONDS() - nSeg
@ 24,2 SAY "La operacion se realizo en " + LTRIM(STR(nSeg)) + " segundos" COLOR "G+"
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
