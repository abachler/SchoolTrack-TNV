  //If (lb_dgi<Size of array(lb_dgi))
C_LONGINT:C283($l_col;$l_line)
C_POINTER:C301($y_pointer)

LISTBOX GET CELL POSITION:C971(*;"lb_dgi";$l_col;$l_line;$y_pointer)
If ($l_line>0)
	$l_resp:=CD_Dlog (0;"¿Está seguro que desea eliminar el registro?";"";"Si";"No")
	
	GOTO SELECTED RECORD:C245([ACT_UY_InfoDGI:200];$l_line)
	
	If ($l_resp=1)
		LOG_RegisterEvt ("Eliminación de información DGI para apoderado "+[Personas:7]Apellidos_y_nombres:30+", para periodo "+[ACT_UY_InfoDGI:200]Periodo:4+".")
		DELETE RECORD:C58([ACT_UY_InfoDGI:200])
		
		ACTpp_OnRecordLoad (11)
		
	End if 
End if 