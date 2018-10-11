//%attributes = {}
C_LONGINT:C283($vl_error;$i;$vl_column;$vl_row;$vl_typ;$vl_size;$vl_ascii1;$vl_ascii0;$vl_asciikomma;$vl_barheight;$k;$vl_byte)
C_BLOB:C604($vx_blob)
C_TEXT:C284($vt_svg;$vt_ref;$vt_input)
C_PICTURE:C286($0;$vp_picture)

$vt_input:=$1
If (Count parameters:C259>=2)
	$vl_typ:=$2
Else 
	$vl_typ:=2
End if 
If (Count parameters:C259>=3)
	$vl_size:=$3
Else 
	$vl_size:=5
End if 

$vp_picture:=HMBC_GeneraCodigo ($vt_input;hmBC_PDF417)
$0:=$vp_picture