//%attributes = {}
  //ADTcon_Delete

$0:=0
If (USR_checkRights ("D";->[ADT_Contactos:95]))
	START TRANSACTION:C239
	READ WRITE:C146([ADT_Prospectos:163])
	QUERY:C277([ADT_Prospectos:163];[ADT_Prospectos:163]ID_Contacto:2=[ADT_Contactos:95]ID:1)
	DELETE SELECTION:C66([ADT_Prospectos:163])
	If (Records in set:C195("LockedSet")>0)
		CD_Dlog (0;__ ("En estos momentos hay registros asociados en uso. Por favor intente la eliminación más tarde."))
		CANCEL TRANSACTION:C241
	Else 
		If (Not:C34(Locked:C147([ADT_Contactos:95])))
			DELETE RECORD:C58([ADT_Contactos:95])
			VALIDATE TRANSACTION:C240
			$0:=1
		Else 
			CD_Dlog (0;__ ("El registro está siendo utilizado por otro usuario o proceso. Por favor intente la eliminación más tarde."))
			CANCEL TRANSACTION:C241
		End if 
	End if 
	KRL_UnloadReadOnly (->[ADT_Prospectos:163])
Else 
	USR_ALERT_UserHasNoRights (3)
End if 