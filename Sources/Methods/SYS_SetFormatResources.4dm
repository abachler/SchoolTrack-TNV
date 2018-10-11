//%attributes = {}
  //SYS_SetFormatResources
C_TIME:C306(<>syH_AppResourcesRef)
C_LONGINT:C283(<>lUSR_CurrentUserID)

  //◊vt_ApplicationSignature:=XS_GetApplicationInfo (1)
  //If (◊syH_AppResourcesRef=†00:00:00†)
  //Case of 
  //: ((Application type=4D Volume Desktop ) | (Application type=4D Local Mode ) | (Application type=4D Server ))
  //◊syT_PreferenceFolder:=Get 4D folder+◊vt_ApplicationSignature+" ["+String(Application type)+"] "+" Prefs"
  //: (Application type=4D Remote Mode )
  //◊syT_PreferenceFolder:=Get 4D folder+◊vt_ApplicationSignature+" ["+String(Application type)+"] "+" Prefs"
  //End case 
  //SYS_CreatePath (◊syT_PreferenceFolder)  `verifico que la ruta exista y la creo si es necesario
  //◊syT_AppResourcesPath:=◊syT_PreferenceFolder+SYS_FolderDelimiter +"Language_UID0.RES"
  //If (Test path name(◊syT_AppResourcesPath)<0)
  //◊syH_AppResourcesRef:=Create resource file(◊syT_AppResourcesPath)
  //Else 
  //error:=0
  //EM_ErrorManager ("Install")  `instalo la gestión de errores para detectar un posible daño en el archivo de  recursos después de una caída de la aplicación
  //EM_ErrorManager ("SetMode";"")
  //◊syH_AppResourcesRef:=Open resource file(◊syT_AppResourcesPath)
  //If (error#0)
  //DELETE DOCUMENT(◊syT_AppResourcesPath)  `si hay daño elimino el archivo dañado y lo recreo nuevamente.
  //◊syH_AppResourcesRef:=Create resource file(◊syT_AppResourcesPath)
  //End if 
  //EM_ErrorManager ("Clear")
  //End if 
  //End if 

SYS_GetRegionalSettings 

  //moneda despliegue  ACT
C_LONGINT:C283($index;$vl_numDecimalesDesp)
$vl_numDecimalesDesp:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimalesDespliegue"))
Case of 
	: ($vl_numDecimalesDesp=0)
		$index:=9
	: ($vl_numDecimalesDesp=1)
		$index:=1
	: ($vl_numDecimalesDesp=2)
		$index:=2
	: ($vl_numDecimalesDesp=3)
		$index:=3
	: ($vl_numDecimalesDesp=4)
		$index:=4
End case 

  //construcción de los formatos y envio a recursos. Dar la correcta dimesion al arreglo cuando agregas!!!
  //fijarse en que el nombre y numero de recurso dados en preferencias coincidan con los index del array de aca
ARRAY TEXT:C222($aFormats;46)

$aFormats{1}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"0"
$aFormats{2}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"00"
$aFormats{3}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"000"
$aFormats{4}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"0000"
$aFormats{5}:="###"+<>tXS_RS_ThousandsSeparator+"##0%"
$aFormats{6}:="###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"0%"
$aFormats{7}:="###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"00%"
$aFormats{8}:="##"+<>tXS_RS_ThousandsSeparator+"##0"
$aFormats{9}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"

Case of 
	: (<>tXS_RS_DateFormat="D@")
		$aFormats{10}:="DD"+<>tXS_RS_DateSeparator+"MM"+<>tXS_RS_DateSeparator+"YY"
		$aFormats{11}:="DD"+<>tXS_RS_DateSeparator+"MM"+<>tXS_RS_DateSeparator+"YYYY"
	: (<>tXS_RS_DateFormat="M@")
		$aFormats{12}:="MM"+<>tXS_RS_DateSeparator+"DD"+<>tXS_RS_DateSeparator+"YY"
		$aFormats{13}:="MM"+<>tXS_RS_DateSeparator+"DD"+<>tXS_RS_DateSeparator+"YYYY"
End case 
$aFormats{14}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"#"
$aFormats{15}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"##"
$aFormats{16}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"###"
$aFormats{17}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"####"

$aFormats{18}:="###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"#%"
$aFormats{19}:="###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"##%"
$aFormats{20}:="###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"###%"
$aFormats{21}:="###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"####%"

$aFormats{22}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_DecimalSeparator+"#"
$aFormats{23}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_DecimalSeparator+"##"
$aFormats{24}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_DecimalSeparator+"###"
$aFormats{25}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_DecimalSeparator+"####"

$aFormats{26}:=ACTutl_GetDecimalFormat ("Despliegue_ACT")
$aFormats{27}:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"0000"
$aFormats{28}:=ACTutl_GetDecimalFormat ("Despliegue_ACT_SinZeros")

  //formatos especificos para notas
  //valores negativos invisible, cero visible
$aFormats{29}:="##0;;0"
$aFormats{30}:="##0"+<>tXS_RS_DecimalSeparator+"0;;0"
$aFormats{31}:="##0"+<>tXS_RS_DecimalSeparator+"00;;0"
$aFormats{32}:="##0"+<>tXS_RS_DecimalSeparator+"000;;0"
$aFormats{33}:="##0"+<>tXS_RS_DecimalSeparator+"0000;;0"
$aFormats{34}:="##0"+<>tXS_RS_DecimalSeparator+"00000;;0"
$aFormats{35}:="##0"+<>tXS_RS_DecimalSeparator+"000000;;0"
  //valores negativos invisibles, cero invisible
$aFormats{36}:="##0"+<>tXS_RS_DecimalSeparator+";;"
$aFormats{37}:="##0"+<>tXS_RS_DecimalSeparator+"0;;"
$aFormats{38}:="##0"+<>tXS_RS_DecimalSeparator+"00;;"
$aFormats{39}:="##0"+<>tXS_RS_DecimalSeparator+"000;;"
$aFormats{40}:="##0"+<>tXS_RS_DecimalSeparator+"0000;;"
$aFormats{41}:="##0"+<>tXS_RS_DecimalSeparator+"00000;;"
$aFormats{42}:="##0"+<>tXS_RS_DecimalSeparator+"000000;;"

Case of 
	: (<>tXS_RS_DateFormat="D@") | (<>tXS_RS_DateFormat="M@")
		$aFormats{43}:="&9##"+<>tXS_RS_DateSeparator+"##"+<>tXS_RS_DateSeparator+"####"
	: (<>tXS_RS_DateFormat="Y@")
		$aFormats{43}:="&9####"+<>tXS_RS_DateSeparator+"##"+<>tXS_RS_DateSeparator+"##"
End case 

  //formato despliegue pagos
$aFormats{44}:=ACTutl_GetDecimalFormat ("Despliegue_ACT_Pagos")
If ($index#0)
	$aFormats{26}:=$aFormats{$index}
End if 

$aFormats{45}:="####"+<>tXS_RS_DecimalSeparator+"##;;0"
$aFormats{46}:="##0"+<>tXS_RS_DecimalSeparator+"######;;"
  //_o_ARRAY TO STRING LIST($aFormats;19000;<>syH_AppResourcesRef)
  //CLOSE RESOURCE FILE(◊syH_AppResourcesRef)
  //
  //
  //STRING LIST TO ARRAY(19000;$aFormats;◊syH_AppResourcesRef)

xliff_CargaFormatos (->$aFormats)  //20170630 RCH