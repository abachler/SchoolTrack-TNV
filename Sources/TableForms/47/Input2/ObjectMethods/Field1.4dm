IT_Clairvoyance (Self:C308;->aPeopleName;"")
If (Form event:C388=On Data Change:K2:15)
	RESOLVE POINTER:C394(<>yUSR_RelatedName;$varName;$table;$Field)
	If (Self:C308->#"")
		$el:=Find in array:C230(aPeopleName;Self:C308->)
		If ($el>0)
			[xShell_Users:47]NoEmployee:7:=aPeopleNo{$el}
			[xShell_Users:47]Name:2:=aPeopleName{$el}
			If (Not:C34(KRL_RecordExists (->[xShell_Users:47]Name:2)))
				READ WRITE:C146(Table:C252($table)->)
				QUERY:C277(Table:C252($table)->;<>yUSR_RelatedID->=aPeopleNo{$el})
				[xShell_Users:47]Name:2:=<>yUSR_RelatedName->
				[xShell_Users:47]login:9:=<>yUSR_RelatedLoginName->
				[xShell_Users:47]NoEmployee:7:=<>yUSR_RelatedID->
				vp_UserPicture:=<>yUSR_RelatedPicture->
				OBJECT SET ENTERABLE:C238(vsPW_Password1;True:C214)
				OBJECT SET ENTERABLE:C238(vsPW_Password2;True:C214)
			Else 
				[xShell_Users:47]Name:2:=""
				[xShell_Users:47]login:9:=""
				[xShell_Users:47]NoEmployee:7:=0
				vp_UserPicture:=vp_UserPicture*0
				$ignore:=CD_Dlog (0;__ ("Ya existe un usuario con este nombre en la base de datos."))
				OBJECT SET ENTERABLE:C238(vsPW_Password1;False:C215)
				OBJECT SET ENTERABLE:C238(vsPW_Password2;False:C215)
			End if 
		Else 
			$tableName:=API Get Virtual Table Name ($table)
			$ignore:=CD_Dlog (0;__ ("No existe el registro en la tabla ")+$tableName+__ (".\r\rEl registro debe existir para poder crear el usuario."))
			vp_UserPicture:=vp_UserPicture*0
			GOTO OBJECT:C206([xShell_Users:47]Name:2)
			OBJECT SET ENTERABLE:C238(vsPW_Password1;False:C215)
			OBJECT SET ENTERABLE:C238(vsPW_Password2;False:C215)
		End if 
	End if 
End if 
