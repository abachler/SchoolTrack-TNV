
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 187484
  // Fecha y hora: 02-10-18, 09:39:28
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_AsignaIDGlosaParaTramos.bProxima
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		C_OBJECT:C1216($ob_mensaje)
		C_TEXT:C284($t_msg;$t_msjUser)
		C_POINTER:C301($y_control;$y_resumen)
		
		
		$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ab_asignable")
		If (Count in array:C907($y_control->;True:C214)>0)
			
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"lbl_nroPagina")
			If ($y_control->=1)
				
				$ob_mensaje:=ACTwiz_AsignaIDGlosaTramosMas ("PresentarResumen")
				$t_msjUser:=OB Get:C1224($ob_mensaje;"msg")
				If ($t_msjUser#"")
					$y_resumen:=OBJECT Get pointer:C1124(Object named:K67:5;"txtResumen")
					$y_resumen->:=$t_msjUser
				End if 
				
				$y_control->:=($y_control->+1)
				FORM GOTO PAGE:C247($y_control->)
				  //POST KEY(Character code("+");256)
			End if 
			
		Else 
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"bProxima")
			OBJECT SET ENABLED:C1123($y_control->;False:C215)
			$t_msg:=__ ("No existen items de cargo seleccionados en la grilla.\r\rNo es posible continuar.")
			CD_Dlog (0;$t_msg)
		End if 
End case 




