//%attributes = {}
  //ACTac_EliminaRecargoImportacion

  //***************************************************************************************************************
  //Descripción:
  //                  Método para eliminar el Recargo Automático para los cargos pagados en el banco antes de la fecha de vencimiento
  //                  pero que son ingresados al sistema después de la fecha de vencimiento

  //parámetros:
  //                    Primer parámetro: ID Aviso de cobranza
  //                    Segundo parámetro: Fecha del pago

  //***************************************************************************************************************


READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Transacciones:178])

C_LONGINT:C283($1;$idAviso)
C_DATE:C307($FechaPago;$2)
C_TEXT:C284($0)

$idAviso:=$1
$FechaPago:=$2


If (($idAviso#0) & ($FechaPago#!00-00-00!))
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$idAviso)
	$vl_idCta:=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2
	$vl_idAl:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCta;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
	$vt_msj:=__ (" Aviso de Cobranza número: ")+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+"."
	$vt_msj:=ST_Boolean2Str (($vl_idAl#0);$vt_msj+" Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$vl_idAl;->[Alumnos:2]apellidos_y_nombres:40)+".";$vt_msj+" Apoderado: "+KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]Apellidos_y_nombres:30)+".")
	If ($FechaPago>[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
		$vd_fechaV:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
		$vd_fechaV:=Add to date:C393($vd_fechaV;0;1;0)
		$vd_fechaV:=DT_GetDateFromDayMonthYear (1;Month of:C24($vd_fechaV);Year of:C25($vd_fechaV))
		If ($FechaPago<=$vd_fechaV)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			READ WRITE:C146([ACT_Cargos:173])
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
			If (Records in selection:C76([ACT_Cargos:173])>1)
				ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53;<)
				REDUCE SELECTION:C351([ACT_Cargos:173];1)
				KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
				C_LONGINT:C283($vl_records)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ((Sum:C1([ACT_Cargos:173]MontosPagados:8)=0) & ($vl_records=0))
					ACTcc_EliminaCargosLoop 
					LOG_RegisterEvt (__ ("Eliminación de cargo generado como multa automática durante el proceso de importación de pagos.")+$vt_msj)
					$0:=""
				Else 
					$0:=__ ("Cargo de multa no puede ser eliminado porque está pagado o está en Documento Tributario.")
				End if 
			End if 
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
		End if 
	Else 
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		READ WRITE:C146([ACT_Cargos:173])
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
		If (Records in selection:C76([ACT_Cargos:173])>0)
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			C_LONGINT:C283($vl_records)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ((Sum:C1([ACT_Cargos:173]MontosPagados:8)=0) & ($vl_records=0))
				ACTcc_EliminaCargosLoop 
				LOG_RegisterEvt (__ ("Eliminación de cargo generado como multa automática durante el proceso de importación de pagos.")+$vt_msj)
				$0:=""
			Else 
				$0:=__ ("Cargo de multa no puede ser eliminado porque está pagado o está en Documento Tributario.")
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
	End if 
End if 
