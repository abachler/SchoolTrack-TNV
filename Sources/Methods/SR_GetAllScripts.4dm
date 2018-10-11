//%attributes = {}
  // SR_GetAllScripts({refArea:&L {;ptrArrScripts:&T {;ptrArrIdObetos:&L {;ptrArrTipoObjetos:&T}}}})
  // Por: Alberto Bachler K.: 19-08-15, 18:23:53
  //  ---------------------------------------------
  // retorna todos los scripts de un informe SuperReport
  // el texto completo contiene todos los scripts del informe, incluyendo los scripts que se ejecutan antes y después de imprimir
  // si se pasa una referencia de area en refArea se utiliza el area creada
  // si se pasa 0 o no se pasa nada, se carga el informe en un area off screen
  // si se pasan punteros soble los arreglos (ptrArrScripts;ptrArrIdObetos;ptrArrTipoObjetos), se devuelve el detalle los scripts en esos arreglos 
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)

C_BOOLEAN:C305($b_eliminarArea)
C_LONGINT:C283($i_secciones;$l_areaRef;$l_columnas;$l_elementoArreglo;$l_error;$l_filas;$l_idxObjeto;$l_numeroCampo;$l_numeroTabla)
C_LONGINT:C283($l_opciones;$l_orden;$l_PosAbajo;$l_PosArriba;$l_PosDerecha;$l_PosIzquierda;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV;$l_seleccionado;$l_tipoCalculo)
C_LONGINT:C283($l_tipoObjeto;$l_tipoVariable)
C_POINTER:C301($y_idObjetos;$y_scripts;$y_tipoObjetos)
C_TEXT:C284($t_encabezadoScript;$t_html1;$t_html2;$t_nombreCalculo;$t_nombreObjeto;$t_nombreVariable;$t_script;$t_ScriptCuerpo;$t_ScriptFin;$t_ScriptInicio)
C_TEXT:C284($t_ScriptObjeto;$t_textoRetorno;$t_tipoObjeto)

ARRAY LONGINT:C221($al_IdObjeto;0)
ARRAY LONGINT:C221($al_idObjetos;0)
ARRAY LONGINT:C221($al_idObjetosSRP;0)
ARRAY TEXT:C222($at_scripts;0)
ARRAY TEXT:C222($at_tipoObjeto;0)





If (False:C215)
	C_TEXT:C284(SR_GetAllScripts ;$0)
	C_LONGINT:C283(SR_GetAllScripts ;$1)
	C_POINTER:C301(SR_GetAllScripts ;$2)
	C_POINTER:C301(SR_GetAllScripts ;$3)
	C_POINTER:C301(SR_GetAllScripts ;$4)
End if 

Case of 
	: (Count parameters:C259=4)
		$y_scripts:=$2
		$y_idObjetos:=$3
		$y_tipoObjetos:=$4
		$l_areaRef:=$1
		
	: (Count parameters:C259=3)
		$y_scripts:=$2
		$y_idObjetos:=$3
		$l_areaRef:=$1
		
	: (Count parameters:C259=2)
		$y_scripts:=$2
		$l_areaRef:=$1
		
	: (Count parameters:C259=1)
		$l_areaRef:=$1
		
	Else 
		$l_areaRef:=0
End case 

If ($l_areaRef=0)
	$b_eliminarArea:=True:C214
	$l_error:=SR_NewReportBLOB ($l_areaRef;[xShell_Reports:54]xReportData_:29)
End if 

$t_ScriptObjeto:=ST_ClearExtraCR ([xShell_Reports:54]ExecuteBeforePrinting:4)
APPEND TO ARRAY:C911($at_scripts;$t_ScriptObjeto)
APPEND TO ARRAY:C911($al_IdObjeto;-32000)
APPEND TO ARRAY:C911($at_tipoObjeto;"xShell_Report.ExecuteBeforePrinting")
$t_textoRetorno:=$t_textoRetorno+"// xShell_Report.ExecuteBeforePrinting\r"+$t_ScriptObjeto+"\r// --------------------------------------\r\r"




SR_GetObjects ($l_areaRef;1;SRP_ReportAllObjects;$al_idObjetosSRP)
For ($l_idxObjeto;1;Size of array:C274($al_idObjetosSRP))
	$t_tipoObjeto:=SR_GetTextProperty ($l_areaRef;$al_idObjetosSRP{$l_idxObjeto};SRP_Object_Kind)
	Case of 
		: (($t_tipoObjeto="DataSource") | ($t_tipoObjeto="Data"))  // scripts de inicio, cuerpo y fin del informe
			$t_scriptInicio:=SR_GetTextProperty ($l_areaRef;$al_idObjetosSRP{$l_idxObjeto};SRP_DataSource_StartScript)
			$t_scriptCuerpo:=SR_GetTextProperty ($l_areaRef;$al_idObjetosSRP{$l_idxObjeto};SRP_DataSource_BodyScript)
			$t_scriptFin:=SR_GetTextProperty ($l_areaRef;$al_idObjetosSRP{$l_idxObjeto};SRP_DataSource_EndScript)
			If ($t_ScriptInicio#"")
				$t_ScriptInicio:=ST_ClearExtraCR ($t_ScriptInicio)
				APPEND TO ARRAY:C911($at_scripts;$t_ScriptInicio)
				APPEND TO ARRAY:C911($al_IdObjeto;$al_idObjetosSRP{$l_idxObjeto})
				APPEND TO ARRAY:C911($at_tipoObjeto;"DataSource.StartScript")
				$t_textoRetorno:=$t_textoRetorno+"// DataSource.StartScript\r"+$t_ScriptInicio+"\r// --------------------------------------\r\r"
			End if 
			If ($t_ScriptCuerpo#"")
				$t_ScriptCuerpo:=ST_ClearExtraCR ($t_ScriptCuerpo)
				APPEND TO ARRAY:C911($at_scripts;$t_ScriptCuerpo)
				APPEND TO ARRAY:C911($al_IdObjeto;$al_idObjetosSRP{$l_idxObjeto})
				APPEND TO ARRAY:C911($at_tipoObjeto;"DataSource.BodyScript")
				$t_textoRetorno:=$t_textoRetorno+"// DataSource.BodyScript\r"+$t_ScriptCuerpo+"\r// --------------------------------------\r\r"
			End if 
			If ($t_ScriptFin#"")
				$t_ScriptFin:=ST_ClearExtraCR ($t_ScriptFin)
				APPEND TO ARRAY:C911($at_scripts;$t_ScriptFin)
				APPEND TO ARRAY:C911($al_IdObjeto;$al_idObjetosSRP{$l_idxObjeto})
				APPEND TO ARRAY:C911($at_tipoObjeto;"DataSource.EndScript")
				$t_textoRetorno:=$t_textoRetorno+"// DataSource.EndScript\r"+$t_ScriptFin+"\r// --------------------------------------\r\r"
			End if 
			
			
		: (($t_tipoObjeto="var") | ($t_tipoObjeto="variable") | ($t_tipoObjeto="field") | ($t_tipoObjeto="section"))  // scripts de objetos
			$t_scriptObjeto:=SR_GetTextProperty ($l_areaRef;$al_idObjetosSRP{$l_idxObjeto};SRP_Object_Script)
			If ($t_scriptObjeto#"")
				$t_scriptObjeto:=ST_ClearExtraCR ($t_scriptObjeto)
				APPEND TO ARRAY:C911($at_scripts;$t_scriptObjeto)
				APPEND TO ARRAY:C911($al_IdObjeto;$al_idObjetosSRP{$l_idxObjeto})
				APPEND TO ARRAY:C911($at_tipoObjeto;$t_tipoObjeto)
				Case of 
					: (($t_tipoObjeto="var") | ($t_tipoObjeto="variable"))
						$t_nombreObjeto:=SR_GetTextProperty ($l_areaRef;$al_idObjetosSRP{$l_idxObjeto};SRP_Field_Source)
						$t_encabezadoScript:="// Variable: "+$t_nombreObjeto+"\r"
						$t_textoRetorno:=$t_textoRetorno+$t_encabezadoScript+$t_scriptObjeto+"\r// --------------------------------------\r\r"
						
					: ($t_tipoObjeto="field")
						$t_nombreObjeto:=SR_GetTextProperty ($l_areaRef;$al_idObjetosSRP{$l_idxObjeto};SRP_Field_Source)
						$l_numeroTabla:=Num:C11(ST_GetWord ($t_nombreObjeto;1;"]"))
						$l_numeroCampo:=Num:C11(ST_GetWord ($t_nombreObjeto;2;"]"))
						If ((Is table number valid:C999($l_numeroTabla)) & (Is field number valid:C1000($l_numeroTabla;$l_numeroCampo)))
							$t_encabezadoScript:="// Campo: ["+Table name:C256($l_numeroTabla)+"]"+Field name:C257($l_numeroTabla;$l_numeroCampo)+"\r"
							$t_textoRetorno:=$t_textoRetorno+$t_encabezadoScript+$t_scriptObjeto+"\r// --------------------------------------\r\r"
						Else 
							$t_script:=""
						End if 
						
					: ($t_tipoObjeto="section")
						$t_nombreObjeto:=SR_GetTextProperty ($l_areaRef;$al_idObjetosSRP{$l_idxObjeto};SRP_Object_Name)
						$t_encabezadoScript:="// Section: "+$t_nombreObjeto+"\r"
						$t_textoRetorno:=$t_textoRetorno+$t_encabezadoScript+$t_script+"\r// --------------------------------------\r\r"
				End case 
			End if 
	End case 
End for 

$t_ScriptObjeto:=ST_ClearExtraCR ([xShell_Reports:54]ExecuteAfterPrinting:30)
If ($t_ScriptObjeto#"")
	APPEND TO ARRAY:C911($at_scripts;$t_ScriptObjeto)
	APPEND TO ARRAY:C911($al_IdObjeto;-32000)
	APPEND TO ARRAY:C911($at_tipoObjeto;"xShell_Report.ExecuteAfterPrinting")
	$t_textoRetorno:=$t_textoRetorno+"// xShell_Report.ExecuteAfterPrinting\r"+$t_ScriptObjeto+"\r// --------------------------------------\r\r"
End if 

If ($b_eliminarArea)
	SR_DeleteReport ($l_areaRef)
End if 

If (Not:C34(Is nil pointer:C315($y_scripts)))
	COPY ARRAY:C226($at_scripts;$y_scripts->)
End if 
If (Not:C34(Is nil pointer:C315($y_idObjetos)))
	COPY ARRAY:C226($al_IdObjeto;$y_idObjetos->)
End if 
If (Not:C34(Is nil pointer:C315($y_tipoObjetos)))
	COPY ARRAY:C226($at_tipoObjeto;$y_tipoObjetos->)
End if 
$0:=$t_textoRetorno


