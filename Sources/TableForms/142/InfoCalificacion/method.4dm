  // [xxSTR_InfoCalificaciones].InfoCalificacion()
  // Por: Alberto Bachler K.: 19-02-14, 11:22:33
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET TITLE:C194(*;"alumno";KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]apellidos_y_nombres:40))
		Case of 
			: ((vi_Parcial>0) & (vi_Parcial<=Size of array:C274(atAS_EvalPropPrintName)))
				OBJECT SET TITLE:C194(*;"Calificacion";Choose:C955(atAS_EvalPropPrintName{vi_Parcial}#"";atAS_EvalPropPrintName{vi_Parcial};__ ("Evaluación parcial Nº")+String:C10(vi_Parcial)))
			: (vi_Parcial=0)
				OBJECT SET TITLE:C194(*;"Calificacion";__ ("CP"))
			Else 
				OBJECT SET TITLE:C194(*;"Calificacion";"")
		End case 
		
		$isOpen:=((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
		If (<>vb_BloquearModifSituacionFinal)
			$isOpen:=False:C215
		End if 
		If ((((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208]))) & ($isOpen))
			OBJECT SET ENTERABLE:C238(*;"info@";True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(*;"info@";False:C215)
		End if 
		
		  //MONO TICKET 186392
		OBJECT SET TITLE:C194(*;"infoAsociadaCampo";t_infoAsociada)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 


