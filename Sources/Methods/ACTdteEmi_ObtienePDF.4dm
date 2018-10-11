//%attributes = {}
  //ACTdteEmi_ObtienePDF
  //obtiene PDF de facturas recibidas
C_TEXT:C284($t_tipo)
C_TEXT:C284($t_rutEmisor;$t_tipoArchivo)
C_REAL:C285($r_folio)
C_TEXT:C284($t_rutaCompleta)
C_TIME:C306($refDoc)
C_LONGINT:C283($l_retorno;$0)
C_BOOLEAN:C305($vb_cedible)
C_BLOB:C604($x_blob)

$t_tipo:="pdf"  //o xml

$t_rutEmisor:=$1
$t_tipoArchivo:=$2
$r_folio:=$3
$vb_cedible:=$4
$t_rutaCompleta:=$5
If (Count parameters:C259>=6)
	If ($6#"")
		$t_tipo:=$6
	End if 
End if 

$t_rutEmisor:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rutEmisor)

  //vlWS_estado:=WSactdte_ObtieneDTE ($t_rutEmisor;Num($t_tipoArchivo);$r_folio;$vt_tipo;False;"RECEPCION";$t_rutReceptor)
WSact_ObtieneDTE ($t_rutEmisor;Num:C11($t_tipoArchivo);$r_folio;$t_tipo;$vb_cedible;"EMISION")
If (vlWS_estado=1)
	Case of 
		: ($t_tipo="pdf")
			C_TEXT:C284($vt_blob)
			$vt_blob:=Convert to text:C1012(vxWS_pdf;"latin1")
			BASE64 DECODE:C896($vt_blob;vxWS_pdf)
			
			$vt_blob:=Convert to text:C1012(vxWS_pdf;"latin1")
			BASE64 DECODE:C896($vt_blob;$x_blob)
			
		: ($t_tipo="xml")
			CONVERT FROM TEXT:C1011(vtWS_xml;"latin1";$x_blob)
			
	End case 
	
	  //crea archivo
	ok:=1
	If (SYS_TestPathName (SYS_GetParentNme ($t_rutaCompleta))<0)
		SYS_CreateFolder (SYS_GetParentNme ($t_rutaCompleta))
	End if 
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	If (SYS_TestPathName ($t_rutaCompleta)=1)
		DELETE DOCUMENT:C159($t_rutaCompleta)
	End if 
	If (ok=1)
		$refDoc:=Create document:C266($t_rutaCompleta;"TEXT")
	End if 
	EM_ErrorManager ("Clear")
	
	If (ok=1)
		CLOSE DOCUMENT:C267($refDoc)
		BLOB TO DOCUMENT:C526(document;$x_blob)
		  //APPEND TO ARRAY($y_error->;1)
	Else 
		  //APPEND TO ARRAY($y_error->;-2)  //documento no creado
	End if 
	SET BLOB SIZE:C606(vxWS_pdf;0)
	$l_retorno:=1
Else 
	  //APPEND TO ARRAY($y_error->;-1)  //ws retorna error
	CD_Dlog (0;"El documento no pudo ser generado: Error: "+vtWS_glosa+".")
	$l_retorno:=0
End if 

$0:=$l_retorno
