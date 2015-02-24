
/*
  Name: Pong.prg
  Author: Matías Mangiantini
  Date: 15/07/14
  Description: Pong made in Harbour.
  Version: v1.00
*/

#INCLUDE "Hbgtinfo.ch"
#INCLUDE "Inkey.ch"
#DEFINE P_nVel 0.07
#DEFINE vArriba {87, 119, K_UP}
#DEFINE vAbajo {83, 115, K_DOWN}
#DEFINE vMovimientoJugador_1 {83, 87, 115, 119}
#DEFINE vMovimientoJugador_2 {K_UP, K_DOWN}
#DEFINE vEfectoJugador_1 {K_ALT_W, K_ALT_D, K_ALT_S}
#DEFINE vEfectoJugador_2 {K_CTRL_UP, K_CTRL_LEFT, K_CTRL_DOWN}

PRIVATE xKey AS NUMERIC
PRIVATE nSeg AS NUMERIC
PRIVATE nLastKey AS NUMERIC
PRIVATE nPuntaje_1 := 0
PRIVATE nPuntaje_2 := 0
PRIVATE nBolaenX, nBolaenY AS NUMERIC
PRIVATE nDireccion AS NUMERIC
PRIVATE nJugador_1, nJugador_2 AS NUMERIC

HB_GTINFO(HB_GTI_WINTITLE, "Pong")
SETMODE(31,89)
SET CURSOR OFF
CLEAR

@ 1,0 TO 30,88 DOUBLE
MOSTRAR_PUNTUACION(nPuntaje_1, nPuntaje_2)
xKey = INICIAR_PANTALLA(@nBolaenX, @nBolaenY, @nDireccion, @nJugador_1, @nJugador_2)

WHILE .T.

	nSeg = SECONDS() + P_nVel
	WHILE (nSeg > SECONDS())
		nLastKey = xKey
		IF (ASCAN(vMovimientoJugador_1, nLastKey) <> 0)
			MOVER_PALETA(nLastKey, @nJugador_1, 2, nBolaenX)
		ELSEIF (ASCAN(vMovimientoJugador_2, nLastKey) <> 0)
			MOVER_PALETA(nLastKey, @nJugador_2, 86, nBolaenX)
		ENDIF
		xKey = INKEY(P_nVel)
	END
	
	MOVER_BOLA(@nBolaenX, @nBolaenY, @nDireccion, nJugador_1, nJugador_2, nLastKey)
	IF nBolaenX = 1
		MOSTRAR_PUNTUACION(nPuntaje_1, ++nPuntaje_2)
		PARPADEAR_PANTALLA(nBolaenX, nBolaenY, nJugador_1, nJugador_2)
		IF nPuntaje_2 = 3
			ALERT("Felicidades Jugador 2")
			EXIT
		ENDIF
		xKey = INICIAR_PANTALLA(@nBolaenX, @nBolaenY, @nDireccion, @nJugador_1, @nJugador_2)
	ELSEIF nBolaenX = 87
		MOSTRAR_PUNTUACION(++nPuntaje_1, nPuntaje_2)
		PARPADEAR_PANTALLA(nBolaenX, nBolaenY, nJugador_1, nJugador_2)
		IF nPuntaje_1 = 3
			ALERT("Felicidades Jugador 1")
			EXIT
		ENDIF
		xKey = INICIAR_PANTALLA(@nBolaenX, @nBolaenY, @nDireccion, @nJugador_1, @nJugador_2)
	END
	
END
CLEAR



#INCLUDE "MyLib.ch"

// Armo pantalla inicial.
FUNCTION INICIAR_PANTALLA(nBolaenX, nBolaenY, nDireccion, nJugador_1, nJugador_2)
	LOCAL xKey AS NUMERIC
	LOCAL cElem AS NUMERIC
	
	nBolaenX = 43 + RANDOM(0,2)
	nBolaenY = 14 + RANDOM(0,2)
	nDireccion = RANDOM(0,3)
	IF nDireccion > 0
		++nDireccion
	ENDIF
	IF nDireccion = 4
		++nDireccion
	ENDIF	
	
	nJugador_1 = 14
	nJugador_2 = 14
	@ 2,1 CLEAR TO 29,2
	@ 2,86 CLEAR TO 29,87
	FOR cElem := 0 TO 2
		@ (nJugador_1 + cElem),2 SAY "#" COLOR "G"
		@ (nJugador_2 + cElem),86 SAY "#" COLOR "G"
	NEXT
	@ nBolaenY,nBolaenX SAY "*" COLOR "R"

	WHILE (ASCAN(vArriba, xKey) = 0) .AND. (ASCAN(vAbajo, xKey) = 0)
		xKey = INKEY(0)
		IF xKey = K_F1
			ALERT( "Realizado por Matias Mangiantini (Version 1.00)" )
		ENDIF
	END
	
RETURN xKey


PROCEDURE MOSTRAR_PUNTUACION(nPuntaje_1, nPuntaje_2)
	@ 0,2 SAY NUMTRIM(nPuntaje_1)
	@ 0,86 SAY NUMTRIM(nPuntaje_2)
RETURN


PROCEDURE PARPADEAR_PANTALLA(nBolaenX, nBolaenY, nJugador_1, nJugador_2)
	LOCAL nParpadeo, cElem AS NUMERIC
	
	FOR nParpadeo := 1 TO 3
	
		STAND(0.25)
		@ nBolaenY,nBolaenX SAY " " COLOR "R"
		FOR cElem := 0 TO 2
			@ (nJugador_1 + cElem),2 SAY " " COLOR "G"
			@ (nJugador_2 + cElem),86 SAY " " COLOR "G"
		NEXT
		
		STAND(0.25)
		@ nBolaenY,nBolaenX SAY "*" COLOR "R"
		FOR cElem := 0 TO 2
			@ (nJugador_1 + cElem),2 SAY "#" COLOR "G"
			@ (nJugador_2 + cElem),86 SAY "#" COLOR "G"
		NEXT
		
	NEXT
RETURN

	
PROCEDURE MOVER_PALETA(xKey, nJugador, nColumna, nBolaenX)
	
	IF (nBolaenX <> 2) .AND. (nBolaenX <> 86)
		IF (ASCAN(vArriba, xKey) <> 0) .AND. (nJugador <> 2)
			--nJugador
			@ nJugador,nColumna SAY "#" COLOR "G"
			@ (nJugador + 3),nColumna SAY " "
		ELSEIF (ASCAN(vAbajo, xKey) <> 0) .AND. (nJugador <> 27)
			++nJugador
			@ (nJugador + 2),nColumna SAY "#" COLOR "G"
			@ (nJugador - 1),nColumna SAY " "
		ENDIF
	ENDIF
	
RETURN

PROCEDURE MOVER_BOLA(nBolaenX, nBolaenY, nDireccion, nJugador_1, nJugador_2, nLastKey)
	LOCAL bSeguir := .T.
	LOCAL nBolaenXSig, nBolaenYSig AS NUMERIC
	@ nBolaenY,nBolaenX SAY " "
	
	WHILE bSeguir
		nBolaenXSig = nBolaenX
		nBolaenYSig = nBolaenY
		DO CASE
			CASE ((nDireccion = 0) .AND. (nBolaenYSig <> 2)) .OR. ((nDireccion = 2) .AND. (nBolaenYSig = 29))
				nDireccion = 0
				--nBolaenXSig
				--nBolaenYSig
			CASE (nDireccion = 1)
				--nBolaenXSig
			CASE (nDireccion = 2).OR. ((nDireccion = 0) .AND. (nBolaenYSig = 2))
				nDireccion = 2
				--nBolaenXSig
				++nBolaenYSig
			CASE ((nDireccion = 3) .AND. (nBolaenYSig <> 2)) .OR. ((nDireccion = 5) .AND. (nBolaenYSig = 29))
				nDireccion = 3
				++nBolaenXSig
				--nBolaenYSig
			CASE (nDireccion = 4)
				++nBolaenXSig
			CASE (nDireccion = 5) .OR. ((nDireccion = 3) .AND. (nBolaenYSig = 2))
				nDireccion = 5
				++nBolaenXSig
				++nBolaenYSig
		ENDCASE
		
		IF ((nBolaenXSig = 2) .AND. (nBolaenYSig >= nJugador_1) .AND. (nJugador_1 + 2 >= nBolaenYSig)) .OR. ((nBolaenXSig = 86) .AND. (nBolaenYSig >= nJugador_2) .AND. (nJugador_2 + 2 >= nBolaenYSig))
		
			// Compruebo si la pelota debe tomar algun efecto.
			IF (3 > nDireccion) .AND. (ASCAN(vEfectoJugador_1, nLastKey) <> 0)
				nDireccion = ASCAN(vEfectoJugador_1, nLastKey) - 1
			ELSEIF (nDireccion > 2) .AND. (ASCAN(vEfectoJugador_2, nLastKey) <> 0)
				nDireccion = ASCAN(vEfectoJugador_2, nLastKey) + 2
			ENDIF
			nLastKey = 0
			nDireccion = (nDireccion + 3) % 6
			
		ELSE
			bSeguir = .F.
			nBolaenX = nBolaenXSig
			nBolaenY = nBolaenYSig
			@ nBolaenY,nBolaenX SAY "*" COLOR "R"
		ENDIF
	END
	
RETURN
