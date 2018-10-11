C_BOOLEAN:C305($b_muestraMsj)
C_LONGINT:C283($l_registros)

$b_muestraMsj:=False:C215
$l_registros:=Num:C11(ACTdte_OpcionesGeneralesIE ("ValidaPeriodoLibroElectronico";->$b_muestraMsj))
If ($l_registros=0)
	Self:C308->:=""
	CD_Dlog (0;"Solo es posible usar este campo si ya existe un libro enviado al SII.")
Else 
	If (Self:C308->#"")
		
		Case of 
			: (Length:C16(Self:C308->)#10)
				CD_Dlog (0;"El código debe ser de 10 caracteres.")
				
			Else 
				
				$l_recs:=Num:C11(ACTdte_OpcionesGeneralesIE ("ValidaPeriodoLibroElectronicoCodReemplazo"))
				If ($l_recs>0)
					CD_Dlog (0;__ ("¡ATENCIÓN! Ya existe un libro enviado, con el mismo código de reemplazo, para el período seleccionado."))
				End if 
				
		End case 
	End if 
End if 
