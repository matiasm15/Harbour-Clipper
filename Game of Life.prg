
/*
  Name: Life.prg
  Author: Matías Mangiantini
  Date: 11/05/14
  Description: Game of Life made in Harbour.
  Version: v1.02
*/

#INCLUDE "Hbgtinfo.ch"
#INCLUDE "Inkey.ch"
#DEFINE P_cFil 32
#DEFINE P_cCol 110

// Se pueden modificar para configurar las distintas variantes que existen. Esta versión es la original: B3/S23.
#DEFINE P_vBorn {3}
#DEFINE P_vStaysAlive {2,3}

PRIVATE cFil,cCol AS NUMERIC
PRIVATE nPoblAct AS NUMERIC
PRIVATE nGeneracion AS NUMERIC
PRIVATE nKey := 0
PRIVATE nVelocidad := 10.00
PRIVATE vOcupado[P_cFil,P_cCol]

HB_GTINFO(HB_GTI_WINTITLE, "Game of Life")
SETMODE((P_cFil + 2),P_cCol)
SET(_SET_EVENTMASK, INKEY_ALL)
SET CURSOR OFF
CLEAR

// Armo pantalla inicial.
INICIALIZAR(@vOcupado,@nPoblAct,@nGeneracion)
MOSTRAR_VELOCIDAD(nVelocidad)
@ 0,2 SAY "X:"
@ 0,11 SAY "Y:"
@ 0,20 SAY "|    Generacion:"
@ 0,37 SAY nGeneracion
@ 0,51 SAY "|    Poblacion:"
@ 0,67 SAY nPoblAct
@ 0,81 SAY "|    Velocidad:"
MOSTRAR_VELOCIDAD(nVelocidad)

@ 1,0 TO P_cFil,(P_cCol - 1) DOUBLE

WHILE nKey <> K_ESC
	
	nKey = INKEY(0)
	cFil = MRow()
	cCol = MCol() + 1
	
	IF cFil > 1 .AND. cCol > 1 .AND. cFil < P_cFil .AND. cCol < P_cCol
		
		@ 0,5 SAY SPACE(3 - LEN(NUMTRIM(cCol - 1))) + NUMTRIM(cCol - 1)
		@ 0,14 SAY SPACE(2 - LEN(NUMTRIM(cFil - 1))) + NUMTRIM(cFil - 1)
		
		IF nKey = K_LBUTTONDOWN
			IF vOcupado[cFil,cCol] = 0
				@ cFil,(cCol - 1) SAY "#"
				vOcupado[cFil,cCol] = 1
				++nPoblAct
			ELSE
				@ cFil,(cCol - 1) SAY " "
				vOcupado[cFil,cCol] = 0
				--nPoblAct
			ENDIF
		ENDIF
		
	ELSE
	
		@ 0,5 CLEAR TO 0,10
		@ 0,14 CLEAR TO 0,18
		
	ENDIF

	DO CASE
		
		CASE nKey = K_F1
			
			ALERT( "Realizado por Matias Mangiantini (Version 1.02)" )
			
		CASE nKey = K_F2
			
			nKey = 0
			@ 0,5 CLEAR TO 0,10
			@ 0,14 CLEAR TO 0,18
			@ (P_cFil + 1),1 CLEAR TO (P_cFil + 1),(P_cCol - 1)
			@ (P_cFil + 1),2 SAY "F2: Detener"
			
			WHILE nKey <> K_F2
				
				PROXIMA_GENERACION(vOcupado,@nPoblAct,@nGeneracion)
				
				nSeg = SECONDS() + (1 / nVelocidad)
				WHILE (SECONDS() < nSeg) .AND. ((nKey := INKEY(0.01)) <> K_F2)
				END
				
			END
			
			MOSTRAR_INSTRUCCIONES()
			
		CASE nKey = K_SPACE
			
			PROXIMA_GENERACION(vOcupado,@nPoblAct,@nGeneracion)
	
		CASE nKey = K_DEL
			
			INICIALIZAR(@vOcupado,@nPoblAct,@nGeneracion)
			@ 2,1 CLEAR TO (P_cFil - 1),(P_cCol - 2)
			
		CASE nKey = K_RIGHT
			
			IF nVelocidad <= 0.24
				nVelocidad += 0.01
			ELSEIF nVelocidad < 1
				nVelocidad += 0.05
			ELSEIF nVelocidad < 10
				nVelocidad += 0.25
			ELSEIF nVelocidad < 50
				nVelocidad += 1
			ENDIF
			MOSTRAR_VELOCIDAD(nVelocidad)
			
		CASE nKey = K_LEFT
			
			IF nVelocidad > 10
				nVelocidad -= 1
			ELSEIF nVelocidad > 1
				nVelocidad -= 0.25
			ELSEIF nVelocidad > 0.25
				nVelocidad -= 0.05
			ELSEIF nVelocidad > 0.1
				nVelocidad -= 0.01
			ENDIF
			MOSTRAR_VELOCIDAD(nVelocidad)
			
	ENDCASE
	
	@ 0,37 SAY nGeneracion
	@ 0,67 SAY nPoblAct
	
END
CLEAR



#INCLUDE "MyLib.ch"

PROCEDURE PROXIMA_GENERACION(pvOcupado,pnPoblAct,pnGeneracion)
	LOCAL cFil,cCol,cCelVec AS NUMERIC
	LOCAL vOcupadoAux[P_cFil,P_cCol]

	pnPoblAct = 0
	++pnGeneracion
	FOR cFil := 2 TO (P_cFil - 1)
		FOR cCol := 2 TO (P_cCol - 1)

			cCelVec = pvOcupado[(cFil - 1),(cCol - 1)] + pvOcupado[(cFil - 1),cCol] + pvOcupado[(cFil - 1),(cCol + 1)] + pvOcupado[cFil,(cCol - 1)] + pvOcupado[cFil,(cCol + 1)] + pvOcupado[(cFil + 1),(cCol - 1)] + pvOcupado[(cFil + 1),cCol] + pvOcupado[(cFil + 1),(cCol + 1)]

			IF (pvOcupado[cFil,cCol] = 0 .AND. ASCAN(P_vBorn, cCelVec) <> 0) .OR. (pvOcupado[cFil,cCol] = 1 .AND. ASCAN(P_vStaysAlive, cCelVec) <> 0)
				@ cFil,(cCol - 1) SAY "#"
				vOcupadoAux[cFil,cCol] = 1
				++pnPoblAct
			ELSE
				@ cFil,(cCol - 1) SAY " "
				vOcupadoAux[cFil,cCol] = 0
			ENDIF
		NEXT
	NEXT

	FOR cFil := 2 TO (P_cFil - 1)
		ACOPY(vOcupadoAux[cFil], pvOcupado[cFil], 2, (P_cCol - 2), 2)
	NEXT
	
	@ 0,37 SAY pnGeneracion
	@ 0,67 SAY pnPoblAct
	
RETURN



PROCEDURE INICIALIZAR(pvOcupado,pnPoblAct,pnGeneracion)
	LOCAL cFil AS NUMERIC
	pnPoblAct = 0
	pnGeneracion = 0
	FOR cFil := 1 TO P_cFil
		AFILL(pvOcupado[cFil], 0)
	NEXT
RETURN



PROCEDURE MOSTRAR_INSTRUCCIONES
	@ (P_cFil + 1),2 SAY "F2: Avanzar"
	@ (P_cFil + 1),22 SAY "Supr: Borrar Todo"
	@ (P_cFil + 1),50 SAY CHR(17) + "/" + CHR(16) + ": Aumentar/Reducir Velocidad"
	@ (P_cFil + 1),93 SAY "Esc: Salir"
RETURN



PROCEDURE MOSTRAR_VELOCIDAD(pnVelocidad)
	@ 0,97 SAY SPACE(5 - LEN( LTRIM( STR( pnVelocidad ) ) ) ) + LTRIM( STR( pnVelocidad ) )
RETURN
