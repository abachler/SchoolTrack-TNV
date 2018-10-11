//%attributes = {}
  //CONDOR_ValidaAutenticacion
TRACE:C157
C_LONGINT:C283($l_idApp)
C_TEXT:C284($t_llavePrivada;$t_json)
C_LONGINT:C283($l_idApp)
C_BOOLEAN:C305($b_valido)
C_TEXT:C284($t_hashRec;$t_hashCalc;$t_parametro)

ARRAY LONGINT:C221($al_idApp;0)
ARRAY TEXT:C222($at_llaves;0)

APPEND TO ARRAY:C911($al_idApp;4)
APPEND TO ARRAY:C911($at_llaves;"79694f50d2e1bc9a0630524218056bd426a90f775ea1b025a09b51e5ec5c51e0")

APPEND TO ARRAY:C911($al_idApp;-1)
APPEND TO ARRAY:C911($at_llaves;"ac1cdf5196fa0da8a220d11279ec8349b265f14816e56b8efe13e1d560d0ddd6")

$l_idApp:=$1
$t_json:=$2

$l_indice:=Find in array:C230($al_idApp;$l_idApp)
If ($l_indice>0)
	$t_llavePrivada:=$at_llaves{$l_indice}
	
	  //$t_principal:=JSON Parse text ($t_json)
	  //If (($t_principal#"0") & ($t_principal#"false"))
	If (Valida_json ($t_json))
		  // Modificado por: Alexis Bustamante (12-06-2017)
		  //Ticket 179869
		C_OBJECT:C1216($ob;$ob_auntenticacion)
		$ob:=OB_Create 
		$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
		OB_GET ($ob;->$ob_auntenticacion;"autenticacion")
		OB_GET ($ob_auntenticacion;->$l_idApp;"aplicacion")
		OB_GET ($ob_auntenticacion;->$t_hashRec;"llave")
		OB_GET ($ob_auntenticacion;->$t_parametro;"parametro")
		
		  //$t_err:=JSON Get child by name ($t_principal;"autenticacion")
		  //JSON_ExtraeValor ($t_err;"aplicacion";->$l_idApp)
		  //JSON_ExtraeValor ($t_err;"llave";->$t_hashRec)
		  //JSON_ExtraeValor ($t_err;"parametro";->$t_parametro)
		  //JSON CLOSE ($t_principal)
		CONVERT FROM TEXT:C1011($t_parametro+$t_llavePrivada;"utf-8";$blob)
		$t_hashCalc:=SHA512 ($blob;Crypto HEX)
		If ($t_hashRec#"")
			If ($t_hashRec=$t_hashCalc)
				$b_valido:=True:C214
			End if 
		End if 
	End if 
End if 

$0:=$b_valido