//%attributes = {}
  //dhXS_Before_XShell_startup

C_BOOLEAN:C305(<>vb_esBaseDeDatosNueva;$0;$b_continuar)  //MONO TICKET 213250

WDW_SetWindowIcon 

<>vt_ApplicationSignature:=XS_GetApplicationInfo (1)
<>vtXS_AppName:=XS_GetApplicationInfo (1)

<>vsXS_CurrentModule:="SchoolTrack"
If (Application type:C494#4D Server:K5:6)
	If (Test semaphore:C652("CierreAñoEscolar")=True:C214)
		HIDE PROCESS:C324(<>Splash)
		<>vb_MsgON:=True:C214
		$ignore:=CD_Dlog (0;__ ("El proceso de cierre del año escolar se está ejecutando en el servidor.\r\rNo es posible iniciar una sesión mientras se ejecuta el proceso de cierre de año."))
		QUIT 4D:C291
	Else 
		$step:=Num:C11(ST_GetWord (PREF_fGet (0;"Cierre del año escolar";"0");1;":"))
		If ($step>0)
			<>vb_MsgON:=True:C214
			$ignore:=CD_Dlog (0;__ ("Se produjo una interrupción mientras se efectuaba el cierre del año escolar.\rNo es posible continuar con la operación de cierre de año en esta base de datos.\r\rPOR FAVOR REINICIE EL CIERRE UTILIZANDO UN RESPALDO DE SU BASE DE DATOS."))
			QUIT 4D:C291
		End if 
		
		_O_PLATFORM PROPERTIES:C365($platform)
		If ($platform=3)
			$err:=gui_GetWndRect (vl_DefaultWinRef;$left;$top;$width;$height)
			$err:=gui_SetWindowTitle (vl_DefaultWinRef;<>vtXS_AppName)
			If ($width<=800)
				$err:=gui_ShowWindow (vl_DefaultWinRef;SW_MAXIMIZE)
				$err:=gui_GetWndRect (vl_DefaultWinRef;$left;$top;$width;$height)
			End if 
			$err:=gui_GetWndRect (vl_DefaultWinRef;$left;$top;$width;$height)
			$heightAppWin:=Screen height:C188(*)
		Else 
			$height:=Screen height:C188(*)
		End if 
	End if 
	
	<>vt_ApplicationSignature:=XS_GetApplicationInfo (1)  //COPIAR A ST
	<>vtXS_AppName:=XS_GetApplicationInfo (1)  //COPIAR A STvl_DefaultWinRef:=gui_GetWindow("")
	
End if 


  //MONO TICKET 213250
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos 
ALL RECORDS:C47([Colegio:31])
If (($t_versionBaseDeDatos="") | (Records in selection:C76([Colegio:31])=0))
	<>vtXS_langage:="es"
	<>vtXS_CountryCode:="cl"
	<>vs_AppDecimalSeparator:=(PREF_fGet (0;"DecimalSeparator";","))
	
	HIDE PROCESS:C324(<>Splash)
	
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	If ([Colegio:31]Rol Base Datos:9#"")  //si la base de datos ya está inicializada
		TRACE:C157
	Else 
		If (Application type:C494#4D Server:K5:6)
			<>vb_esBaseDeDatosNueva:=True:C214
			<>vi_ReservedOP:=Num:C11(PREF_fGet (0;"Reserved Licences";"0"))
			XS_InitVariables 
			PREF_Set (0;"ACT_Inicializado";"0")
			PREF_Set (0;"ADT_Inicializado";"0")
			PREF_Set (0;"SNII";"1")
			STR_ConfiguraNuevaBase 
		Else 
			$b_continuar:=False:C215
			ALERT:C41("La base de datos que está abriendo, se está asumiendo como una nueva base de datos, para inicializarla por favor ábrala con la aplicación en monousuario, el servidor será cerrado.")
			QUIT 4D:C291
		End if 
	End if 
	
	FLUSH CACHE:C297
	SHOW PROCESS:C325(<>Splash)
End if 

$0:=$b_continuar
