//%attributes = {}
  //ACTqry_Items

C_TEXT:C284($vt_accion;$1)
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 
Case of 
	: ($vt_accion="NoEspeciales")
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-10;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-1;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-101;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-103;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-102;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-127;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-128;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-128;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-129;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-130;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-131;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-132;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-133;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-134;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-135)
		
	: ($vt_accion="CargosNoRelativosNoEspeciales")
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsDescuento:6=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]EsRelativo:5=False:C215;*)
		ACTqry_Items ("NoEspeciales")
		
	: ($vt_accion="CargosNoRelativosNoEspecialesNoIntereses")
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsDescuento:6=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]EsRelativo:5=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#-100;*)
		ACTqry_Items ("NoEspeciales")
		
	: ($vt_accion="CargosNoEspeciales")
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1#0;*)
		ACTqry_Items ("NoEspeciales")
		QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]VentaRapida:3=False:C215)
		
	: ($vt_accion="CargosNoRelativosNoEspecialesNoInteresesVD")
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsDescuento:6=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]EsRelativo:5=False:C215;*)
		ACTqry_Items ("NoEspeciales")
		QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]VentaRapida:3=True:C214)
		
End case 
ORDER BY:C49([xxACT_Items:179];[xxACT_Items:179]Glosa:2;>)
If (Count parameters:C259>1)
	Case of 
		: (Count parameters:C259=3)
			SELECTION TO ARRAY:C260($ptr1->;$ptr2->)
		: (Count parameters:C259=5)
			SELECTION TO ARRAY:C260($ptr1->;$ptr2->;$ptr3->;$ptr4->)
	End case 
	REDUCE SELECTION:C351([xxACT_Items:179];0)
End if 