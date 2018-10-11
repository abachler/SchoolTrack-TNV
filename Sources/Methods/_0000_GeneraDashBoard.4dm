//%attributes = {}
  //_0000_GeneraDashBoard

C_BLOB:C604($xBlob)
ARRAY TEXT:C222(aQR_Text1;0)
APPEND TO ARRAY:C911(aQR_Text1;"dashboard")
APPEND TO ARRAY:C911(aQR_Text1;"formadepagoxmes")
APPEND TO ARRAY:C911(aQR_Text1;"saldoxmes")

  //$l_idColegio:=119  //CUmbres
  //$l_idColegio:=162  //Highlands
  //$l_idColegio:=130  //La Cruz
  //$l_idColegio:=149  //San Isidro
  //$l_idColegio:=161  //Everest


  //Alemanes
$l_idColegio:=4366  //Aleman de Chicureo
$l_idColegio:=4365  //Aleman de Santiago
$l_idColegio:=4367  //Insalco

ACTcfg_LeeDecimalMonedaPais 

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
	  //$t_ruta:="http://201.132.118.126/dashboard/saldoxmes"
	  //$t_ruta:="http://hermes.colegium.com/dashboard/saldoxmes"
	$t_ruta:="http://hermes.colegium.com/dashboard/"  // hermes
	
	$t_ruta:="http://200.73.64.30/dashboard/"  // Aleman de Chicureo
	$t_ruta:="http://200.73.64.29:81/dashboard/"  // Aleman de Santiago
	$t_ruta:="http://200.73.64.27/dashboard/"  // Insalco
	
	If ($action="dashboard")
		  //$json:=DASH_GeneraJSON ($action;->$year)
		
		$body_t:="year="+String:C10($year)
		$t_url:=$t_ruta+$action
		$httpStatus_l:=HTTP Request:C1158(HTTP POST method:K71:2;$t_url;$body_t;$json)
		
		$ref:=Create document:C266($ruta+String:C10($l_idColegio)+"_"+String:C10($year)+".json")
		If (ok=1)
			CLOSE DOCUMENT:C267($ref)
			CONVERT FROM TEXT:C1011($json;"MacRoman";$xBlob)
			BLOB TO DOCUMENT:C526(document;$xBlob)
			If (ok=0)
				ALERT:C41("Error")
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
			$t_url:=$t_ruta+$action
			Case of 
				: ($action="formadepagoxmes")
					IT_UThermometer (0;$l_proc;"Generando reporte "+$action+" para "+String:C10($year)+String:C10($mes;"00")+"...")
					  //$json:=DASH_GeneraJSON ($action;->$year;->$mes)
					
					$body_t:="year="+String:C10($year)+"&mes="+String:C10($mes)+"&orden=0"
					$httpStatus_l:=HTTP Request:C1158(HTTP POST method:K71:2;$t_url;$body_t;$json)
					
					
				: ($action="saldoxmes")
					IT_UThermometer (0;$l_proc;"Generando reporte "+$action+" para "+String:C10($year)+String:C10($mes;"00")+"...")
					  //$json:=DASH_GeneraJSON ($action;->$year;->$mes;->$orden)
					
					$body_t:="year="+String:C10($year)+"&mes="+String:C10($mes)+"&orden=0"
					$httpStatus_l:=HTTP Request:C1158(HTTP POST method:K71:2;$t_url;$body_t;$json)
					
			End case 
			
			$ref:=Create document:C266($ruta+String:C10($l_idColegio)+"_"+String:C10($year)+"_"+String:C10($l_mes)+"_"+$action+".json")
			If (ok=1)
				CLOSE DOCUMENT:C267($ref)
				CONVERT FROM TEXT:C1011($json;"MacRoman";$xBlob)
				BLOB TO DOCUMENT:C526(document;$xBlob)
				If (ok=0)
					ALERT:C41("Error")
				End if 
			End if 
			
			$l_mes:=$l_mes+1
			
		End for 
	End if 
End for 
IT_UThermometer (-2;$l_proc)
TRACE:C157