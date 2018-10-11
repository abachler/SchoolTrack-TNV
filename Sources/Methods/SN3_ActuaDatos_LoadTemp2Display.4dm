//%attributes = {}
  //SN3_ActuaDatos_LoadTemp2Display
C_LONGINT:C283($rec_num;$0)
C_TEXT:C284($fatObjectName;$1)
C_POINTER:C301($2;$3;$4;$5;$6;$7;$8;$ptr_ref_fields;$ptr_new_value;$ptr_name_fields;$ptr_actual_value;$ptr_confirm;$ptr_array_config_ref;$ptr_array_config_name;$ptr_estilo;$ptr_new_value_edit)

$fatObjectName:=$1

$ptr_ref_fields:=$2
$ptr_new_value:=$3
$ptr_name_fields:=$4
$ptr_actual_value:=$5
$ptr_confirm:=$6
$ptr_new_value_edit:=$7

$vb_llenar_estilo:=False:C215

If (Count parameters:C259>7)
	  //$ptr_color:=$7
	  //$vb_llenar_color:=True
	$ptr_estilo:=$8
	$vb_llenar_estilo:=True:C214
End if 

READ ONLY:C145([XShell_FatObjects:86])
$rec_num:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$fatObjectName)
If ($rec_num>=0)
	GOTO RECORD:C242([XShell_FatObjects:86];$rec_num)
	BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;$ptr_ref_fields;$ptr_new_value;$ptr_confirm;$ptr_new_value_edit)
	
	Case of 
		: ([XShell_FatObjects:86]TableNumber:5=2)
			
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([Alumnos_FichaMedica:13])
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[XShell_FatObjects:86]RecordID:6)
			QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=[Alumnos:2]numero:1)
			  //arrays de la configuración general de SN3_InitDataReceptionSettings
			$ptr_array_config_ref:=->SN3_ListaCamposAlumnoRefField
			$ptr_array_config_name:=->SN3_ListaCamposAlumno
			
		: ([XShell_FatObjects:86]TableNumber:5=7)
			
			READ ONLY:C145([Personas:7])
			QUERY:C277([Personas:7];[Personas:7]No:1=[XShell_FatObjects:86]RecordID:6)
			  //arrays de la configuración general de SN3_InitDataReceptionSettings
			$ptr_array_config_ref:=->SN3_ListaCamposRFRefField
			$ptr_array_config_name:=->SN3_ListaCamposRF
			
	End case 
	
	For ($x;1;Size of array:C274($ptr_ref_fields->))
		
		$fia:=Find in array:C230($ptr_array_config_ref->;$ptr_ref_fields->{$x})
		
		APPEND TO ARRAY:C911($ptr_name_fields->;$ptr_array_config_name->{$fia})
		
		$pos:=Position:C15(".";$ptr_ref_fields->{$x})
		$num_table:=Num:C11(Substring:C12($ptr_ref_fields->{$x};1;$pos-1))
		
		  //MONO: ACTUA DATOS FATOBJECTS: Por ahora mostraremos vacío por que lo que llega de SN3 es 
		If (Table:C252(->[XShell_FatObjects:86])=$num_table)
			APPEND TO ARRAY:C911($ptr_actual_value->;"")
		Else 
			$num_field:=Num:C11(Substring:C12($ptr_ref_fields->{$x};$pos+1))
			$ptr_field:=Field:C253($num_table;$num_field)
			APPEND TO ARRAY:C911($ptr_actual_value->;ST_Coerce_to_Text ($ptr_field;False:C215))
		End if 
		
		
		
	End for 
	
End if 

  //If ($vb_llenar_color)
  //For ($i;1;Size of array($ptr_actual_value->))
  //
  //If ($ptr_actual_value->{$i}=$ptr_new_value->{$i})
  //APPEND TO ARRAY($ptr_color->;0x00FFFFFF)
  //Else 
  //APPEND TO ARRAY($ptr_color->;0x0092CEFB)
  //End if 
  //
  //End for 
  //End if 

If ($vb_llenar_estilo)
	For ($i;1;Size of array:C274($ptr_actual_value->))
		
		If ($ptr_actual_value->{$i}=$ptr_new_value->{$i})
			APPEND TO ARRAY:C911($ptr_estilo->;0)
		Else 
			APPEND TO ARRAY:C911($ptr_estilo->;1)
		End if 
		
	End for 
End if 

UNLOAD RECORD:C212([XShell_FatObjects:86])
UNLOAD RECORD:C212([Alumnos:2])
UNLOAD RECORD:C212([Personas:7])

$0:=$rec_num
