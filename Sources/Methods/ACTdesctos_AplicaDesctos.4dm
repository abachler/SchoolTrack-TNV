//%attributes = {}
  //ACTdesctos_AplicaDesctos

If (vb_AplicarDesctos)
	ARRAY LONGINT:C221(alACT_CuentasAplicar;0)
	For ($i;4;Size of array:C274(alACT_IDCtas);3)
		If (arACT_Totales{$i-1}#0)
			AT_Insert (0;1;->alACT_CuentasAplicar)
			alACT_CuentasAplicar{Size of array:C274(alACT_CuentasAplicar)}:=alACT_IDCtas{$i-2}
		End if 
	End for 
	If (Size of array:C274(alACT_CuentasAplicar)>0)
		ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
		ARRAY DATE:C224(adACT_fechasEm;0)
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([xxACT_ItemsMatriz:180])
		READ ONLY:C145([xxACT_DesctosXItem:103])
		$procID:=IT_UThermometer (1;0;__ ("Aplicando descuentos..."))
		For ($i;1;Size of array:C274(alACT_CuentasAplicar))
			$cta:=Find in array:C230(aCtasCargos{1};alACT_CuentasAplicar{$i})
			If ($cta#-1)
				$size:=Size of array:C274(aCtasCargos)
				For ($j;4;$size)
					$id:=aCtasCargos{$j}{$cta}
					$cargo:=Find in field:C653([ACT_Cargos:173]ID:1;$id)
					If ($cargo#-1)
						READ WRITE:C146([ACT_Cargos:173])
						GOTO RECORD:C242([ACT_Cargos:173];$cargo)
						$desctoTotal:=apACT_Glosas{$j-3}->{$cta+1}+apACT_Glosas{$j-3}->{1}+arACT_DesctoXAlumno{$cta}
						READ WRITE:C146([xxACT_DesctosXItem:103])
						QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
						If (b1=1)
							If ($desctoTotal>100)
								$desctoTotal:=100
							End if 
							  //If ($desctoTotal*[ACT_Cargos]Monto_Neto>[ACT_Cargos]Monto_Neto) `Incidente 65473
							  //$desctoTotal:=([ACT_Cargos]Monto_Neto*100)/([ACT_Cargos]Monto_Neto+[ACT_Cargos]Descuentos_Familia+[ACT_Cargos]Descuentos_Individual+[ACT_Cargos]Descuentos_Ingresos+[ACT_Cargos]Descuentos_Cargas)
							  //End if 
							[ACT_Cargos:173]PctDescto_XItem:34:=$desctoTotal
						Else 
							If ($desctoTotal>apACT_Glosas{$j-3}->{$cta})
								$desctoTotal:=apACT_Glosas{$j-3}->{$cta}
							End if 
							[ACT_Cargos:173]PctDescto_XItem:34:=0
							  //[ACT_Cargos]Descuentos_XItem:=0
							  //[ACT_Cargos]Descuentos_XItemMoneda:=0
						End if 
						SAVE RECORD:C53([ACT_Cargos:173])
						If ($desctoTotal#0)
							If (Records in selection:C76([xxACT_DesctosXItem:103])=0)
								CREATE RECORD:C68([xxACT_DesctosXItem:103])
								[xxACT_DesctosXItem:103]ID:1:=SQ_SeqNumber (->[xxACT_DesctosXItem:103]ID:1)
							End if 
							If (b1=1)
								[xxACT_DesctosXItem:103]Pct_DesctoXItem:3:=[ACT_Cargos:173]PctDescto_XItem:34
								[xxACT_DesctosXItem:103]Descto_XItem:4:=0
							Else 
								[xxACT_DesctosXItem:103]Pct_DesctoXItem:3:=0
								[xxACT_DesctosXItem:103]Descto_XItem:4:=$desctoTotal
							End if 
							[xxACT_DesctosXItem:103]Ref_Item:2:=[ACT_Cargos:173]Ref_Item:16
							[xxACT_DesctosXItem:103]ID_Cargo:8:=[ACT_Cargos:173]ID:1
							[xxACT_DesctosXItem:103]ID_CtaCte:5:=alACT_CuentasAplicar{$i}
							If (Position:C15(" (des";[ACT_Cargos:173]Glosa:12)#0)
								$glosa:=Substring:C12([ACT_Cargos:173]Glosa:12;1;Position:C15(" (de";[ACT_Cargos:173]Glosa:12)-1)
							Else 
								$glosa:=[ACT_Cargos:173]Glosa:12
							End if 
							[xxACT_DesctosXItem:103]GlosaExtra:6:=$glosa
							[xxACT_DesctosXItem:103]Fecha_Generacion:7:=[ACT_Cargos:173]Fecha_de_generacion:4
							SAVE RECORD:C53([xxACT_DesctosXItem:103])
							$rn:=Record number:C243([ACT_Cargos:173])
							$doc:=Find in field:C653([ACT_Documentos_de_Cargo:174]ID_Documento:1;[ACT_Cargos:173]ID_Documento_de_Cargo:3)
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
							$idmatriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7
							ACTcfg_loadMatrixItems ([ACT_CuentasCorrientes:175]ID_Matriz:7)
							QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$idmatriz;*)
							QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
							UNLOAD RECORD:C212([ACT_Cargos:173])
							If (Records in selection:C76([xxACT_ItemsMatriz:180])>0)
								$itemnomatriz:=False:C215
							Else 
								$itemnomatriz:=True:C214
							End if 
							  // Modificado por: Saul Ponce (28-08-2018) Ticket Nº 215404, la variable de proceso se encontraba indefinida. viACT_DiaDeuda, se carga al invocar ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")
							viACT_DiaGeneracion:=viACT_DiaDeuda
							$fecha:=DT_GetDateFromDayMonthYear (viACT_DiaGeneracion;vl_Mes;vl_Año)
							READ ONLY:C145([ACT_Documentos_de_Cargo:174])
							GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$doc)
							ACTcc_CalculaMontoItem ($rn;$idmatriz;$itemnomatriz;$fecha;"Generacion de Descuentos")
							ACTcc_CalculaDocumentoCargo ($doc)
						End if 
					End if 
				End for 
			End if 
		End for 
		IT_UThermometer (-2;$procID)
		UNLOAD RECORD:C212([xxACT_DesctosXItem:103])
		READ ONLY:C145([xxACT_DesctosXItem:103])
		UNLOAD RECORD:C212([ACT_Cargos:173])
		READ ONLY:C145([ACT_Cargos:173])
	Else 
		CD_Dlog (0;__ ("No se ingresaron descuentos para aplicar."))
	End if 
End if 