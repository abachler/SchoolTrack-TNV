If (Form event:C388=On Clicked:K2:4)
	If ((Size of array:C274(abrSelect)>1) & (vLocation="browser"))
		$t_mensaje:=__ ("Usted se apresta a registrar una licencia médica para ^0 alumnos.")+\
			"\r\r"+__ ("¿Desea usted registrar la misma licencia médica para todos ellos?")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10(Size of array:C274(abrSelect)))
		$l_opcion:=ModernUI_Notificacion (__ ("Registro de licencia médica");$t_mensaje;__ ("Cancelar");__ ("Aceptar"))
		If ($l_opcion=2)
			sMotivo:=<>aLicencias{<>aLicencias}
			
			  //156855
			If (<>aLicencias=2)  //Autorización especial
				If (Not:C34(bMotivoEspecial))
					OBJECT MOVE:C664(*;"licmotivo_@";0;-243)
					OBJECT MOVE:C664(*;"Text1";0;25)
					OBJECT MOVE:C664(*;"Variable8";0;25;0;-25)
					bMotivoEspecial:=True:C214
				End if 
			Else 
				If (bMotivoEspecial)
					OBJECT MOVE:C664(*;"licmotivo_@";0;243)
					OBJECT MOVE:C664(*;"Text1";0;-25)
					OBJECT MOVE:C664(*;"Variable8";0;-25;0;25)
					bMotivoEspecial:=False:C215
				End if 
			End if 
			
			sMotivo:=<>aLicencias{<>aLicencias}
			
		Else 
			sMotivo:=""
			<>aLicencias:=0
		End if 
	Else 
		  //156855
		If (<>aLicencias=2)  //Autorización especial
			If (Not:C34(bMotivoEspecial))
				OBJECT MOVE:C664(*;"licmotivo_@";0;-243)
				OBJECT MOVE:C664(*;"Text1";0;25)
				OBJECT MOVE:C664(*;"Variable8";0;25;0;-25)
				bMotivoEspecial:=True:C214
			End if 
		Else 
			If (bMotivoEspecial)
				OBJECT MOVE:C664(*;"licmotivo_@";0;243)
				OBJECT MOVE:C664(*;"Text1";0;-25)
				OBJECT MOVE:C664(*;"Variable8";0;-25;0;25)
				bMotivoEspecial:=False:C215
			End if 
			
		End if 
		sMotivo:=<>aLicencias{<>aLicencias}
	End if 
	
End if 
