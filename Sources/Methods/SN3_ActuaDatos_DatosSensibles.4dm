//%attributes = {}
  //SN3_ActuaDatos_DatosSensibles
C_BOOLEAN:C305($0;$vb_datos_sensibles)
C_LONGINT:C283($1;$vl_id_apod)
C_POINTER:C301($2;$vp_array_id_alu)
C_TEXT:C284($vt_llave_per;$ref_rut;$ref_nombres;$ref_appat;$ref_apmat)
C_BLOB:C604($vx_blob)

ARRAY TEXT:C222($at_ref_field_temp;0)
ARRAY TEXT:C222($at_rev_new_value_temp;0)
ARRAY TEXT:C222($at_rev_new_value_temp_edit;0)
ARRAY BOOLEAN:C223($ab_confirm_fields_temp;0)

$vl_id_apod:=$1
$vp_array_id_alu:=$2

READ ONLY:C145([XShell_FatObjects:86])
UNLOAD RECORD:C212([XShell_FatObjects:86])

  //APODERADO
$ref_rut:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]RUT:6))
$ref_nombres:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Nombres:2))
$ref_appat:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Apellido_paterno:3))
$ref_apmat:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Apellido_materno:4))

$vt_llave_per:="SN3_ActuaDatos_Per_"+String:C10($vl_id_apod)
SET BLOB SIZE:C606($vx_blob;0)
$vx_blob:=KRL_GetBlobFieldData (->[XShell_FatObjects:86]FatObjectName:1;->$vt_llave_per;->[XShell_FatObjects:86]BlobObject:2)
BLOB_Blob2Vars (->$vx_blob;0;->$at_ref_field_temp;->$at_rev_new_value_temp;->$ab_confirm_fields_temp;->$at_rev_new_value_temp_edit)

For ($i;1;Size of array:C274($at_ref_field_temp))
	If (($at_ref_field_temp{$i}=$ref_rut) | ($at_ref_field_temp{$i}=$ref_nombres) | ($at_ref_field_temp{$i}=$ref_appat) | ($at_ref_field_temp{$i}=$ref_apmat))
		$vb_datos_sensibles:=True:C214
	End if 
End for 

$ref_rut:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]RUT:5))
$ref_nombres:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Nombres:2))
$ref_appat:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Apellido_paterno:3))
$ref_apmat:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Apellido_materno:4))

QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_ActuaDatos_Alu_"+String:C10($vl_id_apod)+"@")
SELECTION TO ARRAY:C260([XShell_FatObjects:86]RecordID:6;$vp_array_id_alu->)

For ($i;1;Size of array:C274($vp_array_id_alu->))
	ARRAY TEXT:C222($at_ref_field_temp;0)
	ARRAY TEXT:C222($at_rev_new_value_temp;0)
	ARRAY TEXT:C222($at_rev_new_value_temp_edit;0)
	ARRAY BOOLEAN:C223($ab_confirm_fields_temp;0)
	$vt_llave_alu:="SN3_ActuaDatos_Alu_"+String:C10($vl_id_apod)+"_"+String:C10($vp_array_id_alu->{$i})
	SET BLOB SIZE:C606($vx_blob;0)
	$vx_blob:=KRL_GetBlobFieldData (->[XShell_FatObjects:86]FatObjectName:1;->$vt_llave_per;->[XShell_FatObjects:86]BlobObject:2)
	BLOB_Blob2Vars (->$vx_blob;0;->$at_ref_field_temp;->$at_rev_new_value_temp;->$ab_confirm_fields_temp;->$at_rev_new_value_temp_edit)
	
	For ($x;1;Size of array:C274($at_ref_field_temp))
		If (($at_ref_field_temp{$x}=$ref_rut) | ($at_ref_field_temp{$x}=$ref_nombres) | ($at_ref_field_temp{$x}=$ref_appat) | ($at_ref_field_temp{$x}=$ref_apmat))
			$vb_datos_sensibles:=True:C214
		End if 
	End for 
End for 

$0:=$vb_datos_sensibles