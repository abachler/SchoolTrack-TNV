//%attributes = {}
  //ADTcon_DeleteSelection

$0:=0
If (USR_checkRights ("D";->[ADT_Contactos:95]))
	START TRANSACTION:C239
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([ADT_Contactos:95];$aRecNums;"")
	$validate:=True:C214
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([ADT_Contactos:95])
		GOTO RECORD:C242([ADT_Contactos:95];$aRecNums{$i})
		READ WRITE:C146([ADT_Prospectos:163])
		QUERY:C277([ADT_Prospectos:163];[ADT_Prospectos:163]ID_Contacto:2=[ADT_Contactos:95]ID:1)
		DELETE SELECTION:C66([ADT_Prospectos:163])
		If (Records in set:C195("LockedSet")>0)
			CD_Dlog (0;__ ("En estos momentos hay registros asociados en uso. Por favor intente la eliminación más tarde."))
			$i:=Size of array:C274($aRecNums)+1
			CANCEL TRANSACTION:C241
			$validate:=False:C215
		Else 
			If (Not:C34(Locked:C147([ADT_Contactos:95])))
				DELETE RECORD:C58([ADT_Contactos:95])
			Else 
				CD_Dlog (0;__ ("En estos momentos hay registros asociados en uso. Por favor intente la eliminación más tarde."))
				$i:=Size of array:C274($aRecNums)+1
				CANCEL TRANSACTION:C241
				$validate:=False:C215
			End if 
		End if 
	End for 
	If ($validate)
		VALIDATE TRANSACTION:C240
		$0:=1
	End if 
	KRL_UnloadReadOnly (->[ADT_Contactos:95])
	KRL_UnloadReadOnly (->[ADT_Prospectos:163])
Else 
	USR_ALERT_UserHasNoRights (3)
End if 