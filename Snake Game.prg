
/*
  Name: Snake.prg
  Author: Matías Mangiantini
  Date: 23/04/14
  Description: Snake made in Harbour.
  Version: v1.17
*/

#INCLUDE "Hbgtinfo.ch"
#INCLUDE "Inkey.ch"
#DEFINE P_nVel 0.40

PRIVATE xKey AS NUMERIC
PRIVATE cElem AS NUMERIC
PRIVATE nAux,nColor AS NUMERIC
PRIVATE nPunProx AS NUMERIC
PRIVATE nSimb AS NUMERIC
PRIVATE nPun := 0
PRIVATE cLong := 3
PRIVATE nElem := 1
PRIVATE nElemAnt := cLong
PRIVATE xKeyAnt := K_RIGHT
PRIVATE nFruto := {-1,-1}
PRIVATE nCabeza := {-1,-1}
PRIVATE vSnake := {{2,2},{2,3},{2,4},{-1,-1}}
PRIVATE vKey := {K_RIGHT,K_UP,K_LEFT,K_DOWN,K_ESC}
PRIVATE bFruto := .T.
PRIVATE bManual := .T.

HB_GTINFO(HB_GTI_WINTITLE, "Snake")
SETMODE(31,90)
SET CURSOR OFF
CLEAR

// Armo pantalla inicial.
@ 0,1 SAY "Puntuacion:"
@ 0,13 SAY nPun
@ 1,0 TO 30,89 DOUBLE
FOR cElem := 1 TO (cLong - 1)
	@ vSnake[cElem,1],vSnake[cElem,2] SAY "#" COLOR "G"
NEXT
@ vSnake[cElem,1],vSnake[cElem,2] SAY CHR(185) COLOR "G"

// Espero hasta que el usuario presione RIGHT, DOWN o F2.
WHILE xKey <> K_RIGHT .AND. xKey <> K_DOWN
	xKey = INKEY(0)
	IF xKey = K_F1
		ALERT( "Realizado por Matias Mangiantini (Version 1.17)" )
	ELSEIF xKey = K_F2
		xKey = K_RIGHT
		bManual = .F.
	ENDIF
END
xKeyAnt = xKey

WHILE .T.
	
	// Borro la cola de la serpiente. Guardo su posición para mostrarla por si el jugador pierde.
	@ vSnake[nElem,1],vSnake[nElem,2] SAY " "
	vSnake[cLong + 1] = vSnake[nElem]
	vSnake[nElem] = {-1,-1}
	
	// Verifico si se hace algun movimiento prohibido.
	IF ASCAN(vKey,xKey) = 0 .OR. (xKeyAnt = K_RIGHT .AND. xKey = K_LEFT) .OR. (xKeyAnt = K_LEFT .AND. xKey = K_RIGHT) .OR. (xKeyAnt = K_UP .AND. xKey = K_DOWN) .OR. (xKeyAnt = K_DOWN .AND. xKey = K_UP)
		xKey = xKeyAnt
	ELSE
		xKeyAnt = xKey
	ENDIF
	
	PROXIMO_MOVIMIENTO(xKey)
	
	// Verifico la nueva posición. Si ya esta ocupada, el jugador pierde.
	IF POSICION_VALIDA(nCabeza,vSnake,cLong)
		
		vSnake[nElem,1] = nCabeza[1]
		vSnake[nElem,2] = nCabeza[2]
		
	ELSE
		
		// Ilumino el cuerpo y la cabeza.
		FOR cElem := 1 TO (cLong + 1)
			@ vSnake[cElem,1],vSnake[cElem,2] SAY "#" COLOR "G+"
		NEXT
		@ vSnake[nElemAnt,1],vSnake[nElemAnt,2] SAY CHR(nSimb) COLOR "G+"
		ALERT( "Perdiste! Tu puntuacion fue de " + NUMTRIM(nPun) + " puntos" )
		EXIT
		
	ENDIF
	
	// Si la serpiente come el fruto le agrego el nuevo trozo y actualizo el puntaje.
	IF vSnake[nElem,1] = nFruto[1] .AND. vSnake[nElem,2] = nFruto[2]
		AADD(vSnake, {-1,-1})
		++cLong
		vSnake[cLong] = {-1,-1}
		bFruto = .T.
		nPun += nPunProx
		@ 0,13 SAY nPun
	ENDIF
	
	// Muestro la cabeza.
	@ vSnake[nElem,1],vSnake[nElem,2] SAY CHR(nSimb) COLOR "G"
	@ vSnake[nElemAnt,1],vSnake[nElemAnt,2] SAY "#" COLOR "G"
	nElemAnt = nElem
	nElem %= cLong
	++nElem
	
	// Si la serpiente agarró el fruto genero uno nuevo.
	WHILE bFruto = .T.
		
		nFruto = { RANDOM(2,29), RANDOM(1,88) }
		
		IF POSICION_VALIDA(nFruto,vSnake,cLong)
			
			// Calculo si tiene puntaje extra.
			bFruto = .F.
			nAux = RANDOM(1,50)
			IF nAux = 6
				nColor = 9
				nPunProx = 2000
			ELSEIF nAux = 4 .OR. nAux = 5
				nColor = 12
				nPunProx = 1000
			ELSEIF nAux = 3 .OR. nAux = 2 .OR. nAux = 1
				nColor = 14
				nPunProx = 500
			ELSE
				nColor = 15
				nPunProx = 100
			ENDIF
			@ nFruto[1],nFruto[2] SAY "*" COLOR STR(nColor)
			
		ENDIF
	END
	
	// Verifico si el modo automático esta activado.
	IF bManual = .T.
		xKey = INKEY(P_nVel)
	ELSE
		xKey = MODO_AUTOMATICO()
	ENDIF
	
END
CLEAR



#INCLUDE "MyLib.prg"

// Calculo el lugar donde se generara la cabeza y su forma.
PROCEDURE PROXIMO_MOVIMIENTO(pxKey)
	nCabeza[1] = vSnake[nElemAnt,1]
	nCabeza[2] = vSnake[nElemAnt,2]
	DO CASE
		CASE pxKey = K_RIGHT
			++nCabeza[2]
			nSimb = 185
		CASE pxKey = K_UP
			--nCabeza[1]
			nSimb = 203
		CASE pxKey = K_LEFT
			--nCabeza[2]
			nSimb = 204
		CASE pxKey = K_DOWN
			++nCabeza[1]
			nSimb = 202
	ENDCASE
RETURN


// Verifico si la posición no esta ya ocupada por la serpiente o por los bordes.
FUNCTION POSICION_VALIDA(pnPosicion,pvSnake,pcLong)
	LOCAL cElem AS NUMERIC
	LOCAL bRes := .T.
	IF pnPosicion[1] = 1 .OR. pnPosicion[1] = 30 .OR. pnPosicion[2] = 0 .OR. pnPosicion[2] = 89
		bRes = .F.
	ELSE
		FOR cElem := 1 TO pcLong
			IF pvSnake[cElem,1] = pnPosicion[1] .AND. pvSnake[cElem,2] = pnPosicion[2]
				bRes = .F.
				EXIT
			ENDIF
		NEXT
	ENDIF
RETURN bRes



FUNCTION MODO_AUTOMATICO
	LOCAL cPas AS NUMERIC
	LOCAL nResp AS NUMERIC
	LOCAL nAux := RANDOM(1,2)
	INKEY(0.01)
	
	// Intenta como primera opción moverse horizontalmente de acuerdo a la posición del fruto.
	IF nFruto[2] > nCabeza[2]
		nResp = K_RIGHT
	ELSEIF nFruto[2] < nCabeza[2]
		nResp = K_LEFT
	ELSEIF nFruto[1] > nCabeza[1]
		nResp = K_DOWN
	ELSE
		nResp = K_UP
	ENDIF
	
	FOR cPas := 1 TO 4
		
		// Verifico cada opción y si hace un movimiento ilegal.
		PROXIMO_MOVIMIENTO(nResp)
		IF POSICION_VALIDA(nCabeza,vSnake,cLong) .AND. (xKeyAnt <> K_RIGHT .OR. nResp <> K_LEFT) .AND. (xKeyAnt <> K_LEFT .OR. nResp <> K_RIGHT) .AND. (xKeyAnt <> K_UP .OR. nResp <> K_DOWN) .AND. (xKeyAnt <> K_DOWN .OR. nResp <> K_UP)
			EXIT
			
		// Intenta como segunda opción moverse verticalmente de acuerdo a la posición del fruto.
		ELSEIF cPas = 1
			IF nFruto[1] > nCabeza[1]
				nResp = K_DOWN
			ELSEIF nFruto[1] < nCabeza[1]
				nResp = K_UP
			ELSEIF nFruto[2] > nCabeza[2]
				nResp = K_RIGHT
			ELSE
				nResp = K_LEFT
			ENDIF
			
		// Intenta como tercera opción seguir el rumbo que tenia.
		ELSEIF cPas = 2
			nResp = xKeyAnt
			
		// Por último intenta doblar de manera aleatoria.
		ELSE
			DO CASE
				CASE (xKeyAnt = K_RIGHT .OR. xKeyAnt = K_LEFT) .AND. nAux = 1
					nResp = K_UP
				CASE (xKeyAnt = K_UP .OR. xKeyAnt = K_DOWN) .AND. nAux = 1
					nResp = K_LEFT
				CASE (xKeyAnt = K_RIGHT .OR. xKeyAnt = K_LEFT) .AND. nAux = 2
					nResp = K_DOWN
				CASE (xKeyAnt = K_UP .OR. xKeyAnt = K_DOWN) .AND. nAux = 2
					nResp = K_RIGHT
			ENDCASE
			nAux = (nAux % 2) + 1
		ENDIF

	NEXT
	
RETURN nResp
