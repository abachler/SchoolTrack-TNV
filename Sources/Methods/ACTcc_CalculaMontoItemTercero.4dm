//%attributes = {}
  //ACTcc_CalculaMontoItemTercero

C_TEXT:C284($vt_key;$key)
C_LONGINT:C283($id_dctoCargo;$id_apdo)
C_DATE:C307($ufDate;$2)
READ ONLY:C145([ACT_Terceros:138])
READ ONLY:C145([ACT_Terceros_Pactado:139])
ARRAY LONGINT:C221($al_idsTerceros;0)
ARRAY LONGINT:C221($al_recNumNuevosCargos;0)
C_BOOLEAN:C305($vl_cargoRelacionado)

$vl_cargoRelacionado:=$1
$ufDate:=$2

$vl_recNumCargo:=Record number:C243([ACT_Cargos:173])
$vl_idCargo:=[ACT_Cargos:173]ID:1
$id_dctoCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
$vl_idCta:=[ACT_Cargos:173]ID_CuentaCorriente:2
$vl_idItem:=[ACT_Cargos:173]Ref_Item:16
$vr_montoNetoCargoOriginal:=[ACT_Cargos:173]Monto_Neto:5
$vb_descuento:=$vr_montoNetoCargoOriginal<0

$vt_key:=String:C10($vl_idCta)+"."+String:C10($vl_idItem)+".@"

  //If (($vl_idCargo#0) & (Not($vl_cargoRelacionado))) //20130801 ASM y RCH se valida para cuando el id de cuenta es igual a cero.
If (($vl_idCargo#0) & (Not:C34($vl_cargoRelacionado) & ($vl_idCta#0)))
	
	READ WRITE:C146([ACT_Cargos:173])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54#0;*)
	  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]ID_CargoRelacionado=$vl_idCargo)
	
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargo;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7=!00-00-00!)  //20160829 RCH. Ticket 166316.
	
	  //DELETE SELECTION([ACT_Cargos])
	
	If (Records in selection:C76([ACT_Cargos:173])>0)
		CREATE SET:C116([ACT_Cargos:173];"ACT_Cargos2Del1")
		KRL_RelateSelection (->[ACT_Cargos:173]ID_CargoRelacionado:47;->[ACT_Cargos:173]ID:1;"")
		CREATE SET:C116([ACT_Cargos:173];"ACT_Cargos2Del2")
		UNION:C120("ACT_Cargos2Del1";"ACT_Cargos2Del2";"ACT_Cargos2Del1")
		USE SET:C118("ACT_Cargos2Del1")
		DELETE SELECTION:C66([ACT_Cargos:173])
		If (Records in set:C195("LockedSet")>0)
			TRACE:C157
		End if 
		SET_ClearSets ("ACT_Cargos2Del1";"ACT_Cargos2Del2")
	End if 
	READ WRITE:C146([ACT_Cargos:173])
	GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo)
	If ([ACT_Cargos:173]ID_CargoRelacionado:47=0)
		Case of 
			: (Not:C34([ACT_Cargos:173]EsRelativo:10))
				QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Key:7=$vt_key;*)
				QUERY:C277([ACT_Terceros_Pactado:139]; & ;[ACT_Terceros_Pactado:139]Utilizar_Conf:10=True:C214)
				
				If (Records in selection:C76([ACT_Terceros_Pactado:139])>0)
					ARRAY REAL:C219($ar_montosTerceros;0)
					KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Terceros_Pactado:139]Id_Tercero:2;"")
					QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]Inactivo:24=False:C215)
					AT_DistinctsFieldValues (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->$al_idsTerceros)
					  //If ([ACT_Cargos]EmitidoSegúnMonedaCargo)
					  //$vt_moneda:=[ACT_Cargos]Moneda
					  //Else 
					  //$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
					  //End if 
					
					  // Modificado por: Saúl Ponce (21-03-2017) Ticket 177190, selecciona la moneda.
					$vt_moneda:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
					
					For ($i;1;Size of array:C274($al_idsTerceros))
						$vl_idTercero:=$al_idsTerceros{$i}
						$vt_key:=String:C10($vl_idCta)+"."+String:C10($vl_idItem)+"."+String:C10($vl_idTercero)
						KRL_FindAndLoadRecordByIndex (->[ACT_Terceros_Pactado:139]Key:7;->$vt_key)
						$vr_montoFijo:=[ACT_Terceros_Pactado:139]Monto_Pactado_Fijo:5
						  // Modificado por: Saúl Ponce (21-03-2017) Ticket 177190, convierte los montos fijos pactados a la moneda que corresponda.
						$vr_montoFijo:=Round:C94(ACTut_retornaMontoEnMoneda ($vr_montoFijo;<>vtACT_monedaPais;Current date:C33(*);$vt_moneda);Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda)))
						If ([ACT_Terceros_Pactado:139]Monto_Pactado_PCT:6>0)
							$vr_montoPct:=Abs:C99(Round:C94($vr_montoNetoCargoOriginal*([ACT_Terceros_Pactado:139]Monto_Pactado_PCT:6/100);Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda))))
						Else 
							$vr_montoPct:=0
						End if 
						$vr_montoTercero:=$vr_montoFijo+$vr_montoPct
						If ($vb_descuento)
							$vr_montoTercero:=$vr_montoTercero*-1
						End if 
						If (Abs:C99($vr_montoTercero)>Abs:C99($vr_montoNetoCargoOriginal))
							$vr_montoTercero:=$vr_montoNetoCargoOriginal
						End if 
						$vr_montoNetoCargoOriginal:=Abs:C99($vr_montoNetoCargoOriginal)-Abs:C99($vr_montoTercero)
						If ($vb_descuento)
							$vr_montoNetoCargoOriginal:=Abs:C99($vr_montoNetoCargoOriginal)*-1
						End if 
						APPEND TO ARRAY:C911($ar_montosTerceros;$vr_montoTercero)
					End for 
					
					$vr_montoTotalTerceros:=AT_GetSumArray (->$ar_montosTerceros)
					READ WRITE:C146([ACT_Cargos:173])
					GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo)
					
					[ACT_Cargos:173]Monto_Neto:5:=$vr_montoNetoCargoOriginal
					[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Bruto:24-$vr_montoTotalTerceros
					
					[ACT_Cargos:173]Monto_Tercero:55:=$vr_montoTotalTerceros
					[ACT_Cargos:173]Monto_Moneda:9:=[ACT_Cargos:173]Monto_Moneda:9-$vr_montoTotalTerceros
					SAVE RECORD:C53([ACT_Cargos:173])
					
					For ($i;1;Size of array:C274($ar_montosTerceros))
						GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo)
						$vt_glosa:=[ACT_Cargos:173]Glosa:12
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54=$al_idsTerceros{$i};*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargo)
						If (Records in selection:C76([ACT_Cargos:173])=0)
							GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo)
							DUPLICATE RECORD:C225([ACT_Cargos:173])
							[ACT_Cargos:173]Auto_UUID:66:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
						Else 
							FIRST RECORD:C50([ACT_Cargos:173])
						End if 
						[ACT_Cargos:173]ID_Tercero:54:=$al_idsTerceros{$i}
						[ACT_Cargos:173]Monto_Neto:5:=$ar_montosTerceros{$i}
						[ACT_Cargos:173]Monto_Moneda:9:=$ar_montosTerceros{$i}
						[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
						[ACT_Cargos:173]Monto_Tercero:55:=0
						[ACT_Cargos:173]Descuentos_Familia:26:=0
						[ACT_Cargos:173]Descuentos_Ingresos:25:=0
						[ACT_Cargos:173]Descuentos_Cargas:51:=0
						[ACT_Cargos:173]Descuentos_Individual:31:=0
						[ACT_Cargos:173]Descuentos_XItem:35:=0
						[ACT_Cargos:173]MontoXPctDescto:36:=0
						[ACT_Cargos:173]PctDescto_XItem:34:=0
						[ACT_Cargos:173]Glosa:12:=$vt_glosa
						[ACT_Cargos:173]Monto_Moneda:9:=ACTut_retornaMontoEnMoneda ([ACT_Cargos:173]Monto_Neto:5;$vt_moneda;vdACT_FechaUFSel;KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;->[xxACT_Items:179]Moneda:10))
						SAVE RECORD:C53([ACT_Cargos:173])
						
						APPEND TO ARRAY:C911($al_recNumNuevosCargos;Record number:C243([ACT_Cargos:173]))
						
						READ ONLY:C145([ACT_Documentos_de_Cargo:174])
						
						KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$id_dctoCargo)
						$id_apdo:=[ACT_Documentos_de_Cargo:174]ID_Apoderado:12
						$key:=String:C10([ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)+"."+String:C10([ACT_Documentos_de_Cargo:174]Año:14)+"."+String:C10([ACT_Documentos_de_Cargo:174]Mes:13)+"."+String:C10([ACT_Documentos_de_Cargo:174]ID_Matriz:2)
						QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]Key_Emision:25=$key)
						QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Apoderado:12=$id_apdo)
						QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Tercero:24=$al_idsTerceros{$i})
						If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0)
							KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
							DUPLICATE RECORD:C225([ACT_Documentos_de_Cargo:174])
							[ACT_Documentos_de_Cargo:174]ID_Documento:1:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
							[ACT_Documentos_de_Cargo:174]ID_Tercero:24:=$al_idsTerceros{$i}
							[ACT_Documentos_de_Cargo:174]Auto_UUID:26:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
							SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
						End if 
						If (alACT_NewDctoCargo=1)
							If (Find in array:C230(alACT_NewDctoCargo;Record number:C243([ACT_Documentos_de_Cargo:174]))=-1)
								APPEND TO ARRAY:C911(alACT_NewDctoCargo;Record number:C243([ACT_Documentos_de_Cargo:174]))
							End if 
						End if 
						[ACT_Cargos:173]ID_Documento_de_Cargo:3:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
						SAVE RECORD:C53([ACT_Cargos:173])
					End for 
				End if 
				
			: ([ACT_Cargos:173]EsRelativo:10)
				QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Key:7=$vt_key;*)
				QUERY:C277([ACT_Terceros_Pactado:139]; & ;[ACT_Terceros_Pactado:139]Utilizar_Conf:10=True:C214)
				If (Records in selection:C76([ACT_Terceros_Pactado:139])>0)
					KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Terceros_Pactado:139]Id_Tercero:2;"")
					QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]Inactivo:24=False:C215)
					AT_DistinctsFieldValues (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->$al_idsTerceros)
					
					For ($i;1;Size of array:C274($al_idsTerceros))
						GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo)
						$vt_glosa:=[ACT_Cargos:173]Glosa:12
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54=$al_idsTerceros{$i};*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargo)
						If (Records in selection:C76([ACT_Cargos:173])=0)
							GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo)
							DUPLICATE RECORD:C225([ACT_Cargos:173])
							[ACT_Cargos:173]Auto_UUID:66:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
						Else 
							FIRST RECORD:C50([ACT_Cargos:173])
						End if 
						[ACT_Cargos:173]ID_Tercero:54:=$al_idsTerceros{$i}
						SAVE RECORD:C53([ACT_Cargos:173])
						
						READ ONLY:C145([ACT_Documentos_de_Cargo:174])
						KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$id_dctoCargo)
						$id_apdo:=[ACT_Documentos_de_Cargo:174]ID_Apoderado:12
						$key:=String:C10([ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)+"."+String:C10([ACT_Documentos_de_Cargo:174]Año:14)+"."+String:C10([ACT_Documentos_de_Cargo:174]Mes:13)+"."+String:C10([ACT_Documentos_de_Cargo:174]ID_Matriz:2)
						QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]Key_Emision:25=$key)
						QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Apoderado:12=$id_apdo)
						QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Tercero:24=$al_idsTerceros{$i})
						If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0)
							KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
							DUPLICATE RECORD:C225([ACT_Documentos_de_Cargo:174])
							[ACT_Documentos_de_Cargo:174]ID_Documento:1:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
							[ACT_Documentos_de_Cargo:174]ID_Tercero:24:=$al_idsTerceros{$i}
							[ACT_Documentos_de_Cargo:174]Auto_UUID:26:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
							SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
						End if 
						If (alACT_NewDctoCargo=1)
							If (Find in array:C230(alACT_NewDctoCargo;Record number:C243([ACT_Documentos_de_Cargo:174]))=-1)
								APPEND TO ARRAY:C911(alACT_NewDctoCargo;Record number:C243([ACT_Documentos_de_Cargo:174]))
							End if 
						End if 
						[ACT_Cargos:173]ID_Documento_de_Cargo:3:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
						SAVE RECORD:C53([ACT_Cargos:173])
						APPEND TO ARRAY:C911($al_recNumNuevosCargos;Record number:C243([ACT_Cargos:173]))
					End for 
				End if 
		End case 
	End if 
	
	For ($i;1;Size of array:C274($al_recNumNuevosCargos))
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
		$idmatriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$idmatriz)
		QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
		UNLOAD RECORD:C212([ACT_Cargos:173])
		If (Records in selection:C76([xxACT_ItemsMatriz:180])>0)
			$itemnomatriz:=False:C215
		Else 
			$itemnomatriz:=True:C214
		End if 
		ACTcc_CalculaMontoItem ($al_recNumNuevosCargos{$i};$idmatriz;$itemnomatriz;$ufDate;"";True:C214)
		KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$vl_idItem)
		READ WRITE:C146([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Cargos:173];$al_recNumNuevosCargos{$i})
		[ACT_Cargos:173]ID_CargoRelacionado:47:=$vl_idCargo
		SAVE RECORD:C53([ACT_Cargos:173])
	End for 
	
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$id_dctoCargo)
	
	READ WRITE:C146([ACT_Cargos:173])
	GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo)
End if 