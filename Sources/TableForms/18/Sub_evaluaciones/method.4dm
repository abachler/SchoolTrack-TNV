
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		AS_ALP_ConfigAreaSubEvals 
		ASsev_LeePropiedadesControles 
		
		
		For ($i;1;12)
			$sourcePointer:=Get pointer:C304("aSubEval"+String:C10($i))
			$copyPointer:=Get pointer:C304("aCpySubEval"+String:C10($i))
			COPY ARRAY:C226($sourcePointer->;$copyPointer->)
		End for 
		COPY ARRAY:C226(aSubEvalP1;aCpySubEvalP1)
		COPY ARRAY:C226(aSubEvalControles;aCpySubEvalControles)
		
		$hayControles:=False:C215
		For ($i;1;Size of array:C274(aCpySubEvalControles))
			If (aCpySubEvalControles{$i}#"")
				$hayControles:=True:C214
			End if 
		End for 
		
		If (($hayControles) & (Not:C34(USR_IsGroupMember_by_GrpID (-15001))))
			OBJECT SET ENTERABLE:C238(*;"ValorControl";False:C215)
			OBJECT SET ENTERABLE:C238(*;"vs_FijoControles";False:C215)
			_O_DISABLE BUTTON:C193(bPopupControles)
			OBJECT SET COLOR:C271(vtAS_ModoControles;-14)
		End if 
		
		
		If (<>vb_BloquearModifSituacionFinal)
			OBJECT SET VISIBLE:C603(*;"bloqueoRegistro";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"bloqueoRegistro";False:C215)
		End if 
		
		If (iResults=2)
			bcPromediarSubs:=Num:C11([xxSTR_Subasignaturas:83]CalcularPromedios:18)
			OBJECT SET VISIBLE:C603(bcPromediarSubs;True:C214)
		End if 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		ARRAY LONGINT:C221(al_IdAlumnoNotasModificadas;0)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 