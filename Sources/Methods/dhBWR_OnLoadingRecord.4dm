//%attributes = {}
  //dhBWR_OnLoadingRecord

  //xShell, Alberto Bachler
  //Metodo: dhBWR_OnLoadingRecord
  //Por abachler
  //Creada el 29/09/2003, 08:54:13
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  //llamado desde: BWR_OnLoadingRecord
	  //  Se ejecuta al abrir un registro desde el explorador y al pasar de un registro a otro mediante los botones de navegación 
	  //     Poner en el Case Of , para cada tabla/formulario el código que debera ejecutarse al cargar un registro (inicialización de variables o campos utilizados en el formulario, etc)
End if 

  //****DECLARACIONES****
C_POINTER:C301($tablePointer;$1)
C_LONGINT:C283(vlSTR_PaginaFormAlumnos;vlSTR_PaginaFormFamilias;vlSTR_PaginaFormCursos;vlSTR_PaginaFormProfesores;vlSTR_PaginaFormAsignaturas;vlSTR_PaginaFormActividades;vlSTR_PaginaFormPersonas)
C_LONGINT:C283(vlBBL_PaginaFormItems;vlSTR_PaginaFormLectores;vlSTR_PaginaFormSuscripciones)
C_LONGINT:C283(vlACT_PaginaFormCuentas)

  //****INICIALIZACIONES****
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_CurrentTable
End if 

  //****CUERPO****
Case of 
	: (Table:C252($tablePointer)=Table:C252(->[Alumnos:2]))
		AL_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Familia:78]))
		FM_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Cursos:3]))
		CU_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Profesores:4]))
		PF_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Asignaturas:18]))
		AS_OnRecordLoad 
		
		
	: (Table:C252($tablePointer)=Table:C252(->[Actividades:29]))
		XCR_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Personas:7]))
		PP_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Items:61]))
		BBLitm_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Lectores:72]))
		BBLusr_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Registros:66]))
		BBLcpy_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_RegistrosAnaliticos:74]))
		BBLanl_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Subscripciones:117]))
		BBLss_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_CuentasCorrientes:175]))
		ACTcc_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Pagos:172]))
		ACTpgs_onRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		ACTpgs_onRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Documentos_de_Pago:176]))
		ACTpgs_onRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		ACTac_OnLoadAviso 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Boletas:181]))
		ACTbol_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ADT_Candidatos:49]))
		ADTcdd_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ADT_Contactos:95]))
		ADTcon_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Terceros:138]))
		ACTter_OnRecordLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Pagares:184]))
		ACTpagares_OnRecordLoad 
		
End case 