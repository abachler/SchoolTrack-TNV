C_POINTER:C301($colPtr)
Case of 
	: (Form event:C388=On Data Change:K2:15)
		ab_NivelModificado{aiADT_NivNo}:=True:C214
		
		LISTBOX GET CELL POSITION:C971(lb_CamposAlumno;$col;$row;$colPtr)
		
		If ($col=2)  //revisar los campos que son grupales para que al marcar uno se marquen todos automáticamente
			SN3_EditaAlumno{$row}:=SN3_PublicaAlumno{$row}
			If (SN3_FieldGroupsAlumno{$row}#"")
				ARRAY LONGINT:C221($DA_return;0)
				SN3_FieldGroupsAlumno{0}:=SN3_FieldGroupsAlumno{$row}
				AT_SearchArray (->SN3_FieldGroupsAlumno;"=";->$DA_return)
				For ($x;1;Size of array:C274($DA_return))
					SN3_PublicaAlumno{$DA_return{$x}}:=SN3_PublicaAlumno{$row}
					SN3_EditaAlumno{$DA_return{$x}}:=SN3_PublicaAlumno{$row}
				End for 
			End if 
		End if 
		
		ab_NivelModificado{aiADT_NivNo}:=True:C214
		$msg:=ST_Boolean2Str (SN3_PublicaAlumno{$row};"Activada";"Desactivada")+", solicitud del dato "+SN3_ListaCamposAlumno{$row}+" de alumnos, para el nivel "+at_IDNivel{aiADT_NivNo}
		LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
		
End case 