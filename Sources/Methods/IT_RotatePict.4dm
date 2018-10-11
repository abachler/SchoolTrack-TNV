//%attributes = {}
  //IT_RotatePict

C_PICTURE:C286($1;$vp_pict;$0;$vp_pict2)
C_LONGINT:C283($DrawID;$count;$vObjectID;$vl_grados)

$vp_pict:=$1
If (Count parameters:C259=2)
	$vl_grados:=$2
Else 
	$vl_grados:=90
End if 

If (Application version:C493>="11@")
	
	vb_Modificado_4Dv11:=True:C214
	vb_Pendiente_4Dv11:=True:C214
	
	  //ALERT("Implementar rotación de imagenes en V11...")
Else 
	
	  //$DrawID:=‘14000;11‘ 
	  //‘14000;8‘ ($DrawID;$vp_pict)
	  //$count:=‘14000;73‘ ($DrawID;-1)
	  //$vObjectID:=‘14000;42‘ ($DrawID;-1;$count)
	  //‘14000;77‘ ($DrawID;$vObjectID;$vl_grados;0)
	  //$vp_pict2:=‘14000;10‘ ($DrawID;$vObjectID)
	  //‘14000;12‘ ($DrawID)
	  //$0:=$vp_pict2
End if 