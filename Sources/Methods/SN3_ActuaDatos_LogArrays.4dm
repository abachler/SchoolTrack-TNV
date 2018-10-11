//%attributes = {}
  //SN3_ActuaDatos_LogArrays
ARRAY DATE:C224(ad_fecha;0)
ARRAY TEXT:C222(at_padres;0)
ARRAY TEXT:C222(at_encargado;0)

ARRAY LONGINT:C221(al_recnum_hide;0)  //no lo estoy usando ahora pero quizas sea bueno mantenerlo para un posible cambio
ARRAY LONGINT:C221(al_fontcolor_code;0)

ARRAY TEXT:C222(at_persona;0)
ARRAY TEXT:C222(at_campo;0)
ARRAY TEXT:C222(at_antes;0)
ARRAY TEXT:C222(at_sn3;0)
ARRAY TEXT:C222(at_final;0)

C_TEXT:C284($nombre_apo;$1;$modo;$4)
C_DATE:C307($vd_fecha1;$vd_fecha2;$2;$3)
$modo:="todo"

If (Count parameters:C259>0)
	$nombre_apo:=$1
End if 

If (Count parameters:C259>2)
	$vd_fecha1:=$2
	$vd_fecha2:=$3
End if 

If (Count parameters:C259>3)
	$modo:=$4
End if 

ARRAY LONGINT:C221($al_recnum_per;0)
ARRAY LONGINT:C221($al_recnum_alu;0)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])
READ ONLY:C145([XShell_FatObjects:86])
QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_Log_ActuaDatos_@")
CREATE SET:C116([XShell_FatObjects:86];"todo")
QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=2)
CREATE SET:C116([XShell_FatObjects:86];"alu")
USE SET:C118("todo")
QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=7)

If ($nombre_apo#"")
	ARRAY LONGINT:C221($al_id_per_filtro;0)
	QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30="@"+$nombre_apo+"@")
	SELECTION TO ARRAY:C260([Personas:7]No:1;$al_id_per_filtro)
	QRY_QueryWithArray (->[XShell_FatObjects:86]RecordID:6;->$al_id_per_filtro;True:C214)
End if 

If (($vd_fecha1#!00-00-00!) & ($vd_fecha2#!00-00-00!))
	QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]DateObject:7>=$vd_fecha1;*)
	QUERY SELECTION:C341([XShell_FatObjects:86]; & ;[XShell_FatObjects:86]DateObject:7<=$vd_fecha2)
End if 

If ($modo#"todo")
	QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]TextObject:3=$modo+"@")
End if 

ORDER BY:C49([XShell_FatObjects:86];[XShell_FatObjects:86]DateObject:7;<;[XShell_FatObjects:86]TextObject:3;<)
LONGINT ARRAY FROM SELECTION:C647([XShell_FatObjects:86];$al_recnum_per;"")

For ($i;1;Size of array:C274($al_recnum_per))
	
	ARRAY TEXT:C222($at_ref_fields;0)
	ARRAY TEXT:C222($at_new_value;0)
	ARRAY BOOLEAN:C223($ab_confirm;0)
	ARRAY TEXT:C222($at_new_value_edit;0)
	ARRAY TEXT:C222($at_original;0)
	
	ARRAY TEXT:C222($at_elements;0)
	GOTO RECORD:C242([XShell_FatObjects:86];$al_recnum_per{$i})
	AT_Text2Array (->$at_elements;[XShell_FatObjects:86]FatObjectName:1;"_")
	
	BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_ref_fields;->$at_new_value;->$ab_confirm;->$at_new_value_edit;->$at_original)
	$fecha_actuadatos:=[XShell_FatObjects:86]DateObject:7
	
	QUERY:C277([Personas:7];[Personas:7]No:1=[XShell_FatObjects:86]RecordID:6)
	
	APPEND TO ARRAY:C911(ad_fecha;$fecha_actuadatos)
	APPEND TO ARRAY:C911(at_padres;[Personas:7]Apellidos_y_nombres:30)
	APPEND TO ARRAY:C911(at_encargado;[XShell_FatObjects:86]TextObject:3)
	APPEND TO ARRAY:C911(al_recnum_hide;$al_recnum_per{$i})
	
	If (Size of array:C274($at_ref_fields)>0)
		For ($x;1;Size of array:C274($at_ref_fields))
			
			If ($x>1)
				APPEND TO ARRAY:C911(ad_fecha;$fecha_actuadatos)
				APPEND TO ARRAY:C911(at_padres;[Personas:7]Apellidos_y_nombres:30)
				APPEND TO ARRAY:C911(at_encargado;[XShell_FatObjects:86]TextObject:3)
				APPEND TO ARRAY:C911(al_recnum_hide;$al_recnum_per{$i})
			End if 
			
			APPEND TO ARRAY:C911(at_persona;[Personas:7]Apellidos_y_nombres:30)
			$fia:=Find in array:C230(SN3_ListaCamposRFRefField;$at_ref_fields{$x})
			APPEND TO ARRAY:C911(at_campo;SN3_ListaCamposRF{$fia})
			APPEND TO ARRAY:C911(at_antes;$at_original{$x})
			APPEND TO ARRAY:C911(at_sn3;$at_new_value{$x})
			APPEND TO ARRAY:C911(at_final;$at_new_value_edit{$x})
			
			If ($ab_confirm{$x})
				$font_color:=0x00047F20
			Else 
				$font_color:=0x00FF0808
			End if 
			APPEND TO ARRAY:C911(al_fontcolor_code;$font_color)
			
		End for 
		
	Else 
		APPEND TO ARRAY:C911(at_persona;[Personas:7]Apellidos_y_nombres:30)
		APPEND TO ARRAY:C911(at_campo;__ ("Confirmación de Datos"))
		APPEND TO ARRAY:C911(at_antes;"")
		APPEND TO ARRAY:C911(at_sn3;"")
		APPEND TO ARRAY:C911(at_final;"")
		APPEND TO ARRAY:C911(al_fontcolor_code;0x0000)
		
	End if 
	
	USE SET:C118("alu")
	QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_Log_ActuaDatos_Alu_"+String:C10([Personas:7]No:1)+"@")
	QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]DateObject:7=$fecha_actuadatos)
	QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="@"+$at_elements{Size of array:C274($at_elements)})
	
	
	CREATE SET:C116([XShell_FatObjects:86];"alu_2")
	ORDER BY:C49([XShell_FatObjects:86];[XShell_FatObjects:86]TextObject:3;<)
	LONGINT ARRAY FROM SELECTION:C647([XShell_FatObjects:86];$al_recnum_alu;"")
	DIFFERENCE:C122("alu";"alu_2";"alu")
	
	For ($n;1;Size of array:C274($al_recnum_alu))
		
		ARRAY TEXT:C222($at_ref_fields;0)
		ARRAY TEXT:C222($at_new_value;0)
		ARRAY BOOLEAN:C223($ab_confirm;0)
		ARRAY TEXT:C222($at_new_value_edit;0)
		ARRAY TEXT:C222($at_original;0)
		
		GOTO RECORD:C242([XShell_FatObjects:86];$al_recnum_alu{$n})
		BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_ref_fields;->$at_new_value;->$ab_confirm;->$at_new_value_edit;->$at_original)
		
		If (Size of array:C274($at_ref_fields)>0)
			For ($x;1;Size of array:C274($at_ref_fields))
				
				APPEND TO ARRAY:C911(ad_fecha;$fecha_actuadatos)
				APPEND TO ARRAY:C911(at_padres;[Personas:7]Apellidos_y_nombres:30)
				APPEND TO ARRAY:C911(at_encargado;[XShell_FatObjects:86]TextObject:3)
				APPEND TO ARRAY:C911(al_recnum_hide;$al_recnum_per{$i})
				
				APPEND TO ARRAY:C911(at_persona;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[XShell_FatObjects:86]RecordID:6;->[Alumnos:2]apellidos_y_nombres:40))
				$fia:=Find in array:C230(SN3_ListaCamposAlumnoRefField;$at_ref_fields{$x})
				APPEND TO ARRAY:C911(at_campo;SN3_ListaCamposAlumno{$fia})
				APPEND TO ARRAY:C911(at_antes;$at_original{$x})
				APPEND TO ARRAY:C911(at_sn3;$at_new_value{$x})
				APPEND TO ARRAY:C911(at_final;$at_new_value_edit{$x})
				If ($ab_confirm{$x})
					$font_color:=0x00047F20
				Else 
					$font_color:=0x00FF0808
				End if 
				APPEND TO ARRAY:C911(al_fontcolor_code;$font_color)
				
			End for 
			
		Else 
			APPEND TO ARRAY:C911(ad_fecha;$fecha_actuadatos)
			APPEND TO ARRAY:C911(at_padres;[Personas:7]Apellidos_y_nombres:30)
			APPEND TO ARRAY:C911(at_encargado;[XShell_FatObjects:86]TextObject:3)
			APPEND TO ARRAY:C911(al_recnum_hide;$al_recnum_per{$i})
			
			APPEND TO ARRAY:C911(at_persona;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[XShell_FatObjects:86]RecordID:6;->[Alumnos:2]apellidos_y_nombres:40))
			APPEND TO ARRAY:C911(at_campo;__ ("Confirmación de Datos"))
			APPEND TO ARRAY:C911(at_antes;"")
			APPEND TO ARRAY:C911(at_sn3;"")
			APPEND TO ARRAY:C911(at_final;"")
			APPEND TO ARRAY:C911(al_fontcolor_code;0x0000)
		End if 
		
	End for 
	
End for 

LISTBOX EXPAND:C1100(*;"LB_LOG";True:C214;lk all:K53:16)
SET_ClearSets ("alu";"alu_2";"todo")