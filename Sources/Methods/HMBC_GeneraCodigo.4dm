//%attributes = {}
C_TEXT:C284($t_input;1)
C_BLOB:C604($x_blob;$x_blobOut)
C_LONGINT:C283($vl_ref;$vl_error)
C_LONGINT:C283($l_codigo;$2)
C_TEXT:C284($vt_path;$vt_path_posix;$t_error;0)
C_PICTURE:C286($0;$vp_picture)

$t_input:=$1
  //If (Not(Is compiled mode))
  //$t_input:="123456"
  //End if 
$l_codigo:=$2

CONVERT FROM TEXT:C1011($t_input;"UTF-8";$x_blob)

$vt_path_posix:=Temporary folder:C486+Generate UUID:C1066+".svg"
If (SYS_IsMacintosh )
	$vt_path_posix:=Convert path system to POSIX:C1106($vt_path_posix)
End if 

$vl_ref:=hmBC_New 
hmBC_SET SYMBOLOGY ($vl_ref;$l_codigo)
$vl_error:=hmBC_Encode ($vl_ref;$x_blob)
If ($vl_error=0)
	$vl_error:=hmBC_Render ($vl_ref;$vt_path_posix)
Else 
	$t_error:=hmBC_Get Last Error ($vl_ref)
End if 
hmBC_DELETE ($vl_ref)

If (SYS_IsMacintosh )
	$vt_path:=Convert path POSIX to system:C1107($vt_path_posix)
Else 
	$vt_path:=$vt_path_posix
End if 

If ($vl_error=0)
	READ PICTURE FILE:C678($vt_path;$vp_picture;*)
Else 
	$vp_picture:=SVG_Text2Pict ($t_error;50;200;"arial";12;0;3;"red";0)
End if 

If (Test path name:C476($vt_path)=Is a document:K24:1)
	DELETE DOCUMENT:C159($vt_path)
End if 

$0:=$vp_picture