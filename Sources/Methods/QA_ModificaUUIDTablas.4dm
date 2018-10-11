//%attributes = {}
  //QA_ModificaUUIDTablas

C_LONGINT:C283($l_tablas;$l_ultimaTabla;$l_campo;$l_proc2)
C_TEXT:C284($t_nombreTabla)
C_POINTER:C301($y_tabla;$y_field)
ARRAY TEXT:C222($at_campos;0)
ARRAY LONGINT:C221($l_refCampos;0)
C_BOOLEAN:C305($b_enUso;$0)

ARRAY POINTER:C280($ay_excepciones;0)

APPEND TO ARRAY:C911($ay_excepciones;->[Colegio:31]UUID:58)
APPEND TO ARRAY:C911($ay_excepciones;->[xShell_ApplicationData:45]UUID:31)

$l_proc2:=IT_Progress (1;0;0;"Cambiando uuids";0;"")
$l_ultimaTabla:=Get last table number:C254
For ($l_tablas;1;$l_ultimaTabla)
	If (Is table number valid:C999($l_tablas))
		$y_tabla:=Table:C252($l_tablas)
		$t_nombreTabla:=Table name:C256($l_tablas)
		IT_Progress (0;$l_proc2;$l_tablas/$l_ultimaTabla;"Cambiando uuids tabla "+$t_nombreTabla)
		
		ARRAY TEXT:C222($at_campos;0)
		ARRAY LONGINT:C221($l_refCampos;0)
		For ($i_campos;1;Get last field number:C255($l_tablas))
			APPEND TO ARRAY:C911($l_refCampos;$i_campos)
			APPEND TO ARRAY:C911($at_campos;"")
			$y_field:=Field:C253($l_tablas;$i_campos)
			If (Is field number valid:C1000($l_tablas;$i_campos))
				$at_campos{Size of array:C274($at_campos)}:=Field name:C257($l_tablas;$i_campos)
			End if 
		End for 
		
		$l_campo:=Find in array:C230($at_campos;"Auto_UUID")
		If ($l_campo=-1)
			$l_campo:=Find in array:C230($at_campos;"@UUID@")
		End if 
		If ($l_campo#-1)
			$y_field:=Field:C253($l_tablas;$l_campo)
			If (Find in array:C230($ay_excepciones;$y_tabla)=-1)
				
				READ WRITE:C146($y_tabla->)
				ALL RECORDS:C47($y_tabla->)
				ARRAY LONGINT:C221($al_RecNums;0)
				LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_RecNums;"")
				ARRAY TEXT:C222($at_uuid;0)
				For ($i_registros;1;Size of array:C274($al_RecNums))
					APPEND TO ARRAY:C911($at_uuid;Generate UUID:C1066)
				End for 
				
				ARRAY TO SELECTION:C261($at_uuid;$y_field->)
				
				If (Records in set:C195("LockedSet")>0)
					$l_tablas:=$l_ultimaTabla
					$b_enUso:=True:C214
				End if 
				
				KRL_UnloadReadOnly ($y_tabla)
				
			End if 
		End if 
	End if 
End for 
IT_Progress (-1;$l_proc2)

$0:=$b_enUso