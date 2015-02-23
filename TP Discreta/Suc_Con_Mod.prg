#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Congruencia Modulo")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE nNum AS NUMERIC
PRIVATE nCong AS NUMERIC
PRIVATE vNum AS NUMERIC
PRIVATE vCong AS NUMERIC
PRIVATE cNum AS NUMERIC
PRIVATE cCong AS NUMERIC
PRIVATE cLin AS NUMERIC
PRIVATE nPos AS NUMERIC
PRIVATE aNum_1 := {0, 3, -1, 2, 18, -9, -75, 28, 30, 1001, 420}
PRIVATE aCong := {4, 7, 15, 28}

nNum = LEN(aNum_1)
nCong = LEN(aCong)
DECLARE aNum_2[nNum]

FOR cCong := 1 TO nCong
	vCong = aCong[cCong]
	FOR cNum := 1 TO nNum
		vNum = aNum_1[cNum] % vCong
		IF vNum < 0
			vNum += vCong
		ENDIF
		aNum_2[cNum] = vNum
	NEXT

	cLin = 4
	FOR cNum := 0 TO vCong
		WHILE .T.
			nPos = ASCAN(aNum_2, cNum)
			IF nPos = 0
				EXIT
			ENDIF
			@ cLin++,7 SAY NUMTRIM(aNum_1[nPos]) + " es congruente " + NUMTRIM(cNum) + " modulo " + NUMTRIM(vCong)
			aNum_2[nPos] = -1
		END
	NEXT
	INKEY(0)
	CLEAR
NEXT




FUNCTION NUMTRIM(pNum)
	pNum = LTRIM(STR(INT(pNum)))
RETURN pNum