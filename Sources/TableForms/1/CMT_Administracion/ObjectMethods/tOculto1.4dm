If (<>vl_CMT_OnOff=1)
	
	If (LICENCIA_esModuloAutorizado (1;CommTrack))
		If (Application type:C494=4D Remote mode:K5:5)
			
			C_LONGINT:C283($process_state)
			$process_state:=PCS_CheckProcessOnServer ("CT_TRANSFER_DATA")
			
			If ($process_state=-100)
				$process_id:=Execute on server:C373("CT_SendData";128000;"CT_TRANSFER_DATA";True:C214;*)
				CD_Dlog (0;__ ("Los datos se procesarán y serán enviados desde el servidor hacia CommTrack ..."))
			Else 
				CD_Dlog (0;__ ("La Generación ya está siendo procesada en el servidor, revise en unos minutos el registro de actividades de CommTrack."))
			End if 
			
		Else 
			CT_SendData (True:C214)
		End if 
	Else 
		CD_Dlog (0;__ ("Módulo no licenciado para el establecimiento."))
	End if 
Else 
	CD_Dlog (0;__ ("La opción de envío de datos a CommTtrack no está activa, por favor verifique en la lengueta Configuración General."))
	FORM GOTO PAGE:C247(1)
End if 
