* Halla la suma de todos los primos por debajo de dos millones.

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 10")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE cNum AS NUMERIC
PRIVATE xNumIng := 2000000
PRIVATE aRes := 2

WHILE .T.
	@ 3,2 SAY "Numero a verificar" GET xNumIng
	READ
	IF LASTKEY() = 27
		CLEAR
		RETURN
	ENDIF
	IF xNumIng > 2
		EXIT
	ENDIF
	ALERT( "El numero tiene que ser mayor a 2" )
END

@ 3,2 CLEAR TO 3,99
@ 3,2 SAY "Verificando numero"

FOR cNum := 3 TO (xNumIng - 1) STEP 2
	IF IS_PRIME(cNum)
		aRes += cNum
	ENDIF
	@ 3,21 SAY cNum
END

@ 3,21 SAY xNumIng
@ 6,2 SAY "El resultado es " + NUMTRIM(aRes)
INKEY(0)
CLEAR




FUNCTION IS_PRIME(pnNum)
	LOCAL cDiv AS NUMERIC
	LOCAL nRaiz := INT(SQRT(pnNum))
	LOCAL bRes := .T.
	
	FOR cDiv := 2 TO nRaiz
		IF (pnNum % cDiv) = 0
			bRes = .F.
			EXIT
		ENDIF
	END
	
RETURN bRes



FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
