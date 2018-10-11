//%attributes = {}
C_BOOLEAN:C305($0;$vb_datos_sensibles)
C_LONGINT:C283($1;$vl_id_apod)
C_POINTER:C301($2;$vp_array_id_alu)
C_BLOB:C604($vx_blob)

ARRAY TEXT:C222($at_ref_field_temp;0)
ARRAY TEXT:C222($at_rev_new_value_temp;0)
ARRAY TEXT:C222($at_rev_new_value_temp_edit;0)
ARRAY BOOLEAN:C223($ab_confirm_fields_temp;0)

$vl_id_apod:=$1
$vp_array_id_alu:=$2

READ ONLY:C145([XShell_FatObjects:86])
UNLOAD RECORD:C212([XShell_FatObjects:86])

$vt_llave_per:="SN3_ActuaDatos_Per_"+String:C10($vl_id_apod)
SET BLOB SIZE:C606($vx_blob;0)
$vx_blob:=KRL_GetBlobFieldData (->[XShell_FatObjects:86]FatObjectName:1;->$vt_llave_per;->[XShell_FatObjects:86]BlobObject:2)
BLOB_Blob2Vars (->$vx_blob;0;->$at_ref_field_temp;->$at_rev_new_value_temp;->$ab_confirm_fields_temp;->$at_rev_new_value_temp_edit)

If (Size of array:C274($at_ref_field_temp)>0)
	$vb_datos_sensibles:=True:C214
End if 

QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_ActuaDatos_Alu_"+String:C10($vl_id_apod)+"@")
SELECTION TO ARRAY:C260([XShell_FatObjects:86]RecordID:6;$vp_array_id_alu->)

For ($i;1;Size of array:C274($vp_array_id_alu->))
	ARRAY TEXT:C222($at_ref_field_temp;0)
	ARRAY TEXT:C222($at_rev_new_value_temp;0)
	ARRAY TEXT:C222($at_rev_new_value_temp_edit;0)
	ARRAY BOOLEAN:C223($ab_confirm_fields_temp;0)
	
	$vt_llave_alu:="SN3_ActuaDatos_Alu_"+String:C10($vl_id_apod)+"_"+String:C10($vp_array_id_alu->{$i})
	SET BLOB SIZE:C606($vx_blob;0)
	$vx_blob:=KRL_GetBlobFieldData (->[XShell_FatObjects:86]FatObjectName:1;->$vt_llave_alu;->[XShell_FatObjects:86]BlobObject:2)
	BLOB_Blob2Vars (->$vx_blob;0;->$at_ref_field_temp;->$at_rev_new_value_temp;->$ab_confirm_fields_temp;->$at_rev_new_value_temp_edit)
	
	If (Size of array:C274($at_ref_field_temp)>0)
		$vb_datos_sensibles:=True:C214
	End if 
	
End for 

$0:=$vb_datos_sensibles