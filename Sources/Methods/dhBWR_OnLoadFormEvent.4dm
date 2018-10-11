//%attributes = {}
  //dhBWR_OnLoadFormEvent

  //xShell, Alberto Bachler
  //Metodo: dhBWR_OnLoadFormEvent
  //Por abachler
  //Creada el 29/09/2003, 08:50:38
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  //llamado desde: 
	  //
End if 

  //****DECLARACIONES****
C_POINTER:C301($tablePointer;$1)

  //****INICIALIZACIONES****
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_CurrentTable
End if 

  //****CUERPO****
Case of 
	: (Table:C252($tablePointer)=Table:C252(->[Alumnos:2]))
		AL_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Cursos:3]))
		CU_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Profesores:4]))
		PF_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Personas:7]))
		PP_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Asignaturas:18]))
		AS_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Actividades:29]))
		XCR_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Items:61]))
		BBLitm_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_RegistrosAnaliticos:74]))
		BBLanl_OnLoadFormEvent 
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Lectores:72]))
		BBLusr_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[Familia:78]))
		FM_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Subscripciones:117]))
		BBLss_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_CuentasCorrientes:175]))
		ACTcc_onLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Pagos:172]))
		ACTpgs_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		ACTpgs_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Documentos_de_Pago:176]))
		ACTpgs_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		ACTac_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Boletas:181]))
		ACTbol_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ADT_Candidatos:49]))
		ADTcdd_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ADT_Contactos:95]))
		ADTcon_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Terceros:138]))
		ACTter_OnLoad 
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Pagares:184]))
		ACTpagares_OnLoad 
		
End case 
