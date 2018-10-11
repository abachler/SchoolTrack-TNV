C_LONGINT:C283($col;$line;$l_rn)
LISTBOX GET CELL POSITION:C971(LB_AluIdioma;$col;$line)

If ($line>0)
	
	READ WRITE:C146([DIAP_AlumnosIdiomas:218])
	$l_rn:=Find in field:C653([DIAP_AlumnosIdiomas:218]Auto_UUID:1;a_LB_Aidioma_UUID{$line})
	If ($l_rn>=0)
		GOTO RECORD:C242([DIAP_AlumnosIdiomas:218];$l_rn)
		DELETE RECORD:C58([DIAP_AlumnosIdiomas:218])
		
		DELETE FROM ARRAY:C228(a_LB_Aidioma_UUID;$line)
		DELETE FROM ARRAY:C228(a_LB_Aidioma_orden;$line)
		DELETE FROM ARRAY:C228(a_LB_Aidioma_Codigo;$line)
		DELETE FROM ARRAY:C228(a_LB_Aidioma_DesAleman;$line)
		DELETE FROM ARRAY:C228(a_LB_Aidioma_DesEspañol;$line)
		DELETE FROM ARRAY:C228(a_LB_Aidioma_NivelDesde;$line)
		DELETE FROM ARRAY:C228(a_LB_Aidioma_NivelHasta;$line)
		
		
		For ($i;$line;Size of array:C274(a_LB_Aidioma_UUID))
			a_LB_Aidioma_orden{$i}:=$i
			$l_rn:=Find in field:C653([DIAP_AlumnosIdiomas:218]Auto_UUID:1;a_LB_Aidioma_UUID{$i})
			If ($l_rn>=0)
				GOTO RECORD:C242([DIAP_AlumnosIdiomas:218];$l_rn)
				[DIAP_AlumnosIdiomas:218]Orden:8:=$i
				SAVE RECORD:C53([DIAP_AlumnosIdiomas:218])
			End if 
		End for 
		
	End if 
	
	KRL_UnloadReadOnly (->[DIAP_AlumnosIdiomas:218])
	
End if 

OBJECT SET ENABLED:C1123(*;"bDesinscribeIdioma";(Size of array:C274(a_LB_Aidioma_UUID)>0))