//%attributes = {}
  //hmBC_text2PictCode39

C_LONGINT:C283($vl_error;$i;$vl_size;$k;$vl_byte)
C_BLOB:C604($vx_blob)
C_TEXT:C284($vt_svg;$vt_ref;$vt_input)
C_PICTURE:C286($0;$vp_picture)
C_REAL:C285($vl_rotate)
C_LONGINT:C283($vl_x;$vl_y)
C_TEXT:C284($t_error)

$vt_input:=$1
If (Count parameters:C259>=2)
	$vl_size:=$2
Else 
	$vl_size:=3
End if 
If (Count parameters:C259>=3)
	$vl_rotate:=$3
Else 
	$vl_rotate:=0
End if 
If (Count parameters:C259>=4)
	$vl_x:=$4
Else 
	$vl_x:=0
End if 
If (Count parameters:C259>=5)
	$vl_y:=$4
Else 
	$vl_y:=0
End if 


  //$vl_error:=hmBC_Encode ($vl_typ;$vx_blob)
$vp_picture:=HMBC_GeneraCodigo ($vt_input;hmBC_Code 39)

  //para rotar
If ($vl_rotate#0)
	  //$vl_rotate:=90
	C_TEXT:C284($svg)
	$svg:=SVG_Open_picture ($vp_picture)
	If (($vl_x=0) & ($vl_y=0) & ($vl_rotate=90))
		$vl_x:=50
		$vl_y:=$vl_x
	End if 
	SVG_SET_TRANSFORM_ROTATE ($svg;$vl_rotate;$vl_x;$vl_y)
	$vp_picture:=SVG_Export_to_picture ($svg;1)
	SVG_CLEAR ($svg)
End if 


$0:=$vp_picture