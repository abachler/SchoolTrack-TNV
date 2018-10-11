//%attributes = {}
C_LONGINT:C283($1;$2;$profID;$userID)
C_TEXT:C284($dominio;$url)
C_OBJECT:C1216($ob_json;$ob_raiz)
C_TEXT:C284($mensaje;$llave;$puente;$status)

  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_json)
C_LONGINT:C283($httpStatus_l)

$profID:=$1
$userID:=$2
$ob_raiz:=OB_Create 

If ($userID>=0)
	  //MONO ticket 144984
	$ob_request:=OB_Create 
	OB_SET ($ob_request;-><>GROLBD;"rolbd")
	OB_SET ($ob_request;-><>GCOUNTRYCODE;"codpais")
	
	$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
	$httpStatus_l:=Intranet3_LlamadoWS ("WS_GAFEGetDominioColegio";$t_jsonRequest;->$t_json)
	
	If ($httpStatus_l=200)
		$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
		OB_GET ($ob_response;->$dominio;"resultado")
	End if 
	
	If ($dominio#"")
		$datosConexion:=STWA2_GAFE_ObtenerDatosConexion ($profID)
		ARRAY TEXT:C222($nodes;0)
		ARRAY LONGINT:C221($types;0)
		ARRAY TEXT:C222($names;0)
		
		ARRAY TEXT:C222($at_propiedadJson;0)
		ARRAY LONGINT:C221($al_propiedadJsonref;0)
		$ob_json:=OB_JsonToObject ($datosConexion)
		OB GET PROPERTY NAMES:C1232($ob_json;$at_propiedadJson;$al_propiedadJsonref)
		  //$l_pos:=Find in array($at_propiedadJson;"status")
		  //$status:=OB Get($ob_json;$at_propiedadJson{$l_pos};OB Get type($ob_json;$at_propiedadJson{$l_pos}))
		OB_GET ($ob_json;->$status;"status")  //MONO 186434
		
		If ($status="0")
			  //$l_pos:=Find in array($at_propiedadJson;"mensaje")
			  //$mensaje:=OB Get($ob_json;$at_propiedadJson{$l_pos};OB Get type($ob_json;$at_propiedadJson{$l_pos}))
			OB_GET ($ob_json;->$mensaje;"mensaje")  //MONO 186434
			  //$l_pos:=Find in array($at_propiedadJson;"llave")
			  //$llave:=OB Get($ob_json;$at_propiedadJson{$l_pos};OB Get type($ob_json;$at_propiedadJson{$l_pos}))
			OB_GET ($ob_json;->$llave;"llave")  //MONO 186434
			  //$l_pos:=Find in array($at_propiedadJson;"urlpuente")
			  //$puente:=OB Get($ob_json;$at_propiedadJson{$l_pos};OB Get type($ob_json;$at_propiedadJson{$l_pos}))
			OB_GET ($ob_json;->$puente;"urlpuente")  //MONO 186434
			
			SN3_LoadGAFESettings 
			ARRAY TEXT:C222($urls;0)
			ARRAY TEXT:C222($atags;0)
			If (cb_GAFE_Prof=1)
				If (cb_GAFE_Prof_Mail=1)
					$url:=$puente+"?valor="+$llave+"&url=http://mail.google.com/a/"+$dominio
					APPEND TO ARRAY:C911($urls;$url)
					APPEND TO ARRAY:C911($atags;"Google Mail")
				End if 
				If (cb_GAFE_Prof_Drive=1)
					$url:=$puente+"?valor="+$llave+"&url=http://docs.google.com/a/"+$dominio
					APPEND TO ARRAY:C911($urls;$url)
					APPEND TO ARRAY:C911($atags;"Google Drive")
				End if 
				OB_SET ($ob_raiz;->$urls;"urls")
				OB_SET ($ob_raiz;->$atags;"tags")
				
			Else 
				OB_SET_Text ($ob_raiz;"-1";"ERR")
			End if 
		Else 
			OB_SET_Text ($ob_raiz;"-1";"ERR")
		End if 
	Else 
		OB_SET_Text ($ob_raiz;"-1";"ERR")
	End if 
Else 
	OB_SET_Text ($ob_raiz;"-1";"ERR")
End if 
$0:=OB_Object2Json ($ob_raiz)
