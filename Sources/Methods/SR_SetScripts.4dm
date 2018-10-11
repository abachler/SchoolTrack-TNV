//%attributes = {}
  // SR_SetScripts(refArea:&LptrArrScripts:&T ;ptrArrIdObetos:&L ;ptrArrTipoObjetos:&T)
  // Por: Alberto Bachler K.: 20-08-15, 17:48:14
  //  ---------------------------------------------
  // establece los scripts de los objetos cuyos Ids son pasados en referencia
  // el texto completo contiene todos los scripts del informe, incluyendo los scripts que se ejecutan antes y después de imprimir
  // Si se pasa 0 en refArea, se carga el informe en un area off screen, se establecen los scripts y se elimina el área
  //
  // Este método SOLO DEBE SER UTILIZADO para actualizar los scripts obtenidos con SR_GetAllScripts después de procesarlos
  //  ---------------------------------------------
C_BOOLEAN:C305($b_eliminarArea;$b_state)
C_LONGINT:C283($l_error;$l_IdDataSource;$l_idObjeto;$l_idSection;$l_idxObjeto;$l_refArea)
C_TEXT:C284($t_bodyScript;$t_endScript;$t_html1;$t_html2;$t_script;$t_scriptObjeto;$t_startScript;$t_tipoObjeto;$t_xmlReport)

ARRAY LONGINT:C221($al_idObjetos;0)
ARRAY LONGINT:C221($al_idsDS;0)
ARRAY TEXT:C222($at_scripts;0)
ARRAY TEXT:C222($at_tipoObjetos;0)

$l_refArea:=$1
COPY ARRAY:C226($2->;$at_scripts)
COPY ARRAY:C226($3->;$al_idObjetos)
COPY ARRAY:C226($4->;$at_tipoObjetos)


$b_state:=Read only state:C362([xShell_Reports:54])
If (OK=1)
	If ($l_refArea=0)
		$b_eliminarArea:=True:C214
		KRL_GotoRecord (->[xShell_Reports:54];Record number:C243([xShell_Reports:54]);True:C214)
		$l_error:=SR_NewReportBLOB ($l_refArea;[xShell_Reports:54]xReportData_:29)
	End if 
	
	
	For ($l_idxObjeto;1;Size of array:C274($al_idObjetos))
		$t_tipoObjeto:=$at_tipoObjetos{$l_idxObjeto}
		$l_idObjeto:=$al_idObjetos{$l_idxObjeto}
		$t_scriptObjeto:=$at_scripts{$l_idxObjeto}
		$l_error:=SR_GetObjects ($l_refArea;1;SRP_ReportDataSource;$al_idsDS)
		If (Size of array:C274($al_idsDS)=1)
			$l_IdDataSource:=$al_idsDS{1}
		End if 
		Case of 
			: (($at_tipoObjetos{$l_idxObjeto}="xShell_Report.ExecuteBeforePrinting") & ($l_idObjeto=-32000))
				[xShell_Reports:54]ExecuteBeforePrinting:4:=$t_scriptObjeto
				
			: (($at_tipoObjetos{$l_idxObjeto}="xShell_Report.ExecuteAfterPrinting") & ($l_idObjeto=-32000))
				[xShell_Reports:54]ExecuteAfterPrinting:30:=$t_scriptObjeto
				
			: ($at_tipoObjetos{$l_idxObjeto}="DataSource.startScript") & ($l_idObjeto=$l_IdDataSource)
				SR_SetTextProperty ($l_refArea;$l_IdObjeto;SRP_DataSource_StartScript;$t_scriptObjeto)
				
			: ($at_tipoObjetos{$l_idxObjeto}="DataSource.bodyScript") & ($l_idObjeto=$l_IdDataSource)
				SR_SetTextProperty ($l_refArea;$l_IdObjeto;SRP_DataSource_BodyScript;$t_scriptObjeto)
				
			: ($at_tipoObjetos{$l_idxObjeto}="DataSource.endScript") & ($l_idObjeto=$l_IdDataSource)
				SR_SetTextProperty ($l_refArea;$l_IdObjeto;SRP_DataSource_EndScript;$t_scriptObjeto)
				
			: (($t_tipoObjeto="var") | ($t_tipoObjeto="variable") | ($t_tipoObjeto="field") | ($t_tipoObjeto="section"))
				SR_SetTextProperty ($l_refArea;$l_IdObjeto;SRP_Object_Script;$t_scriptObjeto)
			Else 
				
		End case 
		
	End for 
	
	$l_error:=SR_SaveReport ($l_refArea;$t_xmlReport;0)
	If ($l_error=0)
		TEXT TO BLOB:C554($t_xmlReport;[xShell_Reports:54]xReportData_:29;UTF8 text without length:K22:17)
		SAVE RECORD:C53([xShell_Reports:54])
	End if 
	
	If ($b_eliminarArea)
		SR_DeleteReport ($l_refArea)
	End if 
End if 