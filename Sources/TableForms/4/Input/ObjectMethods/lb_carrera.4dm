Case of 
	: ((Form event:C388=On Clicked:K2:4) & (USR_checkRights ("M";->[Profesores:4])))
		_O_ENABLE BUTTON:C192(bEliminarCarrera)
		If (LB_GetSelectedRows (->lb_Carrera)>0)
			_O_ENABLE BUTTON:C192(bEliminarCarrera)
		Else 
			at_CarreraProfesor_Puesto:=0
			ad_CarreraProfesor_Fecha:=0
			_O_DISABLE BUTTON:C193(bEliminarCarrera)
		End if 
		
	: (Form event:C388=On Double Clicked:K2:5)
		If (at_CarreraProfesor_Puesto#0)
			_O_QUERY SUBRECORDS:C108([Profesores:4]Carrera:16;([Profesores]Carrera'Fecha=ad_CarreraProfesor_Fecha{ad_CarreraProfesor_Fecha}) & ([Profesores]Carrera'Cargo=at_CarreraProfesor_Puesto{at_CarreraProfesor_Puesto}))
			WDW_Open (505;363;1;8;"Carrera";"WDW_CLOSEDLOG")
			_O_MODIFY SUBRECORD:C203([Profesores:4]Carrera:16;"Input";*)
			CLOSE WINDOW:C154
			If (ok=1)
				ARRAY TEXT:C222(at_CarreraProfesor_Puesto;0)
				ARRAY DATE:C224(ad_CarreraProfesor_Fecha;0)
				_O_ALL SUBRECORDS:C109([Profesores:4]Carrera:16)
				SF_Subtable2Array (->[Profesores:4]Carrera:16;->[Profesores]Carrera'Cargo;->at_CarreraProfesor_Puesto;->[Profesores]Carrera'Fecha;->ad_CarreraProfesor_Fecha)
			End if 
			ad_CarreraProfesor_Fecha:=0
			at_CarreraProfesor_Puesto:=0
		Else 
			If (USR_checkRights ("M";->[Profesores:4]))
				WDW_Open (505;363;1;8;"Carrera";"WDW_CLOSEDLOG")
				  //WDW_OpenFormWindow (->[Profesores]Carrera;"Input";1;8)
				_O_ADD SUBRECORD:C202([Profesores:4]Carrera:16;"Input";*)
				CLOSE WINDOW:C154
				ARRAY TEXT:C222(at_CarreraProfesor_Puesto;0)
				ARRAY DATE:C224(ad_CarreraProfesor_Fecha;0)
				_O_ALL SUBRECORDS:C109([Profesores:4]Carrera:16)
				SF_Subtable2Array (->[Profesores:4]Carrera:16;->[Profesores]Carrera'Cargo;->at_CarreraProfesor_Puesto;->[Profesores]Carrera'Fecha;->ad_CarreraProfesor_Fecha)
			Else 
				USR_ALERT_UserHasNoRights (0)
			End if 
		End if 
		SORT ARRAY:C229(ad_CarreraProfesor_Fecha;at_CarreraProfesor_Puesto;<)
End case 