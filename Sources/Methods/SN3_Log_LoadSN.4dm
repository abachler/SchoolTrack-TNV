//%attributes = {}
  //SN3_Log_LoadSN

ARRAY DATE:C224(SN3_Log_FechaSN;0)
ARRAY LONGINT:C221(SN3_Log_HoraSN;0)
ARRAY TEXT:C222(SN3_Log_DescripcionSN;0)
ARRAY LONGINT:C221(SN3_Log_ColoresSN;0)
ARRAY LONGINT:C221(SN3_Log_EstilosSN;0)
ARRAY LONGINT:C221(SN3_Log_TipoSN;0)
ARRAY TEXT:C222(SN3_Log_DescErrorSN;0)
ARRAY TEXT:C222(SN3_Log_MaquinaSN;0)

ARRAY TEXT:C222($result;0)
$desde:=Add to date:C393(Current date:C33(*);0;0;-14)
$hasta:=Current date:C33(*)+1

$desde:=vdSN3_LogDesde
$hasta:=vdSN3_LogHasta

$desdeSQL:=String:C10(Year of:C25($desde);"0000")+"-"+String:C10(Month of:C24($desde);"00")+"-"+String:C10(Day of:C23($desde);"00")+" "+"00:00:00"
$hastaSQL:=String:C10(Year of:C25($hasta);"0000")+"-"+String:C10(Month of:C24($hasta);"00")+"-"+String:C10(Day of:C23($hasta);"00")+" "+"00:00:00"

$ccode:=<>vtXS_CountryCode
$rol:=<>gRolBD
TRACE:C157
WEB SERVICE SET PARAMETER:C777("codpais";$ccode)
WEB SERVICE SET PARAMETER:C777("rolbd";$rol)
WEB SERVICE SET PARAMETER:C777("desde";$desdeSQL)
WEB SERVICE SET PARAMETER:C777("hasta";$hastaSQL)

$p:=IT_UThermometer (1;0;__ ("Conectando con servidor SchoolNet...");-1)
$err:=SN3_CallWebService ("sn3ws_log_proceso.listado")
IT_UThermometer (-2;$p)

If ($err="")
	WEB SERVICE GET RESULT:C779($result;"resultado";*)
	$error:=$result{Size of array:C274($result)}
	If ($error#"0")
		CD_Dlog (0;__ ("Se ha producido un error al intentar obtener el listado de actividades."))
	Else 
		For ($i;1;(Size of array:C274($result)-1))
			$fecha:=ST_GetWord ($result{$i};2;"\t")
			$hora:=ST_GetWord ($result{$i};3;"\t")
			$desc:=ST_GetWord ($result{$i};4;"\t")
			$tipo:=ST_GetWord ($result{$i};6;"\t")
			APPEND TO ARRAY:C911(SN3_Log_FechaSN;Date:C102($fecha))
			APPEND TO ARRAY:C911(SN3_Log_HoraSN;Time:C179($hora))
			APPEND TO ARRAY:C911(SN3_Log_DescripcionSN;$desc)
			APPEND TO ARRAY:C911(SN3_Log_TipoSN;Num:C11($tipo))
			Case of 
				: (SN3_Log_TipoSN{Size of array:C274(SN3_Log_TipoSN)}=SN3_Log_Error)
					APPEND TO ARRAY:C911(SN3_Log_ColoresSN;0x00FF0000)
					APPEND TO ARRAY:C911(SN3_Log_EstilosSN;Bold:K14:2)
				: (SN3_Log_TipoSN{Size of array:C274(SN3_Log_TipoSN)}=SN3_Log_FileGeneration)
					APPEND TO ARRAY:C911(SN3_Log_ColoresSN;0x0AAA)
					APPEND TO ARRAY:C911(SN3_Log_EstilosSN;Plain:K14:1)
				: (SN3_Log_TipoSN{Size of array:C274(SN3_Log_TipoSN)}=SN3_Log_FileSent)
					APPEND TO ARRAY:C911(SN3_Log_ColoresSN;0x00FF)
					APPEND TO ARRAY:C911(SN3_Log_EstilosSN;Plain:K14:1)
				: (SN3_Log_TipoSN{Size of array:C274(SN3_Log_TipoSN)}=SN3_Log_Info)
					APPEND TO ARRAY:C911(SN3_Log_ColoresSN;0xBB00)
					APPEND TO ARRAY:C911(SN3_Log_EstilosSN;Italic:K14:3)
				Else 
					APPEND TO ARRAY:C911(SN3_Log_ColoresSN;0xBB00)
					APPEND TO ARRAY:C911(SN3_Log_EstilosSN;Italic:K14:3)
			End case 
			APPEND TO ARRAY:C911(SN3_Log_DescErrorSN;"")
			APPEND TO ARRAY:C911(SN3_Log_MaquinaSN;"")
		End for 
		AT_MultiLevelSort ("<<";->SN3_Log_FechaSN;->SN3_Log_HoraSN;->SN3_Log_DescripcionSN;->SN3_Log_ColoresSN;->SN3_Log_EstilosSN;->SN3_Log_TipoSN;->SN3_Log_DescErrorSN;->SN3_Log_MaquinaSN)
	End if 
Else 
	CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
End if 
SN3_Log_ManageSNLog (vd_Log_SelectedFecha;cb_Log_VerErrores;cb_Log_VerInfo;cb_Log_VerGeneracion;cb_Log_VerEnvios)