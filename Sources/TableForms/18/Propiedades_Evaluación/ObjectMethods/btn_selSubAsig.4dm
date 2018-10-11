  //MONO Ticket 187315
C_LONGINT:C283($i;$id_asignatura)
C_TEXT:C284(vt_lastSelectedSA)
C_TEXT:C284($t_menu)
C_POINTER:C301($y_arrayLB)
C_OBJECT:C1216($o_obj)

ARRAY TEXT:C222($at_uuid;0)
ARRAY TEXT:C222($at_name;0)
ARRAY TEXT:C222($at_detalle;0)
ARRAY INTEGER:C220($al_periodo;0)
ARRAY INTEGER:C220($al_columna;0)
ARRAY TEXT:C222($at_obNodes;0)

READ ONLY:C145([xxSTR_Subasignaturas:83])
QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1)
ORDER BY:C49([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Columna:13;>;[xxSTR_Subasignaturas:83]Name:2;>;[xxSTR_Subasignaturas:83]Periodo:12;>)
SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83]Auto_UUID:20;$at_uuid;*)
SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83]Name:2;$at_name;*)
SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83]Periodo:12;$al_periodo;*)
SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83]Columna:13;$al_columna;*)
SELECTION TO ARRAY:C260

If (Size of array:C274($at_uuid)>0)
	OBJECT SET TITLE:C194(*;"t_selectorSubasig";__ ("Seleccione Subasignatura"))
	
	For ($i;1;Size of array:C274($at_uuid))
		$t_menu:=$t_menu+$at_name{$i}+", periodo "+String:C10($al_periodo{$i})+", columna "+String:C10($al_columna{$i})+";"
	End for 
	
	$l_optSel:=Pop up menu:C542($t_menu;0)
	
	If ($l_optSel>0)
		
		$y_arrayLB:=(OBJECT Get pointer:C1124(Object named:K67:5;"SA_nameDisplay"))
		
		If ((vt_lastSelectedSA#"") & (vt_lastSelectedSA#$at_uuid{$l_optSel}))
			READ WRITE:C146([xxSTR_Subasignaturas:83])
			QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Auto_UUID:20=vt_lastSelectedSA)
			$o_obj:=[xxSTR_Subasignaturas:83]o_Data:21
			OB_SET ($o_obj;$y_arrayLB;"aSubEvalNombreParciales")
			[xxSTR_Subasignaturas:83]o_Data:21:=$o_obj
			SAVE RECORD:C53([xxSTR_Subasignaturas:83])
			KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
		End if 
		vt_lastSelectedSA:=$at_uuid{$l_optSel}
		OBJECT SET TITLE:C194(*;"t_enc1_SA_Display";$at_name{$l_optSel}+", periodo "+String:C10($al_periodo{$l_optSel})+", columna "+String:C10($al_columna{$l_optSel}))
		READ ONLY:C145([xxSTR_Subasignaturas:83])
		QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Auto_UUID:20=$at_uuid{$l_optSel})
		OB_GetChildNodes ([xxSTR_Subasignaturas:83]o_Data:21;->$at_obNodes)
		If (Size of array:C274($at_obNodes)=0)
			ASsev_InitArrays 
			ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
			QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Auto_UUID:20=$at_uuid{$l_optSel})
		End if 
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->$at_detalle;"aSubEvalNombreParciales")
		COPY ARRAY:C226($at_detalle;$y_arrayLB->)
	End if 
	
Else 
	OBJECT SET TITLE:C194(*;"t_selectorSubasig";__ ("Sin configuración para subasignaturas"))
	
End if 
