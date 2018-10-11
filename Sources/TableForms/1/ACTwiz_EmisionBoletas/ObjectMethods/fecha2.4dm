C_DATE:C307(vdACT_FEmisionBol;$d_fechaActual)
C_BOOLEAN:C305($b_rsElectronica;$b_rsNormal)
ARRAY LONGINT:C221($alACT_id;0)
C_LONGINT:C283($l_indice)

$d_fechaActual:=vdACT_FEmisionBol
$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	C_BOOLEAN:C305($b_valida)
	$b_valida:=(ACTfear_OpcionesGenerales ("ValidaFechaEmision";->$Fechafecha)="1")
	If ($b_valida)
		  //20150805 RCH Se validan las fechas...
		If (<>gCountryCode="cl")
			READ ONLY:C145([ACT_RazonesSociales:279])
			ALL RECORDS:C47([ACT_RazonesSociales:279])
			SELECTION TO ARRAY:C260([ACT_RazonesSociales:279]id:1;$alACT_id)
			For ($l_indice;1;Size of array:C274($alACT_id))
				If (ACTdte_EsEmisorColegium ($alACT_id{$l_indice}))
					$b_rsElectronica:=True:C214
				Else 
					$b_rsNormal:=True:C214
				End if 
			End for 
			If ($b_rsElectronica)
				If ($FechaFecha<Current date:C33(*))
					CD_Dlog (0;"El Libro de Consumo de Folios envía diariamente al SII los rangos de folios usados para las boletas electrónicas."+"\r\r"+"Si cambia la fecha de emisión de una boleta, el libro de folios podría presentar inconsistencias."+"\r\r"+"Si va a emitir una boleta electrónica, por favor emita el documento con la fecha actual.")
					If (Not:C34($b_rsNormal))  //Si no tiene configurada una razon normal, no se puede cambiar la fecha
						$FechaFecha:=$d_fechaActual
					End if 
				End if 
			End if 
		End if 
		vdACT_FEmisionBol:=$FechaFecha
	Else 
		vdACT_FEmisionBol:=!00-00-00!
	End if 
Else 
	vdACT_FEmisionBol:=!00-00-00!
End if 

ACTbol_CargaDiasVencimiento ("ValidaCambioFecha";->vdACT_FEmisionBol)

vtACT_FEmisionBol:=String:C10(vdACT_FEmisionBol;7)