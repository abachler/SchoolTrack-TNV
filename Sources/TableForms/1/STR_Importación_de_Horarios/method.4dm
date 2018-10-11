Case of 
	: (Form event:C388=On Load:K2:1)
		_O_C_INTEGER:C282(viTMT_EliminaSesiones)
		vtXS_PrefTitle:="Asistente para Importar Horarios."
		viTMT_CreaSesionesDesdeInicio:=1
		viTMT_EliminaSesiones:=0
		
		XS_SetInterface 
		
		READ ONLY:C145([xxSTR_Periodos:100])
		QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1>=-1)
		L_Config1:=HL_Selection2List (->[xxSTR_Periodos:100]Nombre_Configuracion:2;->[xxSTR_Periodos:100]ID:1)
		
		vt_g2:=OBJECT Get title:C1068(*;"texto")
		vt_g1:=""
		vt_g1Temp:=""
		
		op1:=1
		op2:=0
		
		If (SYS_IsMacintosh )
			r1:=1
			r2:=0
		Else 
			r1:=0
			r2:=1
		End if 
		
		cb_TieneEncabezado:=0
		vi_PageNumber:=1
		vi_Step:=1
		vt_Motivo:=""
		
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		_O_DISABLE BUTTON:C193(bImport)
		
		If (Application type:C494=4D Remote mode:K5:5)
			bc_ExecuteOnServer:=0
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;True:C214)
		Else 
			bc_ExecuteOnServer:=0
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;False:C215)
		End if 
		
		vdACT_FechaUFSel:=Current date:C33(*)
		
		  //NIVELES
		
		ARRAY TEXT:C222(at_NivelDesdeInf;0)
		ARRAY TEXT:C222(at_NivelHastaInf;0)
		ARRAY LONGINT:C221(al_NivelDesdeInf;0)
		ARRAY LONGINT:C221(al_NivelHastaInf;0)
		READ ONLY:C145([xxSTR_Niveles:6])
		ALL RECORDS:C47([xxSTR_Niveles:6])
		QUERY SELECTION:C341([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;at_NivelDesdeInf;[xxSTR_Niveles:6]Nivel:1;at_NivelHastaInf;[xxSTR_Niveles:6]NoNivel:5;al_NivelDesdeInf;[xxSTR_Niveles:6]NoNivel:5;al_NivelHastaInf)
		SORT ARRAY:C229(al_NivelDesdeInf;al_NivelHastaInf;at_NivelDesdeInf;at_NivelHastaInf;>)
		
		at_NivelDesdeInf:=1
		at_NivelHastaInf:=Size of array:C274(at_NivelHastaInf)
		al_NivelDesdeInf:=1
		al_NivelHastaInf:=Size of array:C274(al_NivelHastaInf)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 

Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vi_Step:=1
	: (vi_PageNumber=2)
		_O_ENABLE BUTTON:C192(bPrev)
		vi_Step:=2
End case 

