/*	¿Qué número inicial, inferior a un millón, produce la cadena más larga de la 
siguiente secuencia?

	n/2 (si n es par) 
	3n + 1 (si n es impar)														*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 14")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE nRes AS NUMERIC
PRIVATE cNum AS NUMERIC
PRIVATE cPas AS NUMERIC
PRIVATE nMaxNum AS NUMERIC
PRIVATE nMaxTam := 0
PRIVATE xNumIng := 1000000

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

@ 6,2 SAY "VERIFICANDO NUMERO"
@ 8,2 SAY "NUMERO INICIAL"
@ 9,2 SAY "MAYOR CANTIDAD DE TERMINOS"

FOR cNum := 2 TO (xNumIng - 1)
	cPas = 1
	nRes = cNum
	WHILE nRes <> 1
		IF (nRes % 2) = 0
			nRes /= 2
		ELSE
			nRes *= 3
			++nRes
		ENDIF
		++cPas
	END
	IF cPas > nMaxTam
		nMaxNum = cNum
		nMaxTam = cPas
		@ 8,29 SAY nMaxNum
		@ 9,29 SAY nMaxTam
	ENDIF
	@ 6,29 SAY cNum
NEXT

@ 8,2 CLEAR TO 9,99
@ 8,2 SAY "NUMERO INICIAL " + NUMTRIM(nMaxNum) COLOR "G+"
@ 9,2 SAY "MAYOR CANTIDAD DE TERMINOS " + NUMTRIM(nMaxTam) COLOR "G+"
INKEY(0)
CLEAR




FUNCTION NUMTRIM(pnNum)
	pnNum = LTRIM(STR(INT(pnNum)))
RETURN pnNum
