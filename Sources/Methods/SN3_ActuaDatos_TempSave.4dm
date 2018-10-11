//%attributes = {}
  //SN3_ActuaDatos_TempSave
  //MONO aqui guardaremos en la tabla [XShell_FatObjects] lo que vamos leyendo de los xml descargados desde SN3

C_LONGINT:C283($i;$no_nivel;$fia;$pos;$num_table;$num_field;$recNUM)
C_POINTER:C301($ptr_field)
C_TEXT:C284($fatObjectName)
C_BOOLEAN:C305($vb_confirm)
$vb_confirm:=True:C214

ARRAY LONGINT:C221($DA_Return;0)

  //Personas
C_LONGINT:C283($vl_id_per;$vl_id_alu)

ARRAY LONGINT:C221(al_id_per;0)
ARRAY TEXT:C222(at_per_ref_field;0)  //referencia del campo
ARRAY TEXT:C222(at_per_rev_new_value;0)  // nuevo valor ingresado en sn3
ARRAY TEXT:C222(at_per_rev_new_value_edit;0)  //este arreglo se mostrará en la confirmación de campos por si necesitamos editar algo de lo que viene en sn3 y así no perdemos lo original de la recepción para mostrarlo en el log
ARRAY BOOLEAN:C223(ab_confirm_per_fields;0)  // confirmación de actualización


For ($x;1;Size of array:C274(at_per_tags_identidad))
	
	If ($x=1)
		$vl_id_per:=Num:C11(at_per_values_identidad{$x})
	Else 
		
		$fia:=Find in array:C230(SN3_ListaTagsXMLRF;at_per_tags_identidad{$x})
		If ($fia>0)
			APPEND TO ARRAY:C911(at_per_ref_field;SN3_ListaCamposRFRefField{$fia})
			APPEND TO ARRAY:C911(at_per_rev_new_value;at_per_values_identidad{$x})
			APPEND TO ARRAY:C911(al_id_per;$vl_id_per)
		End if 
	End if 
	
End for 


For ($x;2;Size of array:C274(at_per_tags_modificados))
	$fia:=Find in array:C230(SN3_ListaTagsXMLRF;at_per_tags_modificados{$x})
	If ($fia>0)
		APPEND TO ARRAY:C911(at_per_ref_field;SN3_ListaCamposRFRefField{$fia})
		APPEND TO ARRAY:C911(at_per_rev_new_value;at_per_values_modificados{$x})
	End if 
End for 

$fatObjectName:="SN3_ActuaDatos_Per_"+String:C10($vl_id_per)
$recNUM:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$fatObjectName)

READ WRITE:C146([XShell_FatObjects:86])

If ($recNUM>=0)
	ARRAY TEXT:C222($at_per_ref_field;0)
	ARRAY TEXT:C222($at_per_rev_new_value;0)
	ARRAY TEXT:C222($at_per_rev_new_value_edit;0)
	ARRAY BOOLEAN:C223($ab_confirm_per_fields;0)
	
	GOTO RECORD:C242([XShell_FatObjects:86];$recNUM)
	BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_per_ref_field;->$at_per_rev_new_value;->$ab_confirm_per_fields;->$at_per_rev_new_value_edit)
	
	For ($i;1;Size of array:C274(at_per_ref_field))
		$fia:=Find in array:C230($at_per_ref_field;at_per_ref_field{$i})
		
		If ($fia>0)
			$at_per_rev_new_value{$fia}:=at_per_rev_new_value{$i}
			$at_per_rev_new_value_edit{$fia}:=at_per_rev_new_value{$i}
		Else 
			APPEND TO ARRAY:C911($at_per_ref_field;at_per_ref_field{$i})
			APPEND TO ARRAY:C911($at_per_rev_new_value;at_per_rev_new_value{$i})
			APPEND TO ARRAY:C911($ab_confirm_per_fields;True:C214)
			APPEND TO ARRAY:C911($at_per_rev_new_value_edit;at_per_rev_new_value{$i})
		End if 
		
	End for 
	BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->$at_per_ref_field;->$at_per_rev_new_value;->$ab_confirm_per_fields;->$at_per_rev_new_value_edit)
	SAVE RECORD:C53([XShell_FatObjects:86])
Else 
	
	ARRAY BOOLEAN:C223(ab_confirm_per_fields;Size of array:C274(at_per_ref_field))
	AT_Populate (->ab_confirm_per_fields;->$vb_confirm)
	COPY ARRAY:C226(at_per_rev_new_value;at_per_rev_new_value_edit)
	
	CREATE RECORD:C68([XShell_FatObjects:86])
	[XShell_FatObjects:86]FatObjectName:1:=$fatObjectName
	[XShell_FatObjects:86]RecordID:6:=$vl_id_per
	[XShell_FatObjects:86]TableNumber:5:=7
	BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->at_per_ref_field;->at_per_rev_new_value;->ab_confirm_per_fields;->at_per_rev_new_value_edit)
	SAVE RECORD:C53([XShell_FatObjects:86])
End if 
KRL_UnloadReadOnly (->[XShell_FatObjects:86])


  //Alumnos
ARRAY LONGINT:C221($DA_Return;0)
at_alu_tags_identidad{0}:="id"
AT_SearchArray (->at_alu_tags_identidad;"=";->$DA_return)

For ($i;1;Size of array:C274($DA_return))
	
	ARRAY LONGINT:C221(al_id_alu;0)
	ARRAY TEXT:C222(at_alu_ref_field;0)
	ARRAY TEXT:C222(at_alu_rev_new_value;0)
	ARRAY TEXT:C222(at_alu_rev_new_value_edit;0)
	ARRAY BOOLEAN:C223(ab_confirm_alu_fields;0)
	
	If (Size of array:C274($DA_Return)>=($i+1))  //Para cuando viene más de un alumno dentro del xml
		$tope:=$DA_return{$i+1}-1
	Else 
		$tope:=Size of array:C274(at_alu_tags_identidad)
	End if 
	
	For ($x;$DA_return{$i};$tope)
		
		If (at_alu_tags_identidad{$x}="id")
			$vl_id_alu:=Num:C11(at_alu_values_identidad{$x})
			
		Else 
			
			$fia:=Find in array:C230(SN3_ListaTagsXMLAlumno;at_alu_tags_identidad{$x})
			If ($fia>0)
				APPEND TO ARRAY:C911(at_alu_ref_field;SN3_ListaCamposAlumnoRefField{$fia})
				APPEND TO ARRAY:C911(at_alu_rev_new_value;at_alu_values_identidad{$x})
			End if 
		End if 
		
	End for 
	
	$fia_1:=Find in array:C230(at_alu_values_modificados;String:C10($vl_id_alu))
	If ($fia_1>0)
		$fia_2:=Find in array:C230(at_alu_tags_modificados;"id";$fia_1+1)
	Else 
		$fia_1:=1
		$fia_2:=0
	End if 
	
	If ($fia_2>0)
		$ultimo_elemento:=$fia_2-1
	Else 
		$ultimo_elemento:=Size of array:C274(at_alu_tags_modificados)
	End if 
	
	For ($x;$fia_1+1;$ultimo_elemento)
		
		$fia:=Find in array:C230(SN3_ListaTagsXMLAlumno;at_alu_tags_modificados{$x})
		If ($fia>0)
			APPEND TO ARRAY:C911(at_alu_ref_field;SN3_ListaCamposAlumnoRefField{$fia})
			APPEND TO ARRAY:C911(at_alu_rev_new_value;at_alu_values_modificados{$x})
		End if 
	End for 
	
	
	$fatObjectName:="SN3_ActuaDatos_Alu_"+String:C10($vl_id_per)+"_"+String:C10($vl_id_alu)  //id del apodreado que envió los datos y luego el id del alumno
	$recNUM:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$fatObjectName)
	
	READ WRITE:C146([XShell_FatObjects:86])
	If ($recNUM>=0)
		ARRAY TEXT:C222($at_alu_ref_field;0)
		ARRAY TEXT:C222($at_alu_rev_new_value;0)
		ARRAY TEXT:C222($at_alu_rev_new_value_edit;0)
		ARRAY BOOLEAN:C223($ab_confirm_alu_fields;0)
		
		GOTO RECORD:C242([XShell_FatObjects:86];$recNUM)
		BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_alu_ref_field;->$at_alu_rev_new_value;->$ab_confirm_alu_fields;->$at_alu_rev_new_value_edit)
		
		For ($n;1;Size of array:C274(at_alu_ref_field))
			$fia:=Find in array:C230($at_alu_ref_field;at_alu_ref_field{$n})
			
			  //MONO ACTUADATOS CORRECCION
			  // Hay que ver cuales son los datos que se agregan como por ejemplo las vacunas, en este caso son todos los que no pertencen a la tabla de alumnos.
			
			If (($fia>0) & (at_alu_ref_field{$n}="2.@"))
				$at_alu_rev_new_value{$fia}:=at_alu_rev_new_value{$n}
				$at_alu_rev_new_value_edit{$fia}:=at_alu_rev_new_value{$n}
			Else 
				APPEND TO ARRAY:C911($at_alu_ref_field;at_alu_ref_field{$n})
				APPEND TO ARRAY:C911($at_alu_rev_new_value;at_alu_rev_new_value{$n})
				APPEND TO ARRAY:C911($ab_confirm_alu_fields;True:C214)
				APPEND TO ARRAY:C911($at_alu_rev_new_value_edit;at_alu_rev_new_value{$n})
			End if 
			
		End for 
		
		BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->$at_alu_ref_field;->$at_alu_rev_new_value;->$ab_confirm_alu_fields;->$at_alu_rev_new_value_edit)
		SAVE RECORD:C53([XShell_FatObjects:86])
	Else 
		ARRAY BOOLEAN:C223(ab_confirm_alu_fields;Size of array:C274(at_alu_ref_field))
		AT_Populate (->ab_confirm_alu_fields;->$vb_confirm)
		COPY ARRAY:C226(at_alu_rev_new_value;at_alu_rev_new_value_edit)
		CREATE RECORD:C68([XShell_FatObjects:86])
		[XShell_FatObjects:86]FatObjectName:1:=$fatObjectName
		[XShell_FatObjects:86]RecordID:6:=$vl_id_alu
		[XShell_FatObjects:86]TableNumber:5:=2
		BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->at_alu_ref_field;->at_alu_rev_new_value;->ab_confirm_alu_fields;->at_alu_rev_new_value_edit)
		SAVE RECORD:C53([XShell_FatObjects:86])
	End if 
	KRL_UnloadReadOnly (->[XShell_FatObjects:86])
	
End for 
