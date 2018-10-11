//%attributes = {}
  // WSget_SupportEvents()
  // Por: Alberto Bachler K.: 01-03-15, 11:27:26
  //  ---------------------------------------------
  // Código original: ABK, 12/05/2006, 10:12:45
  // Llama un web service en Schoolnet y obtiene la lista de incidentes del colegio
  // $1: rol de base de datos del colegio (&T)
  // $2: código de país (&T)
  // $3: username (&T)
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_BLOB:C604($0)

C_BLOB:C604($x_Blob)
C_TEXT:C284($t_codigoPais;$t_error;$t_nombreUsuario;$t_rolBD)

  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_errormsg;$t_json;$t_usuarioTicket;$t_asuntoTicket;$t_fechaTicket)
C_LONGINT:C283($httpStatus_l;$i;$l_numeroTicket;$otRef)
C_BOOLEAN:C305($b_errorResponse)
ARRAY OBJECT:C1221($ao_resultado;0)
ARRAY DATE:C224($adDate;0)
ARRAY TEXT:C222($atUserName;0)
ARRAY TEXT:C222($atAsunto;0)
ARRAY LONGINT:C221($alTicketNumber;0)

If (False:C215)
	C_TEXT:C284(Método;$1)
	C_TEXT:C284(Método;$2)
	C_TEXT:C284(Método;$3)
End if 

C_TEXT:C284(vtWS_ResultString)

$t_rolBD:=$1
$t_codigoPais:=$2
$t_nombreUsuario:=$3

  //MONO ticket 144984 -> Candidato para cambiar el blob a Objeto
$ob_request:=OB_Create 
OB_SET ($ob_request;->$t_rolBD;"rolbd")
OB_SET ($ob_request;->$t_codigoPais;"codpais")
OB_SET ($ob_request;->$t_nombreUsuario;"username")
$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
$httpStatus_l:=Intranet3_LlamadoWS ("WSout_SupportEventList";$t_jsonRequest;->$t_json)

If ($httpStatus_l=200)
	$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
	OB_GET ($ob_response;->$t_errormsg;"mensaje")
	OB_GET ($ob_response;->$b_errorResponse;"error")
	
	If (Not:C34($b_errorResponse))
		OB_GET ($ob_response;->$ao_resultado;"resultado")
		
		For ($i;1;Size of array:C274($ao_resultado))
			OB_GET ($ao_resultado{$i};->$t_fechaTicket;"Fecha")
			OB_GET ($ao_resultado{$i};->$t_usuarioTicket;"Usuario")
			OB_GET ($ao_resultado{$i};->$t_asuntoTicket;"Asunto")
			OB_GET ($ao_resultado{$i};->$l_numeroTicket;"Ticket")
			
			APPEND TO ARRAY:C911($adDate;Date:C102($t_fechaTicket))
			APPEND TO ARRAY:C911($atUserName;$t_usuarioTicket)
			APPEND TO ARRAY:C911($atAsunto;$t_asuntoTicket)
			APPEND TO ARRAY:C911($alTicketNumber;$l_numeroTicket)
		End for 
		
		$otRef:=OT New 
		OT PutArray ($otRef;"Fecha";$adDate)
		OT PutArray ($otRef;"Usuario";$atUserName)
		OT PutArray ($otRef;"Asunto";$atAsunto)
		OT PutArray ($otRef;"Ticket";$alTicketNumber)
		$x_Blob:=OT ObjectToNewBLOB ($otRef)
		  //COMPRESS BLOB($x_Blob)
		OT Clear ($otRef)
		  //BLOB_ExpandBlob_byPointer (->$x_Blob)
	End if 
End if 

$0:=$x_Blob