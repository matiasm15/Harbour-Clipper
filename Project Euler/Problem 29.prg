/*	¿Cuántos términos distintos hay en la secuencia generada por a^b para 2 <= a <= 100 
	y 2 <= b <= 100?		 																*/

#INCLUDE "Hbgtinfo.ch"
#DEFINE P_nCif 500

HB_GTINFO(HB_GTI_WINTITLE, "Problema 29")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cNumA AS NUMERIC
PRIVATE cNumB AS NUMERIC
PRIVATE cElem AS NUMERIC
PRIVATE nPas AS NUMERIC
PRIVATE bAux AS LOGICAL
PRIVATE sNumStr AS CHARACTER
PRIVATE cTerm := 0
PRIVATE xNumA := 100
PRIVATE xNumB := 100
PRIVATE vNum := {}
PRIVATE vRes[P_nCif]

WHILE .T.
	@ 3,2 SAY "Numero A" GET xNumA
	@ 4,2 SAY "Numero B" GET xNumB
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumA > 2 .AND. xNumA < 201 .AND. xNumB > 2 .AND. xNumB < 201
		EXIT
	ENDIF
	ALERT( "Los numeros tienen que estar entre 3 y 200" )
END

@ 6,2 SAY "Base:"
FOR cNumA := 2 TO xNumA
	@ 6,8 SAY cNumA
	AFILL(vRes, 0)
	vRes[1] = cNumA
	FOR cElem := 1 TO (P_nCif - 1)
		IF vRes[cElem] > 9
			nPas = INT(vRes[cElem] / 10)
			vRes[cElem] %= 10
			vRes[cElem + 1] = nPas
		ENDIF
	NEXT

	FOR cNumB := 2 TO xNumB
		bAux = .F.
		sNumStr = ""
		FOR cElem := 1 TO P_nCif
			vRes[cElem] *= cNumA
			IF bAux
				vRes[cElem] += nPas
			ENDIF
			IF vRes[cElem] > 9
				bAux = .T.
				nPas = INT(vRes[cElem] / 10)
				vRes[cElem] %= 10
			ELSE
				bAux = .F.
			ENDIF
			sNumStr = NUMTRIM(vRes[cElem]) + sNumStr
		NEXT
		
		bAux = .T.
		FOR cElem := 1 TO cTerm
			IF vNum[cElem] = sNumStr
				bAux = .F.
				EXIT
			ENDIF
		NEXT
		IF bAux
			++cTerm
			AADD(vNum,sNumStr)
		ENDIF
	NEXT
NEXT

@ 6,0 CLEAR TO 6,99
@ 6,2 SAY "Hay " + NUMTRIM(cTerm) + " terminos distintos en la secuencia generada por " + NUMTRIM(xNumA) + "^" + NUMTRIM(xNumB)
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
