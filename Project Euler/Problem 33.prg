/*	La fracción 49/98 puede simplificarse como 49/98 = 4/8, mediante la cancelación de 
	los 9s. Hay cuatro ejemplos de este tipo de fracción, con un valor inferior a 1, y 
	con dos dígitos en el numerador y el denominador. Si el producto de estas cuatro 
	fracciones está simplificado, halla el valor de su denominador.						*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 33")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cNum AS NUMERIC
PRIVATE cDen AS NUMERIC
PRIVATE nRes AS NUMERIC
PRIVATE nResSim AS NUMERIC
PRIVATE nAux AS NUMERIC
PRIVATE nAuxNum AS NUMERIC
PRIVATE nAuxDen AS NUMERIC
PRIVATE cRes := 0
PRIVATE aNum := 1
PRIVATE aDen := 1
PRIVATE vNum[2]
PRIVATE vDen[2]
PRIVATE vRes[4]

@ 2,2 SAY "Numerador"
@ 3,2 SAY "Denominador"
FOR cNum := 10 TO 98
	@ 2,14 SAY cNum
	vNum[1] = cNum % 10
	vNum[2] = INT(cNum / 10)
	FOR cDen := (cNum + 1) TO 99
		@ 3,14 SAY cDen
		nResSim = 0
		nRes = cNum / cDen
		vDen[1] = cDen % 10
		vDen[2] = INT(cDen / 10)
		IF vNum[1] = vDen[2]
			nAuxNum = 2
			nAuxDen = 1
			nResSim = vNum[nAuxNum] / vDen[nAuxDen]
		ELSEIF vNum[2] = vDen[1]
			nAuxNum = 1
			nAuxDen = 2
			nResSim = vNum[nAuxNum] / vDen[nAuxDen]
		ELSEIF vNum[2] = vDen[2]
			nAuxNum = 1
			nAuxDen = 1
			nResSim = vNum[nAuxNum] / vDen[nAuxDen]
		ELSEIF (vNum[1] = vDen[1]) .AND. (vNum[1] <> 0)
			nAuxNum = 2
			nAuxDen = 2
			nResSim = vNum[nAuxNum] / vDen[nAuxDen]
		ENDIF
		IF nRes = nResSim
			++cRes
			aNum *= vNum[nAuxNum]
			aDen *= vDen[nAuxDen]
			@ (5 + cRes),2 SAY NUMTRIM(vNum[2]) + NUMTRIM(vNum[1]) + "/" + NUMTRIM(vDen[2]) + NUMTRIM(vDen[1]) + " = " + NUMTRIM(vNum[nAuxNum]) + "/" + NUMTRIM(vDen[nAuxDen]) + " = " + LTRIM(STR(nRes))
		ENDIF
	NEXT
NEXT

nAux = aDen / aNum
IF nAux <> INT(nAux)
	nAux = aDen
ENDIF
@ 24,2 SAY "El resultado es " + NUMTRIM(nAux)
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
