//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 28-06-18, 13:21:28
  // ----------------------------------------------------
  // Método: ACTinf_CalculaMontoTramoxAviso
  // Descripción: Estructura del objeto entregado como respuesta
  //  id_aviso:{
  //            id_cargo1:{detalle},
  //            id_cargo2:{detalle}
  //           }
  //}
  // Parámetros
  // ----------------------------------------------------

READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([xxACT_ItemsTramos:291])

ARRAY LONGINT:C221($al_recNumCargos;0)

C_OBJECT:C1216($o_avisos;$o_temporal;$o_cargosDetalle;$ob_tramo)
C_BOOLEAN:C305($b_grabar)
C_LONGINT:C283($l_idAviso)

$y_arrayAvisosID:=$1
$y_avisos:=$2
$b_grabar:=False:C215

For ($l_indiceAvisos;1;Size of array:C274($y_arrayAvisosID->))
	$l_idAviso:=$y_arrayAvisosID->{$l_indiceAvisos}
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$l_idAviso)
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNumCargos)
	
	
	For ($l_indice;1;Size of array:C274($al_recNumCargos))
		GOTO RECORD:C242([ACT_Cargos:173];$al_recNumCargos{$l_indice})
		
		vb_emitidoEnMonedaCargo:=[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11
		$vd_FechaVencAvisoMulta:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
		$vl_mes:=Month of:C24($vd_FechaVencAvisoMulta)
		$vl_year:=Year of:C25($vd_FechaVencAvisoMulta)
		
		ACTitems_OpcionesRecalculoTramo ("BuscaTramoItem";->[ACT_Cargos:173]Ref_Item:16)
		If (Size of array:C274(alACT_idTramo)>0)
			$b_grabar:=True:C214
			For ($l_indiceTramo;1;Size of array:C274(alACT_idTramo))
				$vr_monto:=0
				$l_idTramo:=alACT_idTramo{$l_indiceTramo}
				KRL_FindAndLoadRecordByIndex (->[xxACT_ItemsTramos:291]id:1;->$l_idTramo)
				$vr_monto:=Num:C11(ACTitems_OpcionesRecalculoTramo ("CalculaMontoTramoCargo"))
				If ([xxACT_ItemsTramos:291]dia_tramo_desde:3>0)
					$d_fechaTramo:=DT_GetDateFromDayMonthYear ([xxACT_ItemsTramos:291]dia_tramo_desde:3;$vl_mes;$vl_year)
				End if 
				
				OB SET:C1220($o_temporal;"MontoTramo";$vr_monto)
				OB SET:C1220($o_temporal;"FechaTramo";String:C10($d_fechaTramo))
				OB SET:C1220($o_temporal;"TramoID";[xxACT_ItemsTramos:291]id:1)
				OB SET:C1220($o_temporal;"CargoGlosa";[ACT_Cargos:173]Glosa:12)
				OB SET:C1220($o_temporal;"ValorTramo";[xxACT_ItemsTramos:291]valor:6)
				
				OB SET:C1220($ob_tramo;String:C10([xxACT_ItemsTramos:291]id:1);$o_temporal)
				CLEAR VARIABLE:C89($o_temporal)
				
			End for 
			OB SET:C1220($o_cargosDetalle;String:C10([ACT_Cargos:173]ID:1);$ob_tramo)
			CLEAR VARIABLE:C89($ob_tramo)
		Else 
			$b_grabar:=False:C215
		End if 
	End for 
	If ($b_grabar)
		OB SET:C1220($y_avisos->;String:C10($l_idAviso);$o_cargosDetalle)
		CLEAR VARIABLE:C89($o_cargosDetalle)
	End if 
End for 

