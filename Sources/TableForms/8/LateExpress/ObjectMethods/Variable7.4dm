Case of 
	: (Form event:C388=On Load:K2:1)
		$Error:=AL_SetArraysNam (Self:C308->;1;1;"<>aExAbs1")  //EMA
		$Error:=AL_SetArraysNam (Self:C308->;2;1;"<>aExAbs3")
		$Error:=AL_SetArraysNam (Self:C308->;3;1;"<>aExAbs2")
		AL_SetWidths (Self:C308->;1;1;200)
		AL_SetWidths (Self:C308->;2;1;23)
		AL_SetEnterable (Self:C308->;1;0)
		AL_SetEnterable (Self:C308->;2;1)
		  //20111110 AS. se da formato.
		AL_SetFormat (Self:C308->;2;"##0";0;0;0;0)
		AL_SetEntryOpts (Self:C308->;3;1;0;0;1;".")
		ALP_SetDefaultAppareance (Self:C308->;9)
		AL_SetRowOpts (Self:C308->;1;1;1;0;0)
		$indicadorMinutos:=Num:C11(PREF_fGet (0;"RegistrarMinutosEnAtrasos";"0"))
		If ($indicadorMinutos>0)
			AL_SetColOpts (Self:C308->;0;0;0;1;0;0;0)
		Else 
			AL_SetColOpts (Self:C308->;0;0;0;2;0;0;0)
		End if 
		
		AL_SetMiscOpts (Self:C308->;1;0;"\\";0;1)
		dDate:=Current date:C33(*)
		sCurso:=<>tSTR_CursoProfesor_USR
		sName:=""
		i_line:=0
		AL_SetLine (Self:C308->;0)
	: (alproEvt=1)
		i_line:=AL_GetLine (Self:C308->)
		If (i_line>0)
			sName:=<>aExAbs1{i_line}
			Lid:=<>aExAbs2{i_line}
		End if 
	: (Form event:C388=On Close Box:K2:21)
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 