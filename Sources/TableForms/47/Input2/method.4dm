Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(b_mostrar)
		$caps:=Caps lock down:C547
		OBJECT SET VISIBLE:C603(*;"CapsLockIcon";$caps)
		If (Is new record:C668([xShell_Users:47]))
			[xShell_Users:47]CambiarPassw_PrimeraSesion:25:=True:C214
		Else 
			OBJECT SET ENABLED:C1123([xShell_Users:47]CambiarPassw_PrimeraSesion:25;[xShell_Users:47]Nb_sesions:8=0)
		End if 
		
		If ([xShell_Users:47]login:9="")
			OBJECT SET ENTERABLE:C238(vsPW_Password1;False:C215)
			OBJECT SET ENTERABLE:C238(vsPW_Password2;False:C215)
		End if 
		vsPW_Password1:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
		vsPW_Password2:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
		OBJECT SET FONT:C164(vsPW_Password1;"%Password")
		OBJECT SET FONT:C164(vsPW_Password2;"%Password")
		wref:=WDW_GetWindowID 
		If ([xShell_Users:47]No:1=0)
			[xShell_Users:47]No:1:=SQ_SeqNumber (->[xShell_Users:47]No:1)
		End if 
		viUSR_RenewAfter:=[xShell_Users:47]Password_DaysToRenew:16
		
		ARRAY LONGINT:C221(aPeopleNo;0)
		ARRAY TEXT:C222(aPeopleName;0)
		RESOLVE POINTER:C394(<>yUSR_RelatedName;$varName;$table;$Field)
		READ ONLY:C145(Table:C252($table)->)
		ALL RECORDS:C47(Table:C252($table)->)
		SELECTION TO ARRAY:C260(<>yUSR_RelatedName->;aPeopleName;<>yUSR_RelatedID->;aPeopleNo)
		SORT ARRAY:C229(aPeopleName;aPeopleNo;>)
		vp_UserPicture:=vp_UserPicture*0
		If ([xShell_Users:47]NoEmployee:7#0)
			RESOLVE POINTER:C394(<>yUSR_RelatedID;$varName;$table;$Field)
			If ($table>0)
				READ WRITE:C146(Table:C252($table)->)
				QUERY:C277(Table:C252($table)->;Field:C253($table;$Field)->;=;[xShell_Users:47]NoEmployee:7)
				vp_UserPicture:=<>yUSR_RelatedPicture->
			End if 
		End if 
		
		
		If (Not:C34(USR_IsGroupMember_by_GrpID (-15001;[xShell_Users:47]No:1)))
			OBJECT SET ENABLED:C1123(*;"recibeMail";False:C215)
			OBJECT SET COLOR:C271(*;"recibeMail";-14)
		End if 
		
		KRL_ReloadInReadWriteMode (->[xShell_Users:47])
		
		
		
		SET TIMER:C645(20)
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
		
		
	: (Form event:C388=On Data Change:K2:15)
		If (([xShell_Users:47]Name:2#"") & ([xShell_Users:47]login:9#""))
			OBJECT SET ENTERABLE:C238(vsPW_Password1;True:C214)
			OBJECT SET ENTERABLE:C238(vsPW_Password2;True:C214)
		End if 
		If (([xShell_Users:47]Name:2#"") & (ST_ExactlyEqual (vsPW_Password1;vsPW_Password2)=1) & ([xShell_Users:47]login:9#""))
			_O_ENABLE BUTTON:C192(bOK)
		Else 
			_O_DISABLE BUTTON:C193(bOK)
		End if 
	: (Form event:C388=On Validate:K2:3)
		If ([xShell_Users:47]No:1=0)
			[xShell_Users:47]No:1:=SQ_SeqNumber (->[xShell_Users:47]No:1)
		End if 
		
		
	: (Form event:C388=On Timer:K2:25)
		$caps:=Caps lock down:C547
		OBJECT SET VISIBLE:C603(*;"CapsLockIcon";$caps)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		RESOLVE POINTER:C394(<>yUSR_RelatedID;$varName;$table;$Field)
		If ($table>0)
			KRL_UnloadReadOnly (Table:C252($table))
		End if 
End case 