//%attributes = {"executedOnServer":true}
  // XScdoc_EnviaMetodosProyecto()
  // Por: Alberto Bachler: 05/04/13, 12:25:34
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_DATE:C307($d_fechaModificacion)
C_LONGINT:C283($l_error;$i;$l_IdAplicacion)
C_TIME:C306($h_horaModificacion)
C_TEXT:C284($t_textoError;$t_tipoObjeto)

ARRAY LONGINT:C221($al_IdMetodos;0)
ARRAY TEXT:C222($at_Modificaciones_Codigo;0)
ARRAY TEXT:C222($at_Modificaciones_DTS;0)
ARRAY TEXT:C222($at_Modificaciones_Metodos;0)
ARRAY TEXT:C222($at_NombresMetodos;0)


WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;300)

$t_tipoObjeto:="PM"
$l_IdAplicacion:=1  //1 es el ID de la aplicación SchoolTrack en Intranet.CentroDocumentacion
$l_IdProceso:=IT_Progress (1;0;0;"Buscando objetos modificados...")
4D_GetMethodList (->$at_NombresMetodos;->$al_IdMetodos)
ARRAY TEXT:C222($at_DTS_Modificacion;Size of array:C274($at_NombresMetodos))
For ($i;1;Size of array:C274($al_IdMetodos))
	$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/Size of array:C274($al_IdMetodos);"Buscando objetos modificados...\r"+$at_NombresMetodos{$i})
	$l_error:=API Get Resource Timestamp ("CC4D";$al_IdMetodos{$i};$d_fechaModificacion;$h_horaModificacion)
	$at_DTS_Modificacion{$i}:=DTS_MakeFromDateTime ($d_fechaModificacion;$h_horaModificacion)
End for 
$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
BLOB_Variables2Blob (->$x_blob;0;->$at_NombresMetodos;->$at_DTS_Modificacion)
COMPRESS BLOB:C534($x_blob;Compact compression mode:K22:12)

WEB SERVICE SET PARAMETER:C777("ID_aplicacion";$l_IdAplicacion)
WEB SERVICE SET PARAMETER:C777("Objetos";$x_blob)
WEB SERVICE SET PARAMETER:C777("tipoObjetos";$t_tipoObjeto)

$t_textoError:=WS_CallIntranetWebService ("WScdoc_RecibeObjetos")
If ($t_textoError="")
	WEB SERVICE GET RESULT:C779(vl_Error;"error";*)
	
End if 



