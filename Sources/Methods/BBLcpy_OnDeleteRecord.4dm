//%attributes = {}
  // BBLcpy_OnDeleteRecord()
  // Por: Alberto Bachler: 17/09/13, 13:12:05
  //  ---------------------------------------------
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($l_idRegistro;$l_numeroCopia;$l_numeroRegistro;$l_respuesta;$l_recNum)
C_TEXT:C284($t_codigoBarra)
If (False:C215)
	C_LONGINT:C283(BBLcpy_OnDeleteRecord ;$0)
End if 
If (([BBL_Registros:66]StatusID:34=Prestado) | ([BBL_Registros:66]StatusID:34=En sala) | ([BBL_Registros:66]StatusID:34=En Reparacion))
	$t_prestado:=<>aCpyStatus{Prestado}
	$t_enSala:=<>aCpyStatus{En sala}
	$t_enReparacion:=<>aCpyStatus{En Reparacion}
	$t_mensaje:=__ ("Este ítem tiene copias con estatus ^0, ^1 o ^2.\r\rNo es posible eliminar el item.")
	$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_prestado))
	$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_enSala))
	$t_mensaje:=Replace string:C233($t_mensaje;"^2";IT_SetTextStyle_Bold (->$t_enReparacion))
	$r:=CD_Dlog (0;$t_mensaje)
Else 
	READ ONLY:C145([BBL_Prestamos:60])
	$l_recNum:=Find in field:C653([BBL_Prestamos:60]Número_de_registro:1;[BBL_Registros:66]ID:3)
	If ($l_recNum>=0)  //si hay al menos un registro de préstamos se despliega un mensaje de confirmación
		$l_respuesta:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar esta copia y su historia de transacciones?");__ ("");__ ("No");__ ("Si"))
		If ($l_respuesta=2)
			READ WRITE:C146([BBL_ItemMarcFields:205])
			QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]ID_Copia:9=[BBL_Registros:66]ID:3)
			DELETE SELECTION:C66([BBL_ItemMarcFields:205])
			KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])
			DELETE RECORD:C58([BBL_Registros:66])
			SQ_RestauraSecuencias (->[BBL_Registros:66]No_Registro:25)
			READ ONLY:C145([BBL_Registros:66])
			SCAN INDEX:C350([BBL_Registros:66]No_Registro:25;1;<)
			Mti_BarCode:=[BBL_Registros:66]No_Registro:25+1
			READ ONLY:C145([BBL_Prestamos:60])
			CANCEL:C270
			$0:=1
			
			  //Ticket 158188//Actualización de cantidades en bbl items
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
			QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
			[BBL_Items:61]Copias:24:=$l_registros
			QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1;*)
			QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]StatusID:34=Disponible)
			[BBL_Items:61]Copias_disponibles:43:=$l_registros
			QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1;*)
			QUERY SELECTION:C341([BBL_Registros:66]; & ;[BBL_Registros:66]StatusID:34=Reservado)
			[BBL_Items:61]Copias_reservadas:44:=$l_registros
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			SAVE RECORD:C53([BBL_Items:61])
			
		End if 
	Else 
		READ WRITE:C146([BBL_ItemMarcFields:205])
		QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]ID_Copia:9=[BBL_Registros:66]ID:3)
		DELETE SELECTION:C66([BBL_ItemMarcFields:205])
		KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])
		$l_idRegistro:=[BBL_Registros:66]ID:3
		$l_numeroCopia:=[BBL_Registros:66]Número_de_copia:2
		$l_numeroRegistro:=[BBL_Registros:66]No_Registro:25
		$t_codigoBarra:=[BBL_Registros:66]Código_de_barra:20
		DELETE RECORD:C58([BBL_Registros:66])
		LOG_RegisterEvt ("Se eliminó la copia "+String:C10($l_numeroCopia)+" ID "+String:C10($l_idRegistro)+" n° de registro "+String:C10($l_numeroRegistro)+" Código de barras "+$t_codigoBarra+" del "+[BBL_Items:61]Media:15+" - "+[BBL_Items:61]Titulos:5+" ID: "+String:C10([BBL_Items:61]Numero:1))
		SQ_RestauraSecuencias (->[BBL_Registros:66]No_Registro:25)
		READ ONLY:C145([BBL_Registros:66])
		SCAN INDEX:C350([BBL_Registros:66]No_Registro:25;1;<)
		Mti_BarCode:=[BBL_Registros:66]No_Registro:25+1
		READ ONLY:C145([BBL_Prestamos:60])
		CANCEL:C270
		$0:=1
	End if 
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
	If (Records in selection:C76([BBL_Registros:66])>0)
		SELECTION TO ARRAY:C260([BBL_Registros:66]Lugar:13;$at_lugares)
		AT_DistinctsArrayValues (->$at_lugares)
		[BBL_Items:61]Lugares:51:=AT_array2text (->$at_lugares;", ")
	Else 
		[BBL_Items:61]Lugares:51:=""
	End if 
	  //Ticket 158188//Actualización de cantidades en bbl items
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
	[BBL_Items:61]Copias:24:=$l_registros
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1;*)
	QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]StatusID:34=Disponible)
	[BBL_Items:61]Copias_disponibles:43:=$l_registros
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1;*)
	QUERY SELECTION:C341([BBL_Registros:66]; & ;[BBL_Registros:66]StatusID:34=Reservado)
	[BBL_Items:61]Copias_reservadas:44:=$l_registros
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SAVE RECORD:C53([BBL_Items:61])
	BBLitm_ActualizaFichasCatalogo 
End if 