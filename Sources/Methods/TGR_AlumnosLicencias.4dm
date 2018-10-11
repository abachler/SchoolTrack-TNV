//%attributes = {}
  //TGR_AlumnosLicencias

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If (Not:C34(<>vb_ImportHistoricos_STX))
	  //2017040416 ASM se estaba cargando el nivel de otra tabla 
	  //$id_alu:=Abs([Alumnos_Anotaciones]Alumno_Numero)  //MONO 184433  
	$id_alu:=Abs:C99([Alumnos_Licencias:73]Alumno_numero:1)
	$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_Licencias:73]ID:6:=SQ_SeqNumber (->[Alumnos_Licencias:73]ID:6)
			If ([Alumnos_Licencias:73]Año:9=0)
				[Alumnos_Licencias:73]Año:9:=<>gYear
			End if 
			
			If (([Alumnos_Licencias:73]Año:9=<>gYear) & ([Alumnos_Licencias:73]Nivel_Numero:10=$l_nivelAlu))  //MONO 184433
				[Alumnos_Licencias:73]Alumno_numero:1:=Abs:C99([Alumnos_Licencias:73]Alumno_numero:1)
			Else 
				[Alumnos_Licencias:73]Alumno_numero:1:=-Abs:C99([Alumnos_Licencias:73]Alumno_numero:1)
			End if 
			[Alumnos_Licencias:73]LlavePrimaria:11:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Licencias:73]Año:9)+"."+String:C10([Alumnos_Licencias:73]Nivel_Numero:10)+"."+String:C10(Abs:C99([Alumnos_Licencias:73]Alumno_numero:1))
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			If (([Alumnos_Licencias:73]Año:9=<>gYear) & ([Alumnos_Licencias:73]Nivel_Numero:10=$l_nivelAlu))  //MONO 184433
				[Alumnos_Licencias:73]Alumno_numero:1:=Abs:C99([Alumnos_Licencias:73]Alumno_numero:1)
			Else 
				[Alumnos_Licencias:73]Alumno_numero:1:=-Abs:C99([Alumnos_Licencias:73]Alumno_numero:1)
			End if 
			[Alumnos_Licencias:73]LlavePrimaria:11:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Licencias:73]Año:9)+"."+String:C10([Alumnos_Licencias:73]Nivel_Numero:10)+"."+String:C10(Abs:C99([Alumnos_Licencias:73]Alumno_numero:1))
			
	End case 
End if 