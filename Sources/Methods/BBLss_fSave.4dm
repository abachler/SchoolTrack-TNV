//%attributes = {}
  //BBLss_fSave

C_LONGINT:C283($0)
$0:=0
If (USR_checkRights ("M";->[BBL_Subscripciones:117]))
	If (KRL_RegistroFueModificado (->[BBL_Subscripciones:117]))
		If (([BBL_Subscripciones:117]Titulo:2#"") & ([BBL_Subscripciones:117]Clasificación:22#""))
			If (Record number:C243([BBL_Subscripciones:117])=-3)
				LOG_RegisterEvt ("MediaTrack -Creación de registro de suscripciones: "+[BBL_Subscripciones:117]Titulo:2;Table:C252(->[BBL_Subscripciones:117]);[BBL_Subscripciones:117]ID:1)
			Else 
				LOG_RegisterEvt ("Modificación de registro de suscripciones: "+[BBL_Subscripciones:117]Titulo:2;Table:C252(->[BBL_Subscripciones:117]);[BBL_Subscripciones:117]ID:1)
			End if 
			SAVE RECORD:C53([BBL_Subscripciones:117])
			$0:=1
		Else 
			BEEP:C151
			CD_Dlog (0;__ ("Para guardar un registro de suscripción es necesario ingresar al menos el título y la clasificación.\r\rPor favor complete las informaciones faltantes antes de continuar.");__ (""))
			$0:=-1
		End if 
	Else 
		$0:=0
	End if 
End if 