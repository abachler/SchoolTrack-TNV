//%attributes = {}
  //pCALL_BWR_StartBrowser

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 05/08/03, 12:28:19
  // -------------------------------------------------------------------------------
  // Metodo: pCALL_BWR_StartBrowser
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_LONGINT:C283(vlSTR_PaginaFormAlumnos;vlSTR_PaginaFormCursos;vlSTR_PaginaFormProfesores;vlSTR_PaginaFormAsignaturas;vlXS_BrowserWindowID)
ARRAY LONGINT:C221(<>alXS_ModuleRef;0)
ARRAY TEXT:C222(<>atXS_ModuleNames;0)


  // INICIALIZACIONES
  // -------------------------------------------------------------------------------

LIST TO ARRAY:C288("XS_Modules";<>atXS_ModuleNames;<>alXS_ModuleRef)
ARRAY LONGINT:C221(<>alXS_ModuleProcessID;Size of array:C274(<>alXS_ModuleRef))

If (Count parameters:C259=1)
	$moduleRef:=$1
Else 
	$moduleRef:=<>alXS_ModuleRef{1}
End if 

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
<>vt_CloseSesion:=False:C215
$position:=Find in array:C230(<>alXS_ModuleRef;$moduleRef)
<>vsXS_CurrentModule:=<>atXS_ModuleNames{$position}
If (<>alXS_ModuleProcessID{$Position}=0)
	
	  //20120827 RCH Se registra el inicio de sesion. Se quita de donde estaba porque no registraba el modulo.
	$vb_inicioSesion:=True:C214
	For ($i;1;Size of array:C274(<>alXS_ModuleRef))
		If (<>alXS_ModuleProcessID{$i}#0)
			$vb_inicioSesion:=False:C215
			$i:=Size of array:C274(<>alXS_ModuleProcessID)
		End if 
	End for 
	
	<>alXS_ModuleProcessID{$Position}:=New process:C317("BWR2_StartBrowser";512*1024;"Explorador "+<>atXS_ModuleNames{$position};<>alXS_ModuleRef{$Position};<>atXS_ModuleNames{$position})
	PCS_RegisterProcesses (<>alXS_ModuleProcessID{$Position})
	
	If ($vb_inicioSesion)
		vsBWR_CurrentModule:=<>vsXS_CurrentModule
		LOG_RegisterEvt ("Inicio de sesión")
	Else 
		LOG_RegisterEvt ("Cambio de módulo. De "+vsBWR_CurrentModule+" a "+<>vsXS_CurrentModule+".")
	End if 
Else 
	LOG_RegisterEvt ("Cambio de módulo. De "+<>vsXS_CurrentModule+" a "+vsBWR_CurrentModule+".")
	SHOW PROCESS:C325(<>alXS_ModuleProcessID{$Position})
	BRING TO FRONT:C326(<>alXS_ModuleProcessID{$Position})
End if 

  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------

