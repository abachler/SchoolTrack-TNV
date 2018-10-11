  // [xxSTR_Constants].STR_CL_Asistente_RECH()

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		b1:=0
		b2:=0
		b3:=0
		b4:=1
		b5:=1
		b6:=0
		b7:=0
		b8:=0
		b21:=1
		b22:=1
		b23:=1
		b24:=1
		b25:=1
		b26:=0
		$date:=DT_GetDateFromDayMonthYear (30;6;<>gYear)
		  //If (Current date(*)>$date)
		r1_Actas:=1
		r2_Matricula:=0
		bDiagnostico:=1
		bEvaluar:=1
		_O_ENABLE BUTTON:C192(bDiagnostico)
		_O_ENABLE BUTTON:C192(bEvaluar)
		OBJECT SET VISIBLE:C603(*;"matricula@";False:C215)
		  //Else 
		  //r1_Actas:=0
		  //r2_Matricula:=1
		  //bDiagnostico:=0
		  //bEvaluar:=0
		  //DISABLE BUTTON(bDiagnostico)
		  //DISABLE BUTTON(bEvaluar)
		  //SET VISIBLE(*;"actas@";False)
		  //GOTO AREA(r2_Matricula)
		  //End if 
		vi_pageNumber:=1
		vt_text1:=""
		vd_date:=Current date:C33(*)
		vl_VerifMineduc:=0
		vt_FolderName:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ST)+"RECH"+Folder separator:K24:12+"Actas"+Folder separator:K24:12
		$result:=Test path name:C476(vt_FolderName)
		
		$err:=ALP_DefaultColSettings (xALP_UNidades;1;"at_DatosUnidadesEduc_Names";__ ("Campo");250)
		$err:=ALP_DefaultColSettings (xALP_UNidades;2;"at_DatosUnidadesEduc_Ejemplo";__ ("Formato");100)
		$err:=ALP_DefaultColSettings (xALP_UNidades;3;"at_DatosUnidadesEduc_Values";__ ("Valores");60)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_UNidades;9;1;4;1;1)
		AL_SetColOpts (xALP_UNidades;1;1;1;0;0)
		AL_SetRowOpts (xALP_UNidades;0;1;0;0;1;1)
		AL_SetCellOpts (xALP_UNidades;0;1;1)
		AL_SetMiscOpts (xALP_UNidades;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_UNidades;"";"")
		AL_SetScroll (xALP_UNidades;0;-3)
		AL_SetEntryOpts (xALP_UNidades;2;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_UNidades;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_UNidades;1;"";"";"")
		AL_SetDrgSrc (xALP_UNidades;2;"";"";"")
		AL_SetDrgSrc (xALP_UNidades;3;"";"";"")
		AL_SetDrgDst (xALP_UNidades;1;"";"";"")
		AL_SetDrgDst (xALP_UNidades;1;"";"";"")
		AL_SetDrgDst (xALP_UNidades;1;"";"";"")
		
		If (r2_Matricula=1)
			OBJECT SET VISIBLE:C603(*;"actas@";False:C215)
			OBJECT SET VISIBLE:C603(*;"matricula@";True:C214)
			OBJECT SET VISIBLE:C603(*;"printdiagnóstico@";False:C215)
			OBJECT SET VISIBLE:C603(*;"diagnóstico@";False:C215)
			_O_DISABLE BUTTON:C193(bDiagnostico)
			_O_DISABLE BUTTON:C193(bEValuar)
			bDiagnostico:=0
			bEValuar:=0
		Else 
			OBJECT SET VISIBLE:C603(*;"actas@";False:C215)
			OBJECT SET VISIBLE:C603(*;"matricula@";True:C214)
			OBJECT SET VISIBLE:C603(*;"printdiagnóstico@";False:C215)
			OBJECT SET VISIBLE:C603(*;"diagnóstico@";False:C215)
		End if 
		
		
		
		
		If ($result<0)
			SYS_CreateFolder (vt_FolderName)
		End if 
		_O_DISABLE BUTTON:C193(bGenerar)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (vt_foldername#"")
			If (Test path name:C476(vt_foldername)>=0)
			Else 
				vt_foldername:=""
			End if 
		End if 
		If ((vt_foldername#"") & (vd_date#!00-00-00!))
			_O_ENABLE BUTTON:C192(bGenerar)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
