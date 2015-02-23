/* Las permutaciones lexicográficas de 0, 1 y 2 son los siguientes:

1ra: 012  ;  2da: 021  ;  3ra: 102  ;  4ta: 120  ;  5ta: 201  ;  6ta: 210

¿Cuál es la millonésima permutación de los dígitos 0, 1, 2, 3, 4, 5, 6, 7, 8 y 9?		*/

#INCLUDE "Hbgtinfo.ch"
#DEFINE P_NCIFRAS 10

LOCAL cElem AS NUMERIC
LOCAL cPas AS NUMERIC
LOCAL aRes AS NUMERIC
LOCAL nPas AS NUMERIC
LOCAL nFac AS NUMERIC
LOCAL nAux AS NUMERIC
LOCAL nPrm AS NUMERIC
LOCAL xNumIng := 1000000
LOCAL vNum := {}

HB_GTINFO(HB_GTI_WINTITLE, "Problema 24")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

FOR cElem := 1 TO P_NCIFRAS
	AADD(vNum,(cElem - 1))
NEXT

WHILE .T.
	@ 3,2 SAY "Numero a verificar" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumIng >= 1
		EXIT
	ENDIF
	ALERT( "El numero no puede ser negativo" )
END

--xNumIng
aRes = xNumIng % FACTORIAL(P_NCIFRAS)
FOR cElem := (P_NCIFRAS - 1) TO 0 STEP -1
	nFac = FACTORIAL(cElem)
	nPas = INT(aRes / nFac)
	aRes %= nFac
	FOR cPas := nPas TO 1 STEP -1
		nPrm = P_NCIFRAS - cElem + cPas
		nAux = vNum[nPrm - 1]
		vNum[nPrm - 1] = vNum[nPrm]
		vNum[nPrm] = nAux
	NEXT
NEXT

@ 6,2 SAY "El resultado es"
FOR cElem := 1 TO P_NCIFRAS
	@ 6,(17 + cElem) SAY NUMTRIM(vNum[cElem])
NEXT
INKEY(0)
CLEAR




FUNCTION FACTORIAL(pnNum)
	LOCAL cNum AS NUMERIC
	LOCAL aRes := 1
	
	FOR cNum := 2 TO pnNum
		aRes *= cNum
	NEXT
	
RETURN aRes



FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
