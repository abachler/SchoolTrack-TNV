Case of 
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET VISIBLE:C603(*;"vt_detalleNC";(Self:C308->=2))
		Case of 
			: (Self:C308->=2)
				vr_montoExento:=0
				vr_montoAfecto:=0
				vr_montoIVA:=0
				vr_montoTotal:=vr_montoExento+vr_montoAfecto+vr_montoIVA
				
			: (Self:C308->=1)
				$l_recNum:=Record number:C243([ACT_Boletas:181])
				
				vr_montoExento:=[ACT_Boletas:181]Monto_Total:6-[ACT_Boletas:181]Monto_IVA:5-[ACT_Boletas:181]Monto_Afecto:4
				vr_montoAfecto:=[ACT_Boletas:181]Monto_Afecto:4
				vr_montoIVA:=[ACT_Boletas:181]Monto_IVA:5
				
				  //20170513 RCH
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33="61";*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_DctoAsociado:19=[ACT_Boletas:181]ID:1)
				
				vr_montoExento:=vr_montoExento-(Sum:C1([ACT_Boletas:181]Monto_Total:6)-Sum:C1([ACT_Boletas:181]Monto_IVA:5)-Sum:C1([ACT_Boletas:181]Monto_Afecto:4))
				vr_montoAfecto:=vr_montoAfecto-[ACT_Boletas:181]Monto_Afecto:4
				vr_montoIVA:=vr_montoIVA-[ACT_Boletas:181]Monto_IVA:5
				vr_montoTotal:=vr_montoTotal-(vr_montoExento+vr_montoAfecto+vr_montoIVA)
				
				GOTO RECORD:C242([ACT_Boletas:181];$l_recNum)
				
				  //20150508 RCH todos los items deben ser incluidos
				For ($l_item;1;Size of array:C274(abACT_ItemsSeleccionado))
					abACT_ItemsSeleccionado{$l_item}:=True:C214
				End for 
				
				
				If (False:C215)  //RCH Para realizar pruebas antes de implementar cambios. Si se elige Anular documento de referencia, se debe tener seleccionado todos los cargos de la boleta y no se debe haber emitido una NC previamente.
					$b_apruebaCambioEstado:=True:C214
					Case of 
						: (vr_montoExento>vr_MaxExento)
							$b_apruebaCambioEstado:=False:C215
							
						: (vr_montoAfecto>vr_MaxAfecto)
							$b_apruebaCambioEstado:=False:C215
							
						: (vr_montoIVA>vr_MaxIVA)
							$b_apruebaCambioEstado:=False:C215
							
					End case 
					
					If (Not:C34($b_apruebaCambioEstado))
						Self:C308->:=0
						CD_Dlog (0;"Para seleccionar esta razón de referencia, se debe incluir en la misma Nota de Crédito todos los montos del documento original.")
					End if 
					
				End if 
				
		End case 
		
		  //20150508 RCH
		OBJECT SET ENTERABLE:C238(lb_seleccion;(Self:C308->#1))
		
		vt_refRazon:=atACT_referencia{atACT_referencia}
		  //OBJECT SET VISIBLE(*;"referencia_cod2_@";((atACT_referencia=2) & vb_documentElectronico))
End case 