Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vi_PageNumber:=1
		vb_SituacionFinalOK:=False:C215
		vb_PromediosOK:=False:C215
		vt_DataFile:=""
		OBJECT SET VISIBLE:C603(*;"problemas2@";False:C215)
		OBJECT SET VISIBLE:C603(*;"Verificando";False:C215)
		OBJECT SET VISIBLE:C603(*;"PromediosOK";False:C215)
		OBJECT SET VISIBLE:C603(*;"texto5";False:C215)
		vi_AgnosHistorico:=<>gYear-12
		vi_agnosEnfermeria:=<>gYear-12
		vi_agnosOrientacion:=<>gYear-12
		vi_agnosEventos:=<>gYear-12
		
		c1_EnCursos:=1
		c2_enCursosTemporales:=0
		cb_InscribeEnAsignaturas:=1
		
		bColacion:=0
		bFotografia:=0
		
		r2InitPropEvaluacion:=1
		r0InitPropEvaluacion:=0
		bInitPonderaciones:=1
		bEliminarSubasignaturas:=1
		bInicializarConsolidaciones:=0
		
		
		READ ONLY:C145([xxSTR_DatosDeCierre:24])
		QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1=<>gYear)
		If (Records in selection:C76([xxSTR_DatosDeCierre:24])=1)
			  //BLOB_Blob2Vars (->[xxSTR_DatosDeCierre]xPreferences;0;->bHistorico;->vi_AgnosHistorico;->bEnfermeria;->vi_AgnosEnfermeria;->bOrientacion;->vi_AgnosOrientacion;->bEventos;->vi_AgnosEventos;->bColación;->bFotografia;->r1InitPropEvaluacion;->r2InitPropEvaluacion;->bBackup;->bInitPonderaciones;->bEliminarSubasignaturas;->bInicializarConsolidaciones;->bInitNumMatricula;->i1InitNumMatricula;->i2InitNumMatricula)
			BLOB_Blob2Vars (->[xxSTR_DatosDeCierre:24]xPreferences:4;0;->bHistorico;->vi_AgnosHistorico;->bEnfermeria;->vi_AgnosEnfermeria;->bOrientacion;->vi_AgnosOrientacion;->bEventos;->vi_AgnosEventos;->bColación;->bFotografia;->r1InitPropEvaluacion;->r2InitPropEvaluacion;->bBackup;->bInitPonderaciones;->bEliminarSubasignaturas;->bInicializarConsolidaciones;->bInitNumMatricula;->i1InitNumMatricula;->i2InitNumMatricula;->vt_backupFolder;->vt_backupFile;->c1_EnCursos;->c2_enCursosTemporales;->cb_InscribeEnAsignaturas;->bArchive;->bDeleteRejected;->cbDeleteArchive;->vlADT_YearDeleteArchives)
		End if 
		If (r1InitPropEvaluacion=1)
			_O_DISABLE BUTTON:C193(*;"PropiedadesEvaluacion@")
		End if 
		
		
		OBJECT SET VISIBLE:C603(*;"bandera@";False:C215)
		OBJECT SET VISIBLE:C603(*;"bandera_"+<>vtXS_CountryCode;True:C214)
		OBJECT SET VISIBLE:C603(*;"printdiagnostico@";False:C215)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
