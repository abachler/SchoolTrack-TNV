//%attributes = {}
  //AL_RegistraCastigo

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("El registro de información conductual está bloqueado para el ciclo escolar actual a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
Else 
	If (USR_checkRights ("A";->[Alumnos_Conducta:8]))
		READ ONLY:C145([Alumnos:2])
		If (Size of array:C274(abrSelect)>0)
			If (vLocation="Browser")
				GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{1}})
			End if 
			  //PERIODOS_LoadData ([Alumnos]Nivel_Número)
		Else 
			  //PERIODOS_LoadData (0;-1)
		End if 
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		If (vLocation="Browser")
			$err:=AL_GetSelect (xALP_Browser;abrSelect)
		End if 
		
		
		
		WDW_OpenDialogInDrawer (->[Alumnos_Castigos:9];"MultiInput")
		  //If (ok=1)
		  //If ((Size of array(aBrSelect)>=1) & (vLocation="browser"))
		  //For ($i;1;Size of array(aBrSelect))
		  //READ ONLY([Alumnos])
		  //GOTO RECORD([Alumnos];alBWR_recordNumber{aBrSelect{$i}})
		  //If (([Alumnos]Status="Activo") | ([Alumnos]Status="Oyente") | ([Alumnos]Status="En Trámite"))
		  //QUERY([Alumnos_Inasistencias];[Alumnos_Inasistencias]Alumno_Numero=[Alumnos]Número;*)
		  //QUERY([Alumnos_Inasistencias]; & [Alumnos_Inasistencias]Fecha=dFrom)
		  //If (Records in selection([Alumnos_Inasistencias])=0)
		  //CREATE RECORD([Alumnos_Castigos])
		  //[Alumnos_Castigos]Fecha:=dFrom
		  //[Alumnos_Castigos]Alumno_Numero:=[Alumnos]Número
		  //[Alumnos_Castigos]Motivo:=sMotivo
		  //[Alumnos_Castigos]Horas_de_castigo:=iiHrs
		  //[Alumnos_Castigos]Profesor_Numero:=iProfID
		  //[Alumnos_Castigos]Observaciones:=tObs
		  //SAVE RECORD([Alumnos_Castigos])
		  //UNLOAD RECORD([Alumnos_Castigos])
		  //Else 
		  //CD_Dlog (0;[Alumnos]Apellidos_y_Nombres+" ya está registrado como inasistente en esta fecha.")
		  //End if 
		  //End if 
		  //End for 
		  //Else 
		  //If (([Alumnos]Status="Activo") | ([Alumnos]Status="Oyente") | ([Alumnos]Status="En Trámite"))
		  //QUERY([Alumnos_Inasistencias];[Alumnos_Inasistencias]Alumno_Numero=[Alumnos]Número;*)
		  //QUERY([Alumnos_Inasistencias]; & [Alumnos_Inasistencias]Fecha=dFrom)
		  //If (Records in selection([Alumnos_Inasistencias])=0)
		  //CREATE RECORD([Alumnos_Castigos])
		  //[Alumnos_Castigos]Fecha:=dFrom
		  //[Alumnos_Castigos]Alumno_Numero:=[Alumnos]Número
		  //[Alumnos_Castigos]Motivo:=sMotivo
		  //[Alumnos_Castigos]Horas_de_castigo:=iiHrs
		  //[Alumnos_Castigos]Profesor_Numero:=iProfID
		  //[Alumnos_Castigos]Observaciones:=tObs
		  //SAVE RECORD([Alumnos_Castigos])
		  //UNLOAD RECORD([Alumnos_Castigos])
		  //Else 
		  //CD_Dlog (0;[Alumnos]Apellidos_y_Nombres+" ya está registrado como inasistente en esta fecha.")
		  //End if 
		  //End if 
		  //End if 
		  //End if 
	Else 
		USR_ALERT_UserHasNoRights (2)
	End if 
	
End if 