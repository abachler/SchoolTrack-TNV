  // SeleccionValor.vt_TextoBuscado1()
  // Por: Alberto Bachler K.: 12-02-15, 14:42:50
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_columna;$l_evento;$l_filaSeleccionada;$l_registros;$max)
C_POINTER:C301($y_lista;$y_tabla)

$l_evento:=Form event:C388

$y_lista:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_lista")
$y_tabla:=Table:C252(Table:C252(vy_campoSeleccion))

Case of 
	: ($l_evento=On Before Keystroke:K2:6)
		Case of 
			: (Character code:C91(Keystroke:C390)=30)  //flecha arriba
				LISTBOX GET CELL POSITION:C971(*;"lb_lista";$l_columna;$l_filaSeleccionada)
				$l_registros:=Records in set:C195("$seleccionCampo")
				If (LISTBOX Get number of rows:C915(*;"lb_lista")>0)
					Case of 
						: ($l_filaSeleccionada=0)
							LISTBOX SELECT ROW:C912(*;"lb_lista";1;lk replace selection:K53:1)
						: ($l_filaSeleccionada>1)
							LISTBOX SELECT ROW:C912(*;"lb_lista";0;lk replace selection:K53:1)
							LISTBOX SELECT ROW:C912(*;"lb_lista";$l_filaSeleccionada-1;lk replace selection:K53:1)
						Else 
							LISTBOX SELECT ROW:C912(*;"lb_lista";LISTBOX Get number of rows:C915(*;"lb_lista");lk replace selection:K53:1)
					End case 
					FILTER KEYSTROKE:C389("")
				End if 
				GOTO OBJECT:C206(Self:C308->)
				POST KEY:C465(Character code:C91("*");Command key mask:K16:1)
				OBJECT SET SCROLL POSITION:C906(*;"lb_lista";$l_filaSeleccionada-1)
				
			: (Character code:C91(Keystroke:C390)=31)  //flecha abajo
				$l_filaSeleccionada:=0
				LISTBOX GET CELL POSITION:C971(*;"lb_lista";$l_columna;$l_filaSeleccionada)
				$l_registros:=Records in set:C195("$seleccionCampo")
				If (LISTBOX Get number of rows:C915(*;"lb_lista")>0)
					Case of 
						: ($l_registros=0)
							LISTBOX SELECT ROW:C912(*;"lb_lista";1;lk replace selection:K53:1)
						: (($l_filaSeleccionada>=1) & ($l_filaSeleccionada<LISTBOX Get number of rows:C915(*;"lb_lista")))
							LISTBOX SELECT ROW:C912(*;"lb_lista";0;lk replace selection:K53:1)
							LISTBOX SELECT ROW:C912(*;"lb_lista";$l_filaSeleccionada+1;lk replace selection:K53:1)
						: ($l_filaSeleccionada=LISTBOX Get number of rows:C915(*;"lb_lista"))
							LISTBOX SELECT ROW:C912(*;"lb_lista";1;lk replace selection:K53:1)
					End case 
					FILTER KEYSTROKE:C389("")
				End if 
				GOTO OBJECT:C206(Self:C308->)
				POST KEY:C465(Character code:C91("*");Command key mask:K16:1)
				OBJECT SET SCROLL POSITION:C906(*;"lb_lista";$l_filaSeleccionada+1)
				
			Else 
				  //Any other keystroke do nothing
		End case 
		
	: ($l_evento=On After Keystroke:K2:26)
		If ((Character code:C91(Keystroke:C390)=28) | (Character code:C91(Keystroke:C390)=29))  //Left and right arrow keys
			  //nada
		Else 
			
			$y_tabla:=Table:C252(Table:C252(vy_campoSeleccion))
			QUERY:C277($y_tabla->;vy_campoSeleccion->;=;Get edited text:C655+"@")
			$l_registros:=Records in selection:C76($y_tabla->)
			ORDER BY:C49($y_tabla->;vy_campoSeleccion->;>)
			CUT NAMED SELECTION:C334($y_tabla->;"$seleccionPredictivo")
			(OBJECT Get pointer:C1124(Object named:K67:5;"largoTextoEditado"))->:=Length:C16(Get edited text:C655)+1
			vt_textoBuscado:=Get edited text:C655
			
			Case of 
				: (vt_textoBuscado="")
					CANCEL:C270
					
				: ($l_registros=0)
					ACCEPT:C269
					
			End case 
			
		End if 
End case 
