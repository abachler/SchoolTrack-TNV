//%attributes = {}
  // WEBarea_MuestraDocumento_blob()
  // Por: Alberto Bachler: 17/09/13, 13:49:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BLOB:C604($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_POINTER:C301($y_nil)
C_BLOB:C604($x_blob)
C_LONGINT:C283($l_refVentana)
C_TIME:C306($h_refArchivo)
C_TEXT:C284($t_extension;$t_tituloVentana)

If (False:C215)
	C_TEXT:C284(WEBarea_MuestraDocumento_blob ;$2)
	C_TEXT:C284(WEBarea_MuestraDocumento_blob ;$3)
End if 

$x_blob:=$1
$t_extension:=$2

If (Count parameters:C259=3)
	$t_tituloVentana:=$3
End if 

  // expansión del blob si está comprimido
BLOB_ExpandBlob_byPointer (->$x_blob)
If (BLOB size:C605($x_blob)>0)
	If ($t_tituloVentana="")
		vt_URL:=Temporary folder:C486+Generate UUID:C1066+$t_extension
		$t_tituloVentana:="Documento PDF"
	Else 
		vt_URL:=Temporary folder:C486+$t_tituloVentana+$t_extension
	End if 
	
	If (Test path name:C476(vt_URL)=Is a document:K24:1)
		EM_ErrorManager ("install")
		EM_ErrorManager ("SetMode";"")
		DELETE DOCUMENT:C159(vt_URL)
		EM_ErrorManager ("")
	End if 
	
	$h_refArchivo:=Create document:C266(vt_URL)
	CLOSE DOCUMENT:C267($h_refArchivo)
	BLOB TO DOCUMENT:C526(vt_URL;$x_blob)
	
	$t_os:=SYS_GetOSName 
	Case of 
			
		: (($t_extension=".pdf") & (Macintosh option down:C545 | Windows Alt down:C563))
			OPEN URL:C673(vt_URL;*)
			
		: (($t_extension=".pdf") & ($t_os>="macOS 10.13@") & (Not:C34(4D_isLocal64bit )))
			OPEN URL:C673(vt_URL;*)
			
		Else 
			WEBarea_MuestraURL (vt_URL;$t_tituloVentana)
			EM_ErrorManager ("install")
			EM_ErrorManager ("SetMode";"")
			DELETE DOCUMENT:C159(vt_URL)
			EM_ErrorManager ("")
			
	End case 
	
End if 

