//%attributes = {}
  //ACTdteRec_ObtienePDF
  //obtiene PDF de facturas recibidas
C_TEXT:C284($vt_tipo)
C_TEXT:C284($t_rutEmisor;$t_rutReceptor;$t_tipoArchivo)
C_REAL:C285($r_folio)
C_TEXT:C284($t_ruta)
C_TIME:C306($refDoc)
C_TEXT:C284($t_retorno;$0)

$vt_tipo:="pdf"  //o xml
  //  //$vt_tipo:="xml"  //o pdf
  //$t_rutEmisor:=Replace string(ST_FormatoRUT("970040005");".";"")  //BCH
  //$t_rutReceptor:=Replace string(ST_FormatoRUT("969288109");".";"")
  //$t_tipoArchivo:="33"
  //$r_folio:=14801988

$t_rutEmisor:=$1
$t_rutReceptor:=$2
$t_tipoArchivo:=$3
$r_folio:=$4
$t_ruta:=$5

$t_rutEmisor:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rutEmisor)
$t_rutReceptor:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rutReceptor)

vlWS_estado:=WSactdte_ObtieneDTE ($t_rutEmisor;Num:C11($t_tipoArchivo);$r_folio;$vt_tipo;False:C215;"RECEPCION";$t_rutReceptor)
If (vlWS_estado=1)
	
	C_TEXT:C284($vt_blob)
	$vt_blob:=Convert to text:C1012(vxWS_pdf;"latin1")
	BASE64 DECODE:C896($vt_blob;vxWS_pdf)
	
	$vt_blob:=Convert to text:C1012(vxWS_pdf;"latin1")
	BASE64 DECODE:C896($vt_blob;vxWS_pdf)
	
	  //crea archivo
	ok:=1
	If (SYS_TestPathName (SYS_GetParentNme ($t_ruta))<0)
		SYS_CreateFolder (SYS_GetParentNme ($t_ruta))
	End if 
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	If (SYS_TestPathName ($t_ruta)=1)
		DELETE DOCUMENT:C159($t_ruta)
	End if 
	If (ok=1)
		$refDoc:=Create document:C266($t_ruta;"TEXT")
	End if 
	EM_ErrorManager ("Clear")
	
	If (ok=1)
		CLOSE DOCUMENT:C267($refDoc)
		BLOB TO DOCUMENT:C526(document;vxWS_pdf)
		  //APPEND TO ARRAY($y_error->;1)
	Else 
		  //APPEND TO ARRAY($y_error->;-2)  //documento no creado
	End if 
	SET BLOB SIZE:C606(vxWS_pdf;0)
Else 
	  //APPEND TO ARRAY($y_error->;-1)  //ws retorna error
End if 
