* Halla la suma de los dígitos del número 100!

#INCLUDE "Hbgtinfo.ch"
#DEFINE P_nCif 1000

HB_GTINFO(HB_GTI_WINTITLE, "Problema 20")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cElem AS NUMERIC
PRIVATE cTerm AS NUMERIC
PRIVATE nPas AS NUMERIC
PRIVATE bAux AS LOGICAL
PRIVATE xNumIng := 100
PRIVATE nAcu := 0

WHILE .T.
	@ 4,2 SAY "Cantidad de terminos" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumIng > 2 .AND. xNumIng < 150
		CLEAR
		EXIT
	ENDIF
	ALERT( "El numero tiene que ser mayor a 2" )
END

DECLARE aNum[P_nCif]
AFILL(aNum, 0)
aNum[1] = 1

@ 4,2 SAY "Terminos:"
FOR cTerm := 2 TO xNumIng
	@ 4,12 SAY cTerm
	bAux = .F.
	FOR cElem := 1 TO P_nCif
		aNum[cElem] *= cTerm
		IF bAux
			aNum[cElem] += nPas
		ENDIF
		IF aNum[cElem] > 9
			bAux = .T.
			nPas = INT(aNum[cElem] / 10)
			aNum[cElem] %= 10
		ELSE
			bAux = .F.
		ENDIF
	NEXT
END

FOR cElem := 1 TO P_nCif
	nAcu += aNum[cElem]
NEXT

@ 7,2 SAY "La suma de los digitos del numero " + NUMTRIM(xNumIng) + "! es " + NUMTRIM(nAcu)
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
