//%attributes = {}
  //SN3_ActuaDatos_LoadRev
C_TEXT:C284($fatObjectName)
C_LONGINT:C283(vl_id_apo_sel;vl_id_alu_sel;vl_back_color;$0;$1)
vl_id_apo_sel:=0
vl_id_alu_sel:=0

  //array temporales para ir cargando los utilizados en el listbox
ARRAY LONGINT:C221($al_id_per_temp;0)
ARRAY TEXT:C222($at_per_name_temp;0)
ARRAY LONGINT:C221($al_id_alu_temp;0)
ARRAY TEXT:C222($at_alu_name_temp;0)
ARRAY TEXT:C222($at_curso_temp;0)

  //array para control y despliegue en listbox
ARRAY LONGINT:C221(al_id_per;0)
ARRAY TEXT:C222(at_per_name;0)
ARRAY LONGINT:C221(al_id_alu;0)
ARRAY TEXT:C222(at_alu_name;0)

READ ONLY:C145([Personas:7])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([XShell_FatObjects:86])

QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_ActuaDatos_@")
CREATE SET:C116([XShell_FatObjects:86];"all_fatobj")
QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=7)

KRL_RelateSelection (->[Personas:7]No:1;->[XShell_FatObjects:86]RecordID:6;"")
  //$0:=Records in selection([Personas])  //para el on load del formulario de revisión asi sabemos si al cerrar el form hay menos gente que revisar

Case of 
	: ($1=1)
		ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
		SELECTION TO ARRAY:C260([Personas:7]No:1;$al_id_per_temp;[Personas:7]Apellidos_y_nombres:30;$at_per_name_temp)
	: (($1=2) | ($1=3))
		
		ARRAY LONGINT:C221($al_id_per_temp2;0)
		ARRAY TEXT:C222($at_per_name_temp2;0)
		SELECTION TO ARRAY:C260([Personas:7]No:1;$al_id_per_temp2;[Personas:7]Apellidos_y_nombres:30;$at_per_name_temp2)
		
		ARRAY LONGINT:C221($id_alu;0)
		ARRAY LONGINT:C221($id_alu_fo;0)
		ARRAY TEXT:C222($at_key;0)
		USE SET:C118("all_fatobj")
		QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=2)
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[XShell_FatObjects:86]RecordID:6;"")
		SELECTION TO ARRAY:C260([XShell_FatObjects:86]RecordID:6;$id_alu_fo;[XShell_FatObjects:86]FatObjectName:1;$at_key)
		
		If ($1=2)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		Else 
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		End if 
		
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$id_alu)
		
		For ($n;1;Size of array:C274($id_alu))
			$fia:=Find in array:C230($id_alu_fo;$id_alu{$n})
			$hasta:=Position:C15("_";$at_key{$fia};20)
			$id_apo:=Num:C11(Substring:C12($at_key{$fia};20;$hasta-20))
			
			If (Find in array:C230($al_id_per_temp;$id_apo)=-1)
				APPEND TO ARRAY:C911($al_id_per_temp;$id_apo)
				APPEND TO ARRAY:C911($at_per_name_temp;KRL_GetTextFieldData (->[Personas:7]No:1;->$id_apo;->[Personas:7]Apellidos_y_nombres:30))
			End if 
		End for 
		
		  //agregar al final a las relaciones sin alumnos
		For ($n;1;Size of array:C274($al_id_per_temp2))
			If ((Find in array:C230($al_id_per_temp;$al_id_per_temp2{$n}))=-1)
				APPEND TO ARRAY:C911($al_id_per_temp;$al_id_per_temp2{$n})
				APPEND TO ARRAY:C911($at_per_name_temp;$at_per_name_temp2{$n})
			End if 
		End for 
		
End case 

C_LONGINT:C283($i_personas;$i_alu)

For ($i_personas;1;Size of array:C274($al_id_per_temp))
	APPEND TO ARRAY:C911(al_id_per;$al_id_per_temp{$i_personas})
	APPEND TO ARRAY:C911(at_per_name;$at_per_name_temp{$i_personas})
	$fatObjectName:="SN3_ActuaDatos_Alu_"+String:C10($al_id_per_temp{$i_personas})+"_"  //MONO TICKET 182621
	USE SET:C118("all_fatobj")
	QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$fatObjectName+"@")
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[XShell_FatObjects:86]RecordID:6;"")
	Case of 
		: ($1=1)  //mayor a menor por nivel
			ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
		: ($1=2)  //mayor a menor por nivel
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		: ($1=3)  //menor a mayor por nivel
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	End case 
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_id_alu_temp;[Alumnos:2]apellidos_y_nombres:40;$at_alu_name_temp;[Alumnos:2]curso:20;$at_curso_temp)
	
	If (Size of array:C274($al_id_alu_temp)>0)  //para el despliegue jerarquico en el listbox, despues al dar actualizar se buscan a todos los alumnos en el array que estén la posición de este id_persona ya que serán sus alumnos.
		For ($i_alu;1;Size of array:C274($al_id_alu_temp))
			APPEND TO ARRAY:C911(al_id_alu;$al_id_alu_temp{$i_alu})
			APPEND TO ARRAY:C911(at_alu_name;$at_alu_name_temp{$i_alu}+" "+$at_curso_temp{$i_alu})
			If ($i_alu>1)
				APPEND TO ARRAY:C911(al_id_per;$al_id_per_temp{$i_personas})
				APPEND TO ARRAY:C911(at_per_name;$at_per_name_temp{$i_personas})
			End if 
		End for 
	Else 
		APPEND TO ARRAY:C911(al_id_alu;0)
		APPEND TO ARRAY:C911(at_alu_name;"")
	End if 
	
End for 

  //arrays de despliegue en listbox para campos
ARRAY TEXT:C222(at_rev_field_temp;0)
ARRAY TEXT:C222(at_ref_field_temp;0)
ARRAY TEXT:C222(at_rev_actual_value_temp;0)
ARRAY TEXT:C222(at_rev_new_value_temp;0)
ARRAY TEXT:C222(at_rev_new_value_edit_temp;0)
ARRAY BOOLEAN:C223(ab_confirm_fields_temp;0)
ARRAY LONGINT:C221(al_estilo;0)

If (Size of array:C274(al_id_per)>0)
	
	$fatObjectName:="SN3_ActuaDatos_Per_"+String:C10(al_id_per{1})
	If (Count parameters:C259=2)
		$2->:=$fatObjectName  //para dejar algo en el ultimo fatobject cargado
	End if 
	SN3_ActuaDatos_LoadTemp2Display ($fatObjectName;->at_ref_field_temp;->at_rev_new_value_temp;->at_rev_field_temp;->at_rev_actual_value_temp;->ab_confirm_fields_temp;->at_rev_new_value_edit_temp;->al_estilo)
	
	LISTBOX SELECT ROW:C912(lb_per_names;1;0)
	vl_id_apo_sel:=al_id_per{1}
	OBJECT SET TITLE:C194(*;"vt_seleccion";at_per_name{1}+__ (" y alumnos"))
	
End if 

$0:=Size of array:C274(al_id_per)  //ahora con este array definimos la gente inicial a revisar
CLEAR SET:C117("all_fatobj")