//%attributes = {}
  //_0000_GeneraDashBoard

C_BLOB:C604($xBlob)
ARRAY TEXT:C222(aQR_Text1;0)
APPEND TO ARRAY:C911(aQR_Text1;"dashboard")
APPEND TO ARRAY:C911(aQR_Text1;"formadepagoxmes")
APPEND TO ARRAY:C911(aQR_Text1;"saldoxmes")

C_LONGINT:C283($l_idColegio;$l_proc;$i;$j;$l_fin;$l_indice;$mes;$orden;$year)
C_TEXT:C284($ruta;$action;$json;$action)
C_TIME:C306($ref)

ACTcfg_LeeDecimalMonedaPais 

$l_idColegio:=1280
$ruta:=xfGetDirName 

$ruta:=$ruta+String:C10($l_idColegio)+SYS_FolderDelimiter 

SYS_CreatePath ($ruta)

$l_proc:=IT_UThermometer (1;0;"Generando reporte...")
For ($i;1;Size of array:C274(aQR_Text1))
	$action:=aQR_Text1{$i}
	If (<>gCountryCode="mx")
		$year:=2015
	Else 
		$year:=2016
	End if 
	$json:=""
	
	C_TEXT:C284($response;$t_ruta)
	
	If ($action="dashboard")
		$json:=DASH_GeneraJSON ($action;->$year)
		$ref:=Create document:C266($ruta+String:C10($l_idColegio)+"_"+String:C10($year)+".json")
		If (ok=1)
			CLOSE DOCUMENT:C267($ref)
			CONVERT FROM TEXT:C1011($json;"MacRoman";$xBlob)
			BLOB TO DOCUMENT:C526(document;$xBlob)
			If (ok=0)
				ALERT:C41("Error dashboard")
			End if 
		End if 
	Else 
		
		C_LONGINT:C283($l_mesInicio;$l_mes)
		If (<>gCountryCode="mx")
			$l_mesInicio:=7
		Else 
			$l_mesInicio:=1
		End if 
		
		$l_mesInicio:=Num:C11(PREF_fGet (0;"ACT_Mes_Inicio_Dashboard";String:C10($l_mesInicio)))
		
		$l_mes:=$l_mesInicio
		$l_indice:=1
		$l_fin:=($l_mesInicio+12)-1
		For ($j;$l_mesInicio;$l_fin)
			If ($l_mes=13)
				$l_mes:=1
				$year:=$year+1
			End if 
			  //For ($j;1;12)
			
			$mes:=$l_mes
			$orden:=0
			
			
			Case of 
				: ($action="formadepagoxmes")
					IT_UThermometer (0;$l_proc;"Generando reporte "+$action+" para "+String:C10($year)+String:C10($mes;"00")+"...")
					$json:=DASH_GeneraJSON ($action;->$year;->$mes)
					
				: ($action="saldoxmes")
					IT_UThermometer (0;$l_proc;"Generando reporte "+$action+" para "+String:C10($year)+String:C10($mes;"00")+"...")
					$json:=DASH_GeneraJSON ($action;->$year;->$mes;->$orden)
					
			End case 
			
			$ref:=Create document:C266($ruta+String:C10($l_idColegio)+"_"+String:C10($year)+"_"+String:C10($l_mes)+"_"+$action+".json")
			If (ok=1)
				CLOSE DOCUMENT:C267($ref)
				CONVERT FROM TEXT:C1011($json;"MacRoman";$xBlob)
				BLOB TO DOCUMENT:C526(document;$xBlob)
				If (ok=0)
					ALERT:C41("Error "+$action)
				End if 
			End if 
			
			$l_mes:=$l_mes+1
			
		End for 
	End if 
End for 
ALERT:C41("SALIDA")
CD_Dlog (0;"Script ejecutado.")
IT_UThermometer (-2;$l_proc)
ALERT:C41("SALIDA")
ALERT:C41("SALIDA")
TRACE:C157