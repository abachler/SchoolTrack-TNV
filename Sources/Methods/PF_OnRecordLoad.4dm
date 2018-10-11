//%attributes = {}
  // MÉTODO: PF_OnRecordLoad
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/12, 12:24:19
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // PF_OnRecordLoad()
  // ----------------------------------------------------
C_LONGINT:C283($l_registros;$l_AdmissionTrackInicializado)
C_LONGINT:C283(viBWR_RecordWasSaved)
C_LONGINT:C283(vlSTR_PaginaFormProfesores)

C_BOOLEAN:C305(AsigAutorizada;ProfCarrera;campopropio)  ///ABC variables para manjear en PF_fsave el guardado de subrecords.197852 
AsigAutorizada:=False:C215
ProfCarrera:=False:C215

  //campopropio:=False
  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
vb_guardarCambios:=False:C215

  // CODIGO PRINCIPAL
Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		$l_AdmissionTrackInicializado:=Num:C11(PREF_fGet (0;"ADT_Inicializado";"0"))
		OBJECT SET VISIBLE:C603([Profesores:4]Es_Entrevistador_Admisiones:35;($l_AdmissionTrackInicializado=1))
		OBJECT SET VISIBLE:C603([Profesores:4]Es_Examinador_Admisiones:63;($l_AdmissionTrackInicializado=1))
		
		SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;1;True:C214;1;0)
		SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;2;True:C214;1;0)
		
		If ([Profesores:4]Es_Tutor:34)
			SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;3;True:C214;1;0)
		Else 
			SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;3;False:C215;1;0)
		End if 
		alProEvt:=0
		Case of 
			: (vlSTR_PaginaFormProfesores=1)
				AL_RemoveArrays (xALP_pfUF;1;10)
				AT_Initialize (->aUFItmName;->aUFItmVal)
			: (vlSTR_PaginaFormProfesores=2)
				AL_RemoveArrays (xALP_AsgLst;1;10)
				AT_Initialize (->aAsgNm;->aAsgCl;->aAsgNo)
			: (vlSTR_PaginaFormProfesores=3)
				AL_RemoveArrays (xALP_Students;1;30)
				AL_RemoveArrays (xALP_Tutoria1;1;30)
				AL_RemoveArrays (xALP_Tutoria2;1;30)
				AL_RemoveArrays (xALP_Tutoria3;1;30)
				AT_Initialize (->aStdClass;->aStdName;->aStdRecNo)
				PF_initArrays 
		End case 
		
		If (Count parameters:C259=1)
			vlSTR_PaginaFormProfesores:=$1
		Else 
			If (vlSTR_PaginaFormProfesores=0)
				vlSTR_PaginaFormProfesores:=1
			End if 
		End if 
		If (Record number:C243([Profesores:4])=-3)
			If (<>vlSTR_UsarSoloUnApellido=1)
				OBJECT SET ENTERABLE:C238(*;"Field2";False:C215)
			Else 
				OBJECT SET ENTERABLE:C238(*;"Field2";True:C214)
			End if 
			vlSTR_PaginaFormProfesores:=1
			If (<>viSTR_AsignarComunaDefecto=1)
				[Profesores:4]Comuna:10:=<>gComuna
			End if 
		Else 
			OBJECT SET ENTERABLE:C238(*;"Field2";True:C214)
		End if 
		
		SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_profesores;vlSTR_PaginaFormProfesores)
		
		Case of 
			: (vlSTR_PaginaFormProfesores=1)
				PF_BeforeCard1 
				FORM GOTO PAGE:C247(vlSTR_PaginaFormProfesores)
				vlSTR_PaginaFormProfesores:=1
			: (vlSTR_PaginaFormProfesores=2)
				PF_BeforeCard2 
				FORM GOTO PAGE:C247(vlSTR_PaginaFormProfesores)
				vlSTR_PaginaFormProfesores:=2
			: (vlSTR_PaginaFormProfesores=3)
				If ([Profesores:4]Es_Tutor:34)
					PF_BeforeCard3 
					FORM GOTO PAGE:C247(vlSTR_PaginaFormProfesores)
					vlSTR_PaginaFormProfesores:=3
				Else 
					PF_BeforeCard1 
					FORM GOTO PAGE:C247(vlSTR_PaginaFormProfesores)
					vlSTR_PaginaFormProfesores:=1
				End if 
		End case 
		
		If (Record number:C243([Profesores:4])=-3)
			SET WINDOW TITLE:C213(__ ("Nuevo profesor"))
			If (<>viSTR_AsignarComunaDefecto=1)
				[Profesores:4]Comuna:10:=<>gComuna
			End if 
		Else 
			SET WINDOW TITLE:C213(__ ("Profesores: ")+[Profesores:4]Nombre_comun:21)
		End if 
		OBJECT SET RGB COLORS:C628(vp_ColorHorario;0x0000;[Profesores:4]Color_en_Horario:67)
		
		
		OBJECT SET VISIBLE:C603(*;"muerte@";[Profesores:4]Fallecido:70)
		IT_SetEnterable (Not:C34([Profesores:4]Fallecido:70);0;->[Profesores:4]Inactivo:62)
	: (vsBWR_CurrentModule="AdmissionTrack")
		SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_profesores;1)
		UFLD_LoadFields (->[Profesores:4];->[Profesores:4]Userfields:31;->[Profesores]Userfields'Value;->xALP_pfUF)
		ADTivws_OnRecordLoad 
End case 

If (<>viSTR_ReligionExtendida=1)
	If ([Profesores:4]Religion:73#"")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=[Profesores:4]Religion:73)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_registros>0)
			OBJECT SET FONT STYLE:C166(*;"religion";Underline:K14:4)
			OBJECT SET COLOR:C271(*;"religion";-6)
			_O_ENABLE BUTTON:C192(bReligionExt)
		Else 
			OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
			OBJECT SET COLOR:C271(*;"religion";-15)
			_O_DISABLE BUTTON:C193(bReligionExt)
		End if 
	Else 
		OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
		OBJECT SET COLOR:C271(*;"religion";-15)
		_O_DISABLE BUTTON:C193(bReligionExt)
	End if 
Else 
	OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
	OBJECT SET COLOR:C271(*;"religion";-15)
	_O_DISABLE BUTTON:C193(bReligionExt)
End if 

  //20120912 ASM 
If (Is new record:C668([Profesores:4]))
	[Profesores:4]Es_docente:76:=True:C214
End if 

