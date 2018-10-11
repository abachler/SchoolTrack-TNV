//%attributes = {}
  // BBL_dcDelete()
  // Por: Alberto Bachler: 24/10/13, 12:09:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($r)
C_TEXT:C284($t_copias;$t_enReparacion;$t_enSala;$t_mensaje;$t_prestado;$t_textoLog;$t_tipoDocumento;$t_titulo)

ARRAY LONGINT:C221($al_ID_copias;0)
If (False:C215)
	C_LONGINT:C283(BBL_dcDelete ;$0)
End if 

If (USR_checkRights ("D";->[BBL_Items:61]))
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
	QUERY SELECTION:C341([BBL_Registros:66];[BBL_Registros:66]StatusID:34=Prestado;*)
	QUERY SELECTION:C341([BBL_Registros:66]; | ;[BBL_Registros:66]StatusID:34=En sala;*)
	QUERY SELECTION:C341([BBL_Registros:66]; | ;[BBL_Registros:66]StatusID:34=En Reparacion)
	If (Records in selection:C76([BBL_Registros:66])>0)
		$t_prestado:=<>aCpyStatus{Prestado}
		$t_enSala:=<>aCpyStatus{En sala}
		$t_enReparacion:=<>aCpyStatus{En Reparacion}
		$t_mensaje:=__ ("Este ítem tiene copias con estatus ^0, ^1 o ^2.\r\rNo es posible eliminar el item.")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_prestado))
		$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_enSala))
		$t_mensaje:=Replace string:C233($t_mensaje;"^2";IT_SetTextStyle_Bold (->$t_enReparacion))
		$r:=CD_Dlog (0;$t_mensaje)
	Else 
		$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar el ítem junto con sus copias, la historia de las transacciones efectuadas, sus descriptores y registros secundarios?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			OK:=1
			START TRANSACTION:C239
			QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
			SELECTION TO ARRAY:C260([BBL_Registros:66]ID:3;$al_ID_copias)
			
			OK:=KRL_DeleteSelection (->[BBL_Registros:66])
			If (OK=1)
				QUERY:C277([BBL_RegistrosAnaliticos:74];[BBL_RegistrosAnaliticos:74]ID:1=[BBL_Items:61]Numero:1)
				OK:=KRL_DeleteSelection (->[BBL_RegistrosAnaliticos:74])
			End if 
			If (OK=1)
				QUERY:C277([BBL_FichasCatalograficas:81];[BBL_FichasCatalograficas:81]Nº de item:5=[BBL_Items:61]Numero:1)
				OK:=KRL_DeleteSelection (->[BBL_FichasCatalograficas:81])
			End if 
			If (OK=1)
				QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_Item:2=[BBL_Items:61]Numero:1)
				OK:=KRL_DeleteSelection (->[BBL_Reservas:115])
			End if 
			If (OK=1)
				QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]ID_Item:1=[BBL_Items:61]Numero:1)
				OK:=KRL_DeleteSelection (->[BBL_ItemMarcFields:205])
			End if 
			If (OK=1)
				READ WRITE:C146([BBL_Items:61])
				$t_titulo:=[BBL_Items:61]Titulos:5
				$t_tipoDocumento:=[BBL_Items:61]Media:15
				DELETE RECORD:C58([BBL_Items:61])
				VALIDATE TRANSACTION:C240
				$t_textoLog:="Ha sido eliminado el item tipo "+$t_tipoDocumento+" titulado "+$t_titulo+" con ID "+String:C10([BBL_Items:61]Numero:1)+". "
				If (Size of array:C274($al_ID_copias)>0)
					$t_copias:=AT_array2text (->$al_ID_copias;", ")
					$t_textoLog:=$t_textoLog+"Y su(s) copia(s) con ID "+$t_copias+"."
				End if 
				LOG_RegisterEvt ($t_textoLog)
			Else 
				CANCEL TRANSACTION:C241
				CD_Dlog (0;__ ("El registro está siendo utilizado. Intente eliminarlo más tarde."))
			End if 
			$0:=OK
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3;2)
End if 