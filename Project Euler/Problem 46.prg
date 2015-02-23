/* ¿Cuál es el impar compuesto más pequeño que no se puede escribir como la suma 
de un primo y el doble de un cuadrado?												*/

#INCLUDE "Hbgtinfo.ch"

HB_GTINFO(HB_GTI_WINTITLE, "Problema 46")
SETMODE(25,80)
SET CURSOR OFF
CLEAR

PRIVATE nSeg AS NUMERIC
PRIVATE cAuxPrm AS NUMERIC
PRIVATE cAuxCdr AS NUMERIC
PRIVATE cNum := 1
PRIVATE cPrm := 0
PRIVATE cCdr := 1
PRIVATE nAux := 8
PRIVATE vPrm := {}
PRIVATE vCdr := {2}
PRIVATE bPas := .T.

nSeg = SECONDS()

@ 6,2 SAY "Verificando numero:"
WHILE bPas
	@ 6,22 SAY ++cNum
	IF cNum > nAux
		++cCdr
		AADD(vCdr,nAux)
		nAux = 2 * cCdr * cCdr
	ENDIF
	IF IS_PRIME(cNum)
		++cPrm
		AADD(vPrm,cNum)
	ELSEIF (cNum % 2) = 1
		bPas = .F.
		FOR cAuxPrm := 1 TO cPrm
			IF bPas = .F.
				FOR cAuxCdr := 1 TO cCdr
					IF cNum = vPrm[cAuxPrm] + vCdr[cAuxCdr]
						bPas = .T.
					ENDIF
				NEXT
			ENDIF
		NEXT
	ENDIF
END

nSeg = SECONDS() - nSeg

@ 6,0 CLEAR TO 6,99
@ 6,2 SAY "El resultado es " + NUMTRIM(cNum)
@ 24,2 SAY "La operacion se realizo en " + LTRIM(STR(nSeg)) + " segundos" COLOR "G+"

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
