* Calcula la suma de todos los números amigos inferiores a 10000.

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 21")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cElem AS NUMERIC
PRIVATE cDiv AS NUMERIC
PRIVATE nRes AS NUMERIC
PRIVATE nAcu AS NUMERIC
PRIVATE nSeg AS NUMERIC
PRIVATE nAux AS NUMERIC
PRIVATE xNumIng := 10000

WHILE .T.
	@ 4,2 SAY "Cantidad de terminos" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumIng > 5
		EXIT
	ENDIF
	ALERT( "El numero tiene que ser mayor a 4" )
END

DECLARE aNum[--xNumIng]
nSeg = SECONDS()

CLEAR
@ 4,2 SAY "Terminos:"
@ 24,2 SAY "Sumando factores" COLOR "G+"

FOR cElem := 5 TO xNumIng
	@ 4,12 SAY cElem
	nAcu = 1
	nAux = SQRT(cElem)
	FOR cDiv := 2 TO nAux
		nRes = cElem / cDiv
		IF nRes = INT(nRes)
			nAcu += cDiv + nRes
		ENDIF
	NEXT
	IF nAux = INT(nAux)
		nAcu -= nAux
	ENDIF
	aNum[cElem] = nAcu
END

@ 24,2 SAY "Calculando numeros amigos" COLOR "G+"

nAcu = 0
FOR cElem := 6 TO xNumIng
	@ 4,12 SAY cElem
	FOR cDiv := 2 TO xNumIng
		IF aNum[cDiv] = cElem .AND. aNum[cElem] = cDiv .AND. cElem <> cDiv
			nAcu += cElem
		ENDIF
	NEXT
NEXT

nSeg = SECONDS() - nSeg

@ 7,2 SAY "La suma de los numeros amigos inferioes a " + NUMTRIM(++xNumIng) + " es " + NUMTRIM(nAcu)
@ 24,2 SAY "La operacion se realizo en " + LTRIM(STR(nSeg)) + " segundos" COLOR "G+"
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
