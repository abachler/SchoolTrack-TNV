//%attributes = {}
  //Metodo: WSget_SupportEventRecord
  //Por abachler
  //Creada el 12/05/2006, 10:02:38
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // $1: ID del incidente (&L)
  // $2: Nombre del usuario (&T)
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_TEXT:C284($vtTS_UserName;$2)
C_LONGINT:C283($ticketId;$1)
C_TEXT:C284(vtWS_ResultString)
C_BLOB:C604($vx_Blob)

  //MONO ticket 144984 -> candidato a pasar a objeto
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_errormsg;$t_json;$t_TS_content;$t_TS_Subject;$t_TS_To;$t_TS_from;$t_TS_FromAddr;$t_nombreArchivo)
C_TEXT:C284($t_tipoProblema;$t_fecha;$t_asunto;$t_detalles;$t_respuesta;$t_estado;$t_usuario;$t_TS_date)
C_LONGINT:C283($httpStatus_l;$otRef;$l_TS_Id;$l_TS_Time;$l_idArchivo)
C_BOOLEAN:C305($b_errorResponse)

ARRAY OBJECT:C1221($ao_comentarios;0)
ARRAY OBJECT:C1221($ao_archivos;0)

ARRAY DATE:C224($adHistoriaIncidenteTS_date;0)
ARRAY LONGINT:C221($alHistoriaIncidenteTS_Id;0)
ARRAY LONGINT:C221($alHistoriaIncidenteTS_Time;0)
ARRAY LONGINT:C221($alTS_AttachID;0)
ARRAY TEXT:C222($atHistoriaIncidenteTS_content;0)
ARRAY TEXT:C222($atHistoriaIncidenteTS_from;0)
ARRAY TEXT:C222($atHistoriaIncidenteTS_fromAddr;0)
ARRAY TEXT:C222($atHistoriaIncidenteTS_Subject;0)
ARRAY TEXT:C222($atHistoriaIncidenteTS_To;0)
ARRAY TEXT:C222($atTS_AttachDocName;0)
ARRAY LONGINT:C221($alTS_AttachID;0)
ARRAY TEXT:C222($atTS_AttachDocName;0)

$ticketId:=$1
$vtTS_UserName:=$2
error:=0

  //CUERPO
$ob_request:=OB_Create 
OB_SET ($ob_request;->$ticketId;"id")
$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
$httpStatus_l:=Intranet3_LlamadoWS ("WSout_SupportEventRecord";$t_jsonRequest;->$t_json)

If ($httpStatus_l=200)
	$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
	OB_GET ($ob_response;->vtWS_ResultString;"mensaje")
	OB_GET ($ob_response;->$b_errorResponse;"error")
	
	If (Not:C34($b_errorResponse))
		
		OB_GET ($ob_response;->$t_tipoProblema;"resultado.TipoProblema")
		OB_GET ($ob_response;->$t_fecha;"resultado.Fecha")
		OB_GET ($ob_response;->$t_asunto;"resultado.Asunto")
		OB_GET ($ob_response;->$t_detalles;"resultado.Detalles")
		OB_GET ($ob_response;->$t_respuesta;"resultado.Respuesta")
		OB_GET ($ob_response;->$t_estado;"resultado.Estado")
		OB_GET ($ob_response;->$t_usuario;"resultado.Usuario")
		OB_GET ($ob_response;->$ao_comentarios;"resultado.ComentariosyEnvios")
		OB_GET ($ob_response;->$ao_archivos;"resultado.Archivos")
		
		For ($i;1;Size of array:C274($ao_comentarios))  //Comentartios del ticket marcados como visibleas para el cliente
			
			OB_GET ($ao_comentarios{$i};->$l_TS_Id;"alHistoriaIncidenteTS_Id")
			OB_GET ($ao_comentarios{$i};->$t_TS_date;"adHistoriaIncidenteTS_date")
			OB_GET ($ao_comentarios{$i};->$l_TS_Time;"alHistoriaIncidenteTS_Time")
			OB_GET ($ao_comentarios{$i};->$t_TS_content;"atHistoriaIncidenteTS_content")
			OB_GET ($ao_comentarios{$i};->$t_TS_Subject;"atHistoriaIncidenteTS_Subject")
			OB_GET ($ao_comentarios{$i};->$t_TS_To;"atHistoriaIncidenteTS_To")
			OB_GET ($ao_comentarios{$i};->$t_TS_from;"atHistoriaIncidenteTS_from")
			OB_GET ($ao_comentarios{$i};->$t_TS_FromAddr;"atHistoriaIncidenteTS_FromAddr")
			
			APPEND TO ARRAY:C911($alHistoriaIncidenteTS_Id;$l_TS_Id)
			APPEND TO ARRAY:C911($adHistoriaIncidenteTS_date;Date:C102($t_TS_date))
			APPEND TO ARRAY:C911($alHistoriaIncidenteTS_Time;$l_TS_Time)
			APPEND TO ARRAY:C911($atHistoriaIncidenteTS_content;$t_TS_content)
			APPEND TO ARRAY:C911($atHistoriaIncidenteTS_Subject;$t_TS_Subject)
			APPEND TO ARRAY:C911($atHistoriaIncidenteTS_To;$t_TS_To)
			APPEND TO ARRAY:C911($atHistoriaIncidenteTS_from;$t_TS_from)
			APPEND TO ARRAY:C911($atHistoriaIncidenteTS_FromAddr;$t_TS_FromAddr)
			
		End for 
		
		For ($i;1;Size of array:C274($ao_archivos))
			OB_GET ($ao_archivos{$i};->$l_idArchivo;"idarchivo")
			OB_GET ($ao_archivos{$i};->$t_nombreArchivo;"nombre")
			APPEND TO ARRAY:C911($alTS_AttachID;$l_idArchivo)
			APPEND TO ARRAY:C911($atTS_AttachDocName;$t_nombreArchivo)
		End for 
		
		$otRef:=OT New 
		OT PutText ($otRef;"TipoProblema";$t_tipoProblema)
		OT PutDate ($otRef;"Fecha";Date:C102($t_fecha))
		OT PutText ($otRef;"Asunto";$t_asunto)
		OT PutText ($otRef;"Detalles";$t_detalles)
		OT PutText ($otRef;"Respuesta";$t_respuesta)
		OT PutText ($otRef;"Estado";$t_estado)
		OT PutText ($otRef;"Usuario";$t_usuario)
		
		OT PutArray ($otRef;"Historia_Id";$alHistoriaIncidenteTS_Id)
		OT PutArray ($otRef;"Historia_from";$atHistoriaIncidenteTS_from)
		OT PutArray ($otRef;"Historia_FromAddr";$atHistoriaIncidenteTS_FromAddr)
		OT PutArray ($otRef;"Historia_to";$atHistoriaIncidenteTS_To)
		OT PutArray ($otRef;"Historia_date";$adHistoriaIncidenteTS_date)
		OT PutArray ($otRef;"Historia_time";$alHistoriaIncidenteTS_Time)
		OT PutArray ($otRef;"Historia_subject";$atHistoriaIncidenteTS_Subject)
		OT PutArray ($otRef;"Historia_reply";$atHistoriaIncidenteTS_content)
		
		OT PutArray ($otRef;"Adjuntos_ID";$alTS_AttachID)
		OT PutArray ($otRef;"Adjuntos_NombreArchivo";$atTS_AttachDocName)
		
		$vx_Blob:=OT ObjectToNewBLOB ($otRef)
		OT Clear ($otRef)
	End if 
	
End if 

$0:=$vx_Blob
