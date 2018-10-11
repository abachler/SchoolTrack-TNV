Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(vb_selectionItems2Pay)
		If (Size of array:C274(aRut)>0)
			XS_SetInterface 
			vt_mensajeDiferencia:=""
			If (vb_selectionItems2Pay)
				vt_mensajeDiferencia:=__ ("Al marcar la opcion ")+ST_Qte (__ ("Seleccionar ítems a pagar"))+__ ("  la columna diferencia podría variar.")
			End if 
			AL_RemoveArrays (xALP_DatosImportados;20)
			For ($i;1;Size of array:C274(at_arreglos2Import))
				  //AL_UpdateArrays (xALP_DatosImportados;-2)
				$Error:=AL_SetArraysNam (xALP_DatosImportados;$i;1;at_arreglos2Import{$i})
				AL_SetHeaders (xALP_DatosImportados;$i;1;at_headers2Import{$i})
				AL_SetWidths (xALP_DatosImportados;$i;1;0)
				$ptr:=Get pointer:C304(at_arreglos2Import{$i})
				$tipo:=Type:C295($ptr->)
				Case of 
					: ($tipo=18)  //arreglos texto
						AL_SetFormat (xALP_DatosImportados;$i;"";1;2;0;0)
					: ($tipo=14)  //arreglos real
						AL_SetFormat (xALP_DatosImportados;$i;"|Despliegue_ACT_Pagos";3;2;0;0)
					: ($tipo=16)  //arreglos long
						AL_SetFormat (xALP_DatosImportados;$i;"|Long";3;2;0;0)
					: ($tipo=17)  //arreglos fecha
						AL_SetFormat (xALP_DatosImportados;$i;"0";3;2;0;0)
				End case 
				AL_SetHdrStyle (xALP_DatosImportados;$i;"Tahoma";9;1)
				AL_SetFtrStyle (xALP_DatosImportados;$i;"Tahoma";9;0)
				AL_SetStyle (xALP_DatosImportados;$i;"Tahoma";9;0)
				AL_SetBackColor (xALP_DatosImportados;$i;"White";0;"White";0;"White";0)
				AL_SetForeColor (xALP_DatosImportados;$i;"Black";0;"Black";0;"Black";0)
			End for 
			noRegistrosTotal2Import:=Size of array:C274(aRut)
			For ($i;1;Size of array:C274(aRut))
				If (aCodAprobacion{$i}="0")
					AL_SetRowColor (xALP_DatosImportados;$i;"Green";0)
					AL_SetRowStyle (xALP_DatosImportados;$i;0)
					AL_SetCellEnter (xALP_DatosImportados;1;$i;Size of array:C274(at_arreglos2Import))
				Else 
					AL_SetRowColor (xALP_DatosImportados;$i;"Red";0)
					AL_SetRowStyle (xALP_DatosImportados;$i;2)
					AL_SetCellEnter (xALP_DatosImportados;1;$i;Size of array:C274(at_arreglos2Import))
				End if 
			End for 
			
			ALP_SetDefaultAppareance (xALP_DatosImportados;9;1;6;1;8)
			AL_SetColOpts (xALP_DatosImportados;1;1;1;0;0)
			AL_SetRowOpts (xALP_DatosImportados;0;0;0;0;1;0)
			AL_SetCellOpts (xALP_DatosImportados;0;1;1)
			AL_SetMainCalls (xALP_DatosImportados;"";"")
			AL_SetCallbacks (xALP_DatosImportados;"";"")
			AL_SetEntryOpts (xALP_DatosImportados;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
			AL_SetDrgOpts (xALP_DatosImportados;0;30;0)
			
			AL_SetLine (xALP_DatosImportados;0)
			
			AL_UpdateArrays (xALP_DatosImportados;-2)
			
			viNoRegistros2Import:=String:C10(noRegistros2Import)
			viMonto2Import:=String:C10(monto2Import;"|Despliegue_ACT_Pagos")
			viMontoTotal:=String:C10(montoTotal2Import;"|Despliegue_ACT_Pagos")
			viNoRegistrosTotal:=String:C10(noRegistrosTotal2Import)
		Else 
			CANCEL:C270
		End if 
End case 
