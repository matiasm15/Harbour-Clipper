/*
	Para utilizarla como DLL:
	- Compilar este archivo como
		hbmk2 MyLib.prg -shared -hbdynvm -nohblib
	- Compilar el archivo que necesita las funciones como
		hbmk2 Codigo.prg -shared -L. -lmylib
*/

FUNCTION RANDOM(nMin, nMax)
	LOCAL nRes AS NUMERIC
	LOCAL nDif := nMax - nMin + 1
	STATIC nSeed := 0.123456789
	
	IF nSeed = 0.123456789
		nSeed += VAL(SUBSTR(TIME(), 7, 2)) / 100
	ENDIF
	
	nSeed = (nSeed * 31415821 + 1) / 1000000
	nSeed -= INT(nSeed)
	nRes = INT(nSeed * nDif + nMin)
RETURN nRes



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



FUNCTION FACTORIAL(nNum)
	LOCAL cNum AS NUMERIC
	LOCAL aRes := 1
	
	FOR cNum := 2 TO nNum
		aRes *= cNum
	NEXT
RETURN aRes



FUNCTION NUMTRIM(nNum)
RETURN LTRIM(STR(INT(nNum)))



FUNCTION SUMARRAYS(aNum_1, aNum_2)
	LOCAL cElem AS NUMERIC
	LOCAL nLength := LEN(aNum_1)
	LOCAL bCarry := .F.
	
	FOR cElem := nLength TO 1 STEP -1
		aNum_1[cElem] += aNum_2[cElem]
		
		IF bCarry
			++aNum_1[cElem]
			bCarry = .F.
		ENDIF
		
		IF aNum_1[cElem] > 9
			bCarry = .T.
			aNum_1[cElem] -= 10
		ENDIF
	NEXT	
RETURN aNum_1



PROCEDURE STAND(nSegEsperar)
	nSegEsperar += SECONDS()
	WHILE nSegEsperar > SECONDS()
	END
	CLEAR TYPEAHEAD
RETURN
