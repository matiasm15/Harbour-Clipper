/*	Un número irracional es creado concatenando enteros positivos: 
	0.123456789101112131415161718192021...
	Si dn representa el nº dígito de la parte decimal, halla: 
	d1 x d10 x d100 x d1000 x d10000 x d100000 x d1000000				*/

#INCLUDE "Hbgtinfo.ch"
#DEFINE P_nCif 1000000

HB_GTINFO(HB_GTI_WINTITLE, "Problema 40")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cElem AS NUMERIC
PRIVATE cPos AS NUMERIC
PRIVATE nAux AS NUMERIC
PRIVATE nRes AS NUMERIC
PRIVATE cTerm := 0
PRIVATE nPos := 0
PRIVATE vNum[P_nCif],vAux[P_nCif]
AFILL(vAux, 0)
AFILL(vNum, 0)

@ 4,2 SAY "Terminos:"

WHILE nPos <= P_nCif
	@ 4,12 SAY ++cTerm
	vAux[1] = cTerm
	FOR cElem := 1 TO P_nCif
		IF vAux[cElem] = 0
			EXIT
		ELSEIF vAux[cElem] > 9
			nAux = INT(vAux[cElem] / 10)
			vAux[cElem] %= 10
			vAux[cElem + 1] = nAux
		ENDIF
	NEXT
	FOR cPos := 1 TO (cElem - 1)
		IF ++nPos <= P_nCif
			vNum[nPos] = vAux[cElem - cPos]
		ENDIF
	NEXT
END

nAux = 1
nRes = 1
FOR cTerm := 1 TO 7
	nRes *= vNum[nAux]
	nAux *= 10
NEXT

@ 7,2 SAY "El resultado es " + NUMTRIM(nRes)
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
