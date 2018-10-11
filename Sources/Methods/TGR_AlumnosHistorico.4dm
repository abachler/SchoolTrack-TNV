//%attributes = {}
  // TGR_AlumnosHistorico()
  // Por: Alberto Bachler K.: 14-05-14, 11:50:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------


  // Alberto Bachler K.: 14-05-14, 11:50:28
  // creacion del registro de síntesis anual solo si el numero de nivel es distinto de 0
  // ---------------------------------------------


C_LONGINT:C283($l_recNumSintesis)
C_TEXT:C284($t_llaveRegistro)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_Historico:25]Llave:42:=String:C10([Alumnos_Historico:25]Alumno_Numero:1)+"."+String:C10([Alumnos_Historico:25]Año:2)
			[Alumnos_Historico:25]ID_SintesisAnual:44:=KRL_MakeStringAccesKey (-><>gInstitucion;->[Alumnos_Historico:25]Año:2;->[Alumnos_Historico:25]Nivel:11;->[Alumnos_Historico:25]Alumno_Numero:1)
			$t_llaveRegistro:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Historico:25]Año:2)+"."+String:C10([Alumnos_Historico:25]Nivel:11)+"."+String:C10([Alumnos_Historico:25]Alumno_Numero:1)
			$l_recNumSintesis:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveRegistro)
			If (($l_recNumSintesis<0) & ([Alumnos_Historico:25]Nivel:11#0) & ([Alumnos_Historico:25]Alumno_Numero:1#0))
				CREATE RECORD:C68([Alumnos_SintesisAnual:210])
				[Alumnos_SintesisAnual:210]ID_Institucion:1:=<>gInstitucion
				[Alumnos_SintesisAnual:210]Año:2:=[Alumnos_Historico:25]Año:2
				[Alumnos_SintesisAnual:210]ID_Alumno:4:=[Alumnos_Historico:25]Alumno_Numero:1
				[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=100
				[Alumnos_SintesisAnual:210]NumeroNivel:6:=[Alumnos_Historico:25]Nivel:11
				[Alumnos_SintesisAnual:210]Curso:7:=[Alumnos_Historico:25]Curso:3
				[Alumnos_SintesisAnual:210]ID_Curso:90:=[Alumnos_Historico:25]ID_Curso:34
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
				UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[Alumnos_Historico:25]Llave:42:=String:C10([Alumnos_Historico:25]Alumno_Numero:1)+"."+String:C10([Alumnos_Historico:25]Año:2)
			[Alumnos_Historico:25]ID_SintesisAnual:44:=KRL_MakeStringAccesKey (-><>gInstitucion;->[Alumnos_Historico:25]Año:2;->[Alumnos_Historico:25]Nivel:11;->[Alumnos_Historico:25]Alumno_Numero:1)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 