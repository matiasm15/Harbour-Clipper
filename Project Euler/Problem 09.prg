/*	Una terna pitagórica es un conjunto de tres números naturales, a < b < c, para el cual,
	a^2 + b^2 = c^2. Existe una única terna pitagórica para la cual a + b + c = 1000. 
	Halla el producto abc.																	*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 09")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE nRes AS NUMERIC
PRIVATE nHip := 0
PRIVATE nCat_1 := 1
PRIVATE nCat_2 := 0

@ 6,2 SAY "PRIMER CATETO"
@ 7,2 SAY "SEGUNDO CATETO"
@ 8,2 SAY "HIPOTENUSA"

WHILE (nHip + nCat_1 + nCat_2) # 1000
	IF ++nCat_2 > 1000
		++nCat_1
		nCat_2 = 1
	ENDIF
	nHip = SQRT(nCat_1 * nCat_1 + nCat_2 * nCat_2)
	@ 6,18 SAY nCat_1
	@ 7,18 SAY nCat_2
	@ 8,18 SAY INT(nHip)
END
nRes = nHip * nCat_1 * nCat_2

@ 10,2 SAY "El resultado es " + NUMTRIM(nRes)
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
