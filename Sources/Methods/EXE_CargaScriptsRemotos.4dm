//%attributes = {}
  // EXE_CargaScriptsRemotos()
  // Por: Alberto Bachler: 02/05/13, 12:08:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_TEXT:C284($t_textoScript;$t_error;$t_NombreScript)

ARRAY LONGINT:C221($al_IdScripts;0)
C_LONGINT:C283($i)

$t_error:=WSexe_ListaScriptsRemotos_in (->$al_IdScripts)
For ($i;1;Size of array:C274($al_IdScripts))
	$t_error:=WSexe_LeeScript_in ($al_IdScripts{$i};->$t_textoScript;->$t_NombreScript)
	If ($t_error="")
		If (($t_NombreScript#"") & ($t_textoScript#""))
			$l_numeroProceso:=New process:C317("EXE_EjecutaScriptRemoto";256000;$t_NombreScript;$al_IdScripts{$i};$t_textoScript)
		End if 
	End if 
End for 
