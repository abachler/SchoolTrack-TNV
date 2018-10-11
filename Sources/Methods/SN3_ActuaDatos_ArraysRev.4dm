//%attributes = {}
  //SN3_ActuaDatos_ArraysRev

C_LONGINT:C283($i;$no_nivel;$fia;$pos;$num_table;$num_field)
C_POINTER:C301($ptr_field)

ARRAY LONGINT:C221($al_niveles_en_xml;0)
ARRAY LONGINT:C221($DA_Return;0)
ARRAY BOOLEAN:C223(ab_confirm_per_fields;0)
ARRAY BOOLEAN:C223(ab_confirm_alu_fields;0)

$vb_confirm:=True:C214  //para la confirmación de la modificación de los campos parte en verdadero

AT_SearchArray (->at_alu_tags_identidad;"=";->$DA_Return)
SN3_LoadDataReceptionSettings (0)

  //CREANDO ARREGLOS PARA LA INTERFAZ DE REVISIÓN MANUAL  Y AUTOMÁTICA.

  //Personas
C_LONGINT:C283($vl_id_per;$vl_id_alu)

ARRAY LONGINT:C221(al_id_per;0)
ARRAY LONGINT:C221(al_id_alu;0)

ARRAY TEXT:C222(at_per_rev_field;0)
ARRAY TEXT:C222(at_alu_rev_field;0)

ARRAY TEXT:C222(at_per_rev_actual_value;0)
ARRAY TEXT:C222(at_alu_rev_actual_value;0)

ARRAY TEXT:C222(at_per_rev_new_value;0)
ARRAY TEXT:C222(at_alu_rev_new_value;0)

READ ONLY:C145([Personas:7])

For ($x;1;Size of array:C274(at_per_tags_identidad))
	
	If ($x=1)
		$vl_id_per:=Num:C11(at_per_values_identidad{$x})
		QUERY:C277([Personas:7];[Personas:7]No:1=$vl_id_per)
		
		APPEND TO ARRAY:C911(at_per_rev_field;__ ("Apoderado"))
		APPEND TO ARRAY:C911(at_per_rev_actual_value;[Personas:7]Apellidos_y_nombres:30)
		APPEND TO ARRAY:C911(at_per_rev_new_value;"")
		APPEND TO ARRAY:C911(al_id_per;$vl_id_per)
		
	Else 
		
		$fia:=Find in array:C230(SN3_ListaTagsXMLRF;at_per_tags_identidad{$x})
		$pos:=Position:C15(".";SN3_ListaCamposRFRefField{$fia})
		$num_table:=Num:C11(Substring:C12(SN3_ListaCamposRFRefField{$fia};1;$pos-1))
		$num_field:=Num:C11(Substring:C12(SN3_ListaCamposRFRefField{$fia};$pos+1))
		$ptr_field:=Field:C253($num_table;$num_field)
		
		APPEND TO ARRAY:C911(at_per_rev_field;SN3_ListaCamposRF{$fia})
		APPEND TO ARRAY:C911(at_per_rev_actual_value;ST_Coerce_to_Text ($ptr_field))
		APPEND TO ARRAY:C911(at_per_rev_new_value;at_per_values_identidad{$x})
		APPEND TO ARRAY:C911(al_id_per;$vl_id_per)
	End if 
	
End for 


For ($x;2;Size of array:C274(at_per_tags_modificados))
	$fia:=Find in array:C230(SN3_ListaTagsXMLRF;at_per_tags_modificados{$x})
	$pos:=Position:C15(".";SN3_ListaCamposRFRefField{$fia})
	$num_table:=Num:C11(Substring:C12(SN3_ListaCamposRFRefField{$fia};1;$pos-1))
	$num_field:=Num:C11(Substring:C12(SN3_ListaCamposRFRefField{$fia};$pos+1))
	$ptr_field:=Field:C253($num_table;$num_field)
	
	APPEND TO ARRAY:C911(at_per_rev_field;SN3_ListaCamposRF{$fia})
	APPEND TO ARRAY:C911(at_per_rev_actual_value;ST_Coerce_to_Text ($ptr_field))
	APPEND TO ARRAY:C911(at_per_rev_new_value;at_per_values_modificados{$x})
	APPEND TO ARRAY:C911(al_id_per;$vl_id_per)
	
End for 


ARRAY BOOLEAN:C223(ab_confirm_per_fields;Size of array:C274(at_per_rev_field))
AT_Populate (->ab_confirm_per_fields;->$vb_confirm)
ARRAY TEXT:C222(at_color_per;0)
ARRAY TEXT:C222(at_color_per;Size of array:C274(at_per_rev_field))
$color:="00FFFFFF"
AT_Populate (->at_color_per;->$color)
ARRAY BOOLEAN:C223(ab_block_per;0)
ARRAY BOOLEAN:C223(ab_block_per;Size of array:C274(at_per_rev_field))


ARRAY LONGINT:C221($DA_Return;0)
at_per_rev_field{0}:=__ ("Apoderado")
AT_SearchArray (->at_per_rev_field;"=";->$DA_Return)
For ($i;1;Size of array:C274($DA_Return))
	at_color_per{$DA_Return{$i}}:="000000FF"
	ab_block_per{$DA_Return{$i}}:=True:C214
End for 

  //Alumnos
READ ONLY:C145([Alumnos:2])
ARRAY LONGINT:C221($DA_Return;0)
at_alu_tags_identidad{0}:="id"
AT_SearchArray (->at_alu_tags_identidad;"=";->$DA_return)

For ($i;1;Size of array:C274($DA_return))
	
	If (Size of array:C274($DA_Return)>=($i+1))  //Para cuando viene más de un alumno dentro del xml
		$tope:=$DA_return{$i+1}-1
	Else 
		$tope:=Size of array:C274(at_alu_tags_identidad)
	End if 
	
	For ($x;$DA_return{$i};$tope)
		
		If (at_alu_tags_identidad{$x}="id")
			$vl_id_alu:=Num:C11(at_alu_values_identidad{$x})
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$vl_id_alu)
			
			APPEND TO ARRAY:C911(at_alu_rev_field;__ ("Alumno"))
			APPEND TO ARRAY:C911(at_alu_rev_actual_value;[Alumnos:2]apellidos_y_nombres:40)
			APPEND TO ARRAY:C911(at_alu_rev_new_value;"")
			APPEND TO ARRAY:C911(al_id_alu;$vl_id_alu)
			
		Else 
			
			$fia:=Find in array:C230(SN3_ListaTagsXMLAlumno;at_alu_tags_identidad{$x})
			$pos:=Position:C15(".";SN3_ListaCamposAlumnoRefField{$fia})
			$num_table:=Num:C11(Substring:C12(SN3_ListaCamposAlumnoRefField{$fia};1;$pos-1))
			$num_field:=Num:C11(Substring:C12(SN3_ListaCamposAlumnoRefField{$fia};$pos+1))
			$ptr_field:=Field:C253($num_table;$num_field)
			
			APPEND TO ARRAY:C911(at_alu_rev_field;SN3_ListaCamposAlumno{$fia})
			APPEND TO ARRAY:C911(at_alu_rev_actual_value;ST_Coerce_to_Text ($ptr_field))
			APPEND TO ARRAY:C911(at_alu_rev_new_value;at_alu_values_identidad{$x})
			APPEND TO ARRAY:C911(al_id_alu;$vl_id_alu)
		End if 
		
	End for 
	
	$fia_1:=Find in array:C230(at_alu_values_modificados;String:C10($vl_id_alu))
	If ($fia_1>0)
		$fia_2:=Find in array:C230(at_alu_tags_modificados;"id";$fia_1+1)
	Else 
		$fia_2:=0
	End if 
	
	If ($fia_2>0)
		$ultimo_elemento:=$fia_2-1
	Else 
		$ultimo_elemento:=Size of array:C274(at_alu_tags_modificados)
	End if 
	
	For ($x;$fia_1+1;$ultimo_elemento)
		
		$fia:=Find in array:C230(SN3_ListaTagsXMLAlumno;at_alu_tags_modificados{$x})
		$pos:=Position:C15(".";SN3_ListaCamposAlumnoRefField{$fia})
		$num_table:=Num:C11(Substring:C12(SN3_ListaCamposAlumnoRefField{$fia};1;$pos-1))
		$num_field:=Num:C11(Substring:C12(SN3_ListaCamposAlumnoRefField{$fia};$pos+1))
		$ptr_field:=Field:C253($num_table;$num_field)
		
		APPEND TO ARRAY:C911(at_alu_rev_field;SN3_ListaCamposAlumno{$fia})
		APPEND TO ARRAY:C911(at_alu_rev_actual_value;ST_Coerce_to_Text ($ptr_field))
		APPEND TO ARRAY:C911(at_alu_rev_new_value;at_alu_values_modificados{$x})
		APPEND TO ARRAY:C911(al_id_alu;$vl_id_alu)
	End for 
	
End for 

ARRAY BOOLEAN:C223(ab_confirm_alu_fields;Size of array:C274(at_alu_rev_field))
AT_Populate (->ab_confirm_alu_fields;->$vb_confirm)
vb_revisar:=False:C215


ARRAY BOOLEAN:C223(ab_block_alu;0)
ARRAY BOOLEAN:C223(ab_block_alu;Size of array:C274(at_alu_rev_field))

ARRAY TEXT:C222(at_color_alu;0)
ARRAY TEXT:C222(at_color_alu;Size of array:C274(at_alu_rev_field))
$color:="00FFFFFF"
AT_Populate (->at_color_alu;->$color)

ARRAY LONGINT:C221($DA_Return;0)
at_alu_rev_field{0}:=__ ("Alumno")
AT_SearchArray (->at_alu_rev_field;"=";->$DA_Return)
For ($i;1;Size of array:C274($DA_Return))
	at_color_alu{$DA_Return{$i}}:="0x00FFFF00"
	ab_block_alu{$DA_Return{$i}}:=True:C214
End for 


If (SN3_ActuaDatosReqVerif=1)  //ahora es al revés
	  //si no requiere verificación pero vienen los tags de nombres - apellidos - identificador nacional hay que verificar esos datos y los demas que vienen tienen que actualizarse 
	
	If (Size of array:C274(at_per_tags_identidad)>1)
		vb_revisar:=True:C214
	End if 
	
	ARRAY LONGINT:C221($DA_Return;0)
	at_alu_tags_identidad{0}:="id"
	AT_SearchArray (->at_alu_tags_identidad;"#";->$DA_return)
	
	If (Size of array:C274($DA_return)>0)
		vb_revisar:=True:C214
	End if 
	
End if 
