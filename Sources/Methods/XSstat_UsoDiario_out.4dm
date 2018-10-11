//%attributes = {}
  // XSstat_UsoDiario_out()
  // Por: Alberto Bachler: 24/04/13, 18:14:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_DATE:C307($1)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_forzarParaPruebas)
C_DATE:C307($d_fecha)
_O_C_INTEGER:C282($i_eventos;$i_modulos;$i_usuarios)
C_LONGINT:C283($i;$l_eventos;$l_total)
C_TEXT:C284($t_AñoMesDia;$t_codigoPais;$t_errorWS;$t_rolBD;$t_uuidInstitucion)

ARRAY LONGINT:C221($al_IdEvento;0)
ARRAY LONGINT:C221($al_NumeroEventos;0)
ARRAY LONGINT:C221($al_tiposEventos_Id;0)
ARRAY LONGINT:C221($al_UsuariosDistintos;0)
ARRAY TEXT:C222($at_modulos;0)
ARRAY TEXT:C222($at_modulosEventos;0)
ARRAY TEXT:C222($at_tiposEvento_nombre;0)
ARRAY TEXT:C222($at_Usuario;0)
If (False:C215)
	C_BOOLEAN:C305(XSstat_UsoDiario_out ;$0)
	C_DATE:C307(XSstat_UsoDiario_out ;$1)
End if 


C_TEXT:C284(vt_ErrorWebService)
C_BOOLEAN:C305(<>bXS_esServidorOficial)

$d_fecha:=$1

If (Count parameters:C259=2)
	  // solo se usa para pruebas
	  // fuerza la ejecución aunque la aplicación no sea el servidor oficial
	$b_forzarParaPruebas:=$2
End if 

If (((Application type:C494=4D Server:K5:6) & (<>bXS_esServidorOficial)) | ($b_forzarParaPruebas))
	
	$t_AñoMesDia:=Substring:C12(DTS_MakeFromDateTime ($d_fecha);1;8)+"@"
	
	  // obtengo un lista con los módulos actuales de la aplicación
	LIST TO ARRAY:C288("XS_Modules";$at_modulos)
	  // obtengo la lista de tipos de eventos usuarios que se registran actualmente en SchoolTrack
	LIST TO ARRAY:C288("XS_EventosUsuario";$at_tiposEvento_nombre;$al_tiposEventos_Id)
	
	  // busco los eventos registrados en la fecha...
	QUERY:C277([xShell_UserEvents:282];[xShell_UserEvents:282]DTS:3=$t_AñoMesDia)
	CREATE SET:C116([xShell_UserEvents:282];"EventosDelDia")
	  // y obtengo una lista de IDs usuarios únicos
	AT_DistinctsFieldValues (->[xShell_UserEvents:282]UserID:1;->$al_UsuariosDistintos)
	
	  // obtengo los nombres de los usuarios a partir de los Ids
	ARRAY TEXT:C222($at_nombresUsuarios;Size of array:C274($al_UsuariosDistintos))
	For ($i;1;Size of array:C274($al_UsuariosDistintos))
		$at_nombresUsuarios{$i}:=USR_GetUserName ($al_UsuariosDistintos{$i})
	End for 
	
	  // establezco que el resultado de la búsqueda sea enviado a un variable en lugar de crear una selección
	  // en esa variable se totalizará el numero de ocurrencias de evento, para cada usuario en cada módulo
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_eventos)
	
	  // contabilización del numero de ocurrencias de cada evento
	For ($i_modulos;1;Size of array:C274($at_modulos))  // para cada módulo
		For ($i_eventos;1;Size of array:C274($al_tiposEventos_Id))  // para cada tipo de evento
			$l_total:=0
			For ($i_usuarios;1;Size of array:C274($al_UsuariosDistintos))  // para cada usuario
				USE SET:C118("EventosDelDia")
				  // busco los eventos del tipo de evento actual para el usuario actual en el módulo actual
				QUERY SELECTION:C341([xShell_UserEvents:282];[xShell_UserEvents:282]Module:4;=;$at_modulos{$i_modulos};*)
				QUERY SELECTION:C341([xShell_UserEvents:282]; & ;[xShell_UserEvents:282]Event:6;=;$al_tiposEventos_Id{$i_eventos};*)
				QUERY SELECTION:C341([xShell_UserEvents:282]; & ;[xShell_UserEvents:282]UserID:1;=;$al_UsuariosDistintos{$i_usuarios})
				
				  // creo los items en los arreglos que serán enviados a la Intranet
				If ($l_eventos>0)
					$l_total:=$l_total+$l_eventos
					APPEND TO ARRAY:C911($at_modulosEventos;$at_modulos{$i_modulos})
					APPEND TO ARRAY:C911($al_IdEvento;$al_tiposEventos_Id{$i_eventos})
					APPEND TO ARRAY:C911($at_Usuario;$at_nombresUsuarios{$i_usuarios})
					APPEND TO ARRAY:C911($al_NumeroEventos;$l_eventos)
				End if 
			End for 
			
			  // creo un item en el arreglo con el usuario "Total", que totaliza todos los eventos del tipo actual en el módulo actual
			If ($l_total>0)
				APPEND TO ARRAY:C911($at_modulosEventos;$at_modulos{$i_modulos})
				APPEND TO ARRAY:C911($al_IdEvento;$al_tiposEventos_Id{$i_eventos})
				APPEND TO ARRAY:C911($at_Usuario;"Total")
				APPEND TO ARRAY:C911($al_NumeroEventos;$l_total)
			End if 
		End for 
	End for 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	  // si hay eventos registrados en la fecha los envío a la Intranet
	If (Size of array:C274($at_modulosEventos)>0)
		BLOB_Variables2Blob (->$x_blob;0;->$d_fecha;->$at_modulosEventos;->$al_IdEvento;->$at_Usuario;->$al_NumeroEventos)
		$t_rolBD:=<>gRolBD
		$t_codigoPais:=<>gCountryCode
		$t_uuidInstitucion:=<>gUUID
		
		WEB SERVICE SET PARAMETER:C777("rolBD";$t_rolBD)
		WEB SERVICE SET PARAMETER:C777("codigoPais";$t_codigoPais)
		WEB SERVICE SET PARAMETER:C777("uuid";$t_uuidInstitucion)
		WEB SERVICE SET PARAMETER:C777("xData";$x_Blob)
		
		$t_errorWS:=WS_CallIntranetWebService ("WSstat_RecibeEstadisticasUso")
		If ($t_errorWS="")
			WEB SERVICE GET RESULT:C779(vt_ErrorWebService;"error";*)
			If (vt_ErrorWebService="")
				LOG_RegisterEvt ("Estadísticas de uso de SchoolTrack enviadas ("+String:C10($d_fecha)+").")
			Else 
				LOG_RegisterEvt ("No fue posible enviar las estadísticas de uso de SchoolTrack a causa de un error: "+vt_ErrorWebService)
			End if 
		Else 
			LOG_RegisterEvt ("No fue posible enviar las estadísticas de uso de SchoolTrack a causa de un error: "+$t_errorWS)
		End if 
	End if 
End if 

$0:=($t_errorWS="")

