//%attributes = {}
  //CAE_InicioCierreAgnoEscolar

KRL_UnloadAll 
C_LONGINT:C283(bHistorico;vi_AgnosHistorico;bEnfermeria;vi_AgnosEnfermeria;bOrientacion;vi_AgnosOrientacion;bEventos;vi_AgnosEventos;bColación;bFotografia;r1InitPropEvaluacion;r2InitPropEvaluacion;bBackup;bInitPonderaciones)
C_LONGINT:C283(bEliminarSubasignaturas;bInicializarConsolidaciones;bInitNumMatricula;i1InitNumMatricula;i2InitNumMatricula;c1_EnCursos;c2_enCursosTemporales;cb_InscribeEnAsignaturas;bArchive;bDeleteRejected;cbDeleteArchive;vlADT_YearDeleteArchives)
C_TEXT:C284(vt_backupFolder;vt_backupFile)
C_BLOB:C604(xBlob)


If (USR_GetMethodAcces (Current method name:C684))
	FLUSH CACHE:C297
	$onServer:=<>onServer
	<>onServer:=False:C215
	<>NoBatchProcessor:=True:C214
	<>NoLog:=True:C214
	<>writeOK:=True:C214
	READ ONLY:C145([xxSTR_Niveles:6])
	
	ARRAY TEXT:C222($aUsers;0)
	ARRAY LONGINT:C221($aMethods;0)
	If (Application type:C494=4D Remote mode:K5:5)
		CD_Dlog (0;__ ("Por razones de seguridad el cierre del año escolar debe ser ejecutado en entorno mono-usuario."))
	Else 
		DISABLE MENU ITEM:C150(1;5)
		
		  //$msg:="Antes de iniciar el cierre del año escolar SchoolTrack efectuará una verificación"+" del estado de todos los registros e índices de la base de datos.\r\r"+"Si se detecta algún tipo de corrupción en los datos el año escolar no podrá ser "+"cdo mientras la base de datos no sea reparada."+"\r\rSi desea saltar la verificación y continuar con el cierre presione el botón \"Sa"+"ltar verificación\""
		  //$msg:=$msg+"Si se detecta algún tipo de corrupción en los datos el año escolar no podrá ser "+"cerrado mientras la base de datos no sea reparada."
		  //$msg:=$msg+"\r\rSi desea saltar la verificación y continuar con el cierre presione el botón \"Sa"+"ltar verificación\""
		
		OK:=CD_Dlog (0;__ ("Antes de iniciar el cierre del año escolar SchoolTrack efectuará una verificación del estado de todos los registros e índices de la base de datos.\r\rSi se detecta algún tipo de corrupción en los datos el año escolar no podrá ser cerrado mientras la"+" bas"+"e "+"de datos no sea reparada.\r\rSi desea saltar la verificación y continuar con el cierre presione el botón Saltar verificación");__ ("");__ ("Aceptar");__ ("Saltar Verificación");__ ("Cancelar"))
		Case of 
			: (OK=1)
				OK:=KRL_CheckAndFix_Database 
				If (OK=0)
					OK:=CD_Dlog (0;__ ("Se detectaron problemas en la base de datos.\r\rEl cierre de año escolar no puede realizarse mientras esos problemas no se resuelvan.");__ ("");__ ("Aceptar");__ ("Saltar Verificación");__ ("Cancelar"))
				End if 
				
			: (OK=2)
				LOG_RegisterEvt ("Verificación de la la base de datos previa al cierre no realizada por decisión de"+"l usuario.")
				OK:=1
			Else 
				OK:=0
		End case 
		
		
		If (OK=1)
			Case of 
				: (<>vtXS_CountryCode="cl")
					WDW_OpenFormWindow (->[xxSTR_DatosDeCierre:24];"Asistente_CierreAgno_cl";0;4;__ ("Cierre del año escolar"))
					DIALOG:C40([xxSTR_DatosDeCierre:24];"Asistente_CierreAgno_cl")
				Else 
					WDW_OpenFormWindow (->[xxSTR_DatosDeCierre:24];"Asistente_CierreAgno_co";0;4;__ ("Cierre del año escolar"))
					DIALOG:C40([xxSTR_DatosDeCierre:24];"Asistente_CierreAgno_co")
			End case 
			CLOSE WINDOW:C154
			UNLOAD RECORD:C212([xxSTR_Constants:1])
			If (ok=1)
				  //20110302 RCH Este codigo estaba en la linea 18, fue movido para aca...
				READ WRITE:C146([xShell_BatchRequests:48])
				ALL RECORDS:C47([xShell_BatchRequests:48])
				DELETE SELECTION:C66([xShell_BatchRequests:48])
				READ ONLY:C145([xShell_BatchRequests:48])
				OK:=1
				  //20110302 RCH
				
				READ WRITE:C146([xxSTR_DatosDeCierre:24])
				QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1=<>gYear)
				If (Records in selection:C76([xxSTR_DatosDeCierre:24])=0)
					CREATE RECORD:C68([xxSTR_DatosDeCierre:24])
					[xxSTR_DatosDeCierre:24]Year:1:=<>gYear
					[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5:=<>gNombreAgnoEscolar
				End if 
				$vDummy:=0
				BLOB_Variables2Blob (->[xxSTR_DatosDeCierre:24]xPreferences:4;0;->bHistorico;->vi_AgnosHistorico;->bEnfermeria;->vi_AgnosEnfermeria;->bOrientacion;->vi_AgnosOrientacion;->bEventos;->vi_AgnosEventos;->bColación;->bFotografia;->r1InitPropEvaluacion;->r2InitPropEvaluacion;->bBackup;->bInitPonderaciones;->bEliminarSubasignaturas;->bInicializarConsolidaciones;->bInitNumMatricula;->i1InitNumMatricula;->i2InitNumMatricula;->vt_backupFolder;->vt_backupFile;->c1_EnCursos;->c2_enCursosTemporales;->cb_InscribeEnAsignaturas;->bArchive;->bDeleteRejected;->cbDeleteArchive;->vlADT_YearDeleteArchives)
				SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
				ok:=CD_Dlog (2;__ ("¿Desea Ud. realmente cerrar el año escolar ahora?");__ ("");__ ("Si");__ ("No"))
				If (ok=1)
					CAE_EjecutaCierreAgnoEscolar ([xxSTR_DatosDeCierre:24]xPreferences:4)
				End if 
			End if 
		End if 
	End if 
End if 
