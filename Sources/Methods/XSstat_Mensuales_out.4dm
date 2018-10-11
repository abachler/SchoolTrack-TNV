//%attributes = {}
  // XSstat_Mensuales_out()
  // Por: Alberto Bachler: 29/04/13, 16:35:27
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_forzarParaPruebas)
C_DATE:C307($d_fecha)
_O_C_INTEGER:C282($i_eventos;$i_modulos)
C_LONGINT:C283($l_TipoPeriodo;$l_total;$l_UsuariosUnicos)
C_TEXT:C284($t_codigoPais;$t_DTS_inicioPeriodo;$t_DTS_terminoPeriodo;$t_errorWS;$t_NombrePeriodo;$t_rolBD;$t_uuidInstitucion)

ARRAY LONGINT:C221($al_IdEvento;0)
ARRAY LONGINT:C221($al_NumeroEventos;0)
ARRAY LONGINT:C221($al_tiposEventos_Id;0)
ARRAY LONGINT:C221($al_TotalEventos;0)
ARRAY LONGINT:C221($al_UsuariosUnicos;0)
ARRAY LONGINT:C221($al_UsuariosUnicosPorEvento;0)
ARRAY TEXT:C222($at_modulos;0)
ARRAY TEXT:C222($at_modulosEventos;0)
ARRAY TEXT:C222($at_tiposEvento_nombre;0)
ARRAY TEXT:C222($at_Usuario;0)



C_TEXT:C284(vt_ErrorWebService)
C_BOOLEAN:C305(<>bXS_esServidorOficial)

Case of 
	: (Count parameters:C259=2)
		$b_forzarParaPruebas:=$2
		$d_fecha:=$1
	: (Count parameters:C259=1)
		$d_fecha:=$1
	Else 
		$d_fecha:=Current date:C33(*)
End case 

If ($d_Fecha=!00-00-00!)
	$d_fecha:=Current date:C33(*)
End if 

$l_dia:=Day of:C23($d_fecha)
$l_mes:=Month of:C24($d_fecha)
$l_año:=Year of:C25($d_fecha)
Case of 
	: (($l_dia=1) & ($l_mes=1))
		$l_año:=$l_año-1
		$l_Mes:=12
		
	: ($l_dia=1)
		$l_Mes:=$l_Mes-1
		
	Else 
		$l_dia:=$l_Dia-1
End case 
$l_ultimoDiaMes:=DT_GetLastDay ($l_Mes;$l_año)


$t_DTS_inicioPeriodo:=String:C10($l_año;"0000")+String:C10($l_mes;"00")+String:C10($l_dia;"00")+"0000"
$t_DTS_terminoPeriodo:=String:C10($l_año;"0000")+String:C10($l_mes;"00")+String:C10($l_ultimoDiaMes;"00")+"2359"
$l_TipoPeriodo:=2
$t_NombrePeriodo:=String:C10($l_año;"0000")+String:C10($l_Mes;"00")

QUERY:C277([xShell_UserEvents:282];[xShell_UserEvents:282]DTS:3>=$t_DTS_inicioPeriodo;*)
QUERY:C277([xShell_UserEvents:282]; & ;[xShell_UserEvents:282]DTS:3<=$t_DTS_terminoPeriodo)
CREATE SET:C116([xShell_UserEvents:282];"EventosDelPeriodo")

If (((Application type:C494=4D Server:K5:6) & (<>bXS_esServidorOficial)) | ($b_forzarParaPruebas))
	
	  // obtengo un lista con los módulos actuales de la aplicación
	LIST TO ARRAY:C288("XS_Modules";$at_modulos)
	  // obtengo la lista de tipos de eventos usuarios que se registran actualmente en SchoolTrack
	LIST TO ARRAY:C288("XS_EventosUsuario";$at_tiposEvento_nombre;$al_tiposEventos_Id)
	
	  // contabilización del numero de ocurrencias de cada evento
	For ($i_modulos;1;Size of array:C274($at_modulos))  // para cada módulo
		For ($i_eventos;1;Size of array:C274($al_tiposEventos_Id))  // para cada tipo de evento
			
			USE SET:C118("EventosDelPeriodo")
			  // busco los eventos del tipo de evento actual para el usuario actual en el módulo actual
			QUERY SELECTION:C341([xShell_UserEvents:282];[xShell_UserEvents:282]Module:4;=;$at_modulos{$i_modulos};*)
			QUERY SELECTION:C341([xShell_UserEvents:282]; & ;[xShell_UserEvents:282]Event:6;=;$al_tiposEventos_Id{$i_eventos})
			$l_total:=Records in selection:C76([xShell_UserEvents:282])
			DISTINCT VALUES:C339([xShell_UserEvents:282]UserID:1;$al_UsuariosUnicos)
			$l_UsuariosUnicos:=Size of array:C274($al_UsuariosUnicos)
			
			  // creo los items en los arreglos que serán enviados a la Intranet
			If ($l_total>0)
				APPEND TO ARRAY:C911($at_modulosEventos;$at_modulos{$i_modulos})
				APPEND TO ARRAY:C911($al_IdEvento;$al_tiposEventos_Id{$i_eventos})
				APPEND TO ARRAY:C911($al_TotalEventos;$l_total)
				APPEND TO ARRAY:C911($al_UsuariosUnicosPorEvento;$l_UsuariosUnicos)
			End if 
		End for 
	End for 
	
	  // si hay eventos registrados en la fecha los envío a la Intranet
	If (Size of array:C274($at_modulosEventos)>0)
		BLOB_Variables2Blob (->$x_blob;0;->$l_TipoPeriodo;->$t_NombrePeriodo;->$al_IdEvento;->$at_modulosEventos;->$al_TotalEventos;->$al_UsuariosUnicosPorEvento)
		$t_rolBD:=<>gRolBD
		$t_codigoPais:=<>gCountryCode
		$t_uuidInstitucion:=<>gUUID
		
		WEB SERVICE SET PARAMETER:C777("rolBD";$t_rolBD)
		WEB SERVICE SET PARAMETER:C777("codigoPais";$t_codigoPais)
		WEB SERVICE SET PARAMETER:C777("uuid";$t_uuidInstitucion)
		WEB SERVICE SET PARAMETER:C777("xData";$x_Blob)
		
		$t_errorWS:=WS_CallIntranetWebService ("WSstat_Periodos_in")
		If ($t_errorWS="")
			WEB SERVICE GET RESULT:C779(vt_ErrorWebService;"error";*)
			If (vt_ErrorWebService="")
				LOG_RegisterEvt ("Estadísticas consolidadas de uso de SchoolTrack para el período anual "+$t_NombrePeriodo+" enviadas ("+String:C10($d_fecha)+").")
			Else 
				LOG_RegisterEvt ("No fue posible enviar las estadísticas de uso de SchoolTrack a causa de un error: "+vt_ErrorWebService)
			End if 
		Else 
			LOG_RegisterEvt ("No fue posible enviar las estadísticas de uso de SchoolTrack a causa de un error: "+$t_errorWS)
		End if 
	End if 
End if 



