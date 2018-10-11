$valido:=True:C214

For ($i;1;Count list items:C380(hl_Designers))
	GET LIST ITEM:C378(hl_Designers;$i;$ref;$text)
	If ($i#Selected list items:C379(hl_Designers))
		$vtXS_Did:=ST_GetWord ($text;1;":")
		$vtXS_Dnombre:=ST_GetWord ($text;2;":")
		$vtXS_Dlogin:=ST_GetWord ($text;3;":")
		$vtXS_Dpass:=ST_GetWord ($text;4;":")
		$vtXS_Demail:=ST_GetWord ($text;5;":")
		Case of 
			: (vtXS_Did=$vtXS_Did)
				CD_Dlog (0;__ ("Ya existe un super usuario con ese ID."))
				$i:=Count list items:C380(hl_Designers)+1
				$valido:=False:C215
			: (vtXS_Dlogin=$vtXS_Dlogin)
				CD_Dlog (0;__ ("Ya existe un super usuario con ese login."))
				$i:=Count list items:C380(hl_Designers)+1
				$valido:=False:C215
		End case 
	End if 
End for 
If ($valido)
	$valido:=((vtXS_Dlogin#"") & (vtXS_Dpass#"") & (vtXS_Dnombre#"") & (vtXS_Demail#"") & (vtXS_Did#""))
	If (Not:C34($valido))
		CD_Dlog (0;__ ("Debe completar todos los valores requeridos."))
	Else 
		If (SMTP_VerifyEmailAddress (vtXS_Demail)="")
			$valido:=False:C215
		End if 
	End if 
End if 
If ($valido)
	ACCEPT:C269
End if 