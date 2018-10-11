//%attributes = {}
C_LONGINT:C283($l_idRS;$1)
C_TEXT:C284($t_function;$t_retorno;$0)
C_BOOLEAN:C305($2)
C_POINTER:C301($3)
C_TEXT:C284($4)
C_BOOLEAN:C305($B_executionWasOK)
C_TEXT:C284($t_result)
C_BLOB:C604($xBlob)
C_POINTER:C301($y_xBlob)
ARRAY TEXT:C222($etiquetasErr;0)
ARRAY TEXT:C222($valoresErr;0)
C_TEXT:C284($t_dtsAhora)

$t_ws:="wsfe"
$l_idRS:=$1

If ($l_idRS=0)
	$l_idRS:=-1
End if 

$b_consumeWSAA:=$2
If (Count parameters:C259>=3)
	$y_xBlob:=$3
End if 
If (Count parameters:C259>=4)
	$t_dtsAhora:=$4
End if 

$t_nomPref:=ACTfear_OpcionesGenerales ("ObtieneNombrePreferencia";->$l_idRS;->$t_ws)

ACTfear_OpcionesGenerales ("CargaConf";->$l_idRS)

If (vtACT_errorPHPExec="")
	$t_function:=""
	If (vtACT_rutaScript#"")
		$B_executionWasOK:=PHP Execute:C1058(vtACT_rutaScript;$t_function;T_result)
		If ($B_executionWasOK)
			PHP GET FULL RESPONSE:C1061($t_result;$etiquetasErr;$valoresErr)
			If ((Position:C15("error";$t_result)>0) | (Position:C15("fail";$t_result)>0))
				$t_retorno:=__ ("Error al generar el requerimiento de ticket de acceso.")+"\r"+"Error: "+$t_result
			Else 
				$t_retorno:=""
				
				If ($b_consumeWSAA)
					$t_response:=WSact_FEARLoginWSAA ($t_result;$t_nomPref;$t_dtsAhora;$l_idRS)
					  //SET TEXT TO PASTEBOARD($t_response)
					If ($t_response#"")
						C_BLOB:C604($xBlob)
						CONVERT FROM TEXT:C1011($t_response;"UTF-8";$xBlob)
						PREF_SetBlob (0;$t_nomPref+"_RESPONSE";$xBlob)
						PREF_Set (0;$t_nomPref+"_RESPONSE";$t_dtsAhora)
						
						$y_xBlob->:=$xBlob
					Else 
						$t_retorno:="Error al consumir servicio"
					End if 
				End if 
				
			End if 
		Else 
			$t_retorno:="El script no fue ejecutado correctamente."
		End if 
	Else 
		Case of 
			: (vtACT_rutaCertificado="")
				$t_retorno:="Ingrese la ruta del certificado."
			: (vtACT_rutaLLavePrivada="")
				$t_retorno:="Ingrese la ruta de la llave privada."
			Else 
				$t_retorno:="La ruta del script no fue encontrada."
		End case 
	End if 
Else 
	$t_retorno:=vtACT_errorPHPExec
End if 

$0:=$t_retorno