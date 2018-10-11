//%attributes = {}
  // MÉTODO: TGR_Alumnos_EvaluacionesEspecia
  // ----------------------------------------------------
  // Usuario (OS): MONO
  // Fecha de creación: 12/09/16, 18:31:05
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // TGR_Alumnos_EvaluacionesEspecia()
  // ----------------------------------------------------

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
C_LONGINT:C283($i_periodo;$i_calificacion)
C_POINTER:C301($y_real;$y_literal;$y_nota;$y_simbolo;$y_puntos)

  // CODIGO PRINCIPAL
If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If (([Alumnos_EvaluacionesEspeciales:211]Año:3<<>gYear) | ([Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6#0))
				[Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5:=-Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5)
				[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4:=-Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4)  //MONO 160618 - ticket 197287
			End if 
			[Alumnos_EvaluacionesEspeciales:211]Llave_principal:8:=String:C10([Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Año:3)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Nivel_Numero:7)+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4))
			[Alumnos_EvaluacionesEspeciales:211]Llave_asignatura:10:=String:C10([Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Año:3)+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5))
			[Alumnos_EvaluacionesEspeciales:211]Llave_alumno:9:=String:C10([Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Año:3)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Nivel_Numero:7)+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4))
			
			If ([Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6#0)
				[Alumnos_EvaluacionesEspeciales:211]Llave_registrohistorico:11:=String:C10([Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Año:3)+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6))+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4))
			End if 
			
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Literal:12:=""
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Nota:14:=-10
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Puntos:15:=-10
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Real:13:=-10
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Simbolo:16:=""
			
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Literal:92:=""
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Nota:94:=-10
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Puntos:95:=-10
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Real:93:=-10
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Simbolo:96:=""
			
			For ($i_periodo;1;5)
				
				For ($i_calificacion;1;3)
					$y_real:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]P0"+String:C10($i_periodo)+"_Eval0"+String:C10($i_calificacion)+"_Real")
					$y_literal:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]P0"+String:C10($i_periodo)+"_Eval0"+String:C10($i_calificacion)+"_Literal")
					$y_nota:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]P0"+String:C10($i_periodo)+"_Eval0"+String:C10($i_calificacion)+"_Nota")
					$y_simbolo:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]P0"+String:C10($i_periodo)+"_Eval0"+String:C10($i_calificacion)+"_Simbolo")
					$y_puntos:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]P0"+String:C10($i_periodo)+"_Eval0"+String:C10($i_calificacion)+"_Puntos")
					
					$y_real->:=-10
					$y_literal->:=""
					$y_nota->:=-10
					$y_puntos->:=-10
					$y_simbolo->:=""
				End for 
				
			End for 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If (([Alumnos_EvaluacionesEspeciales:211]Año:3<<>gYear) | ([Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6#0))
				[Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5:=-Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5)
				[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4:=-Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4)  //MONO 160618 - ticket 197287
			End if 
			[Alumnos_EvaluacionesEspeciales:211]Llave_principal:8:=String:C10([Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Año:3)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Nivel_Numero:7)+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4))
			[Alumnos_EvaluacionesEspeciales:211]Llave_asignatura:10:=String:C10([Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Año:3)+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5))
			[Alumnos_EvaluacionesEspeciales:211]Llave_alumno:9:=String:C10([Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Año:3)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Nivel_Numero:7)+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4))
			
			If ([Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6#0)
				[Alumnos_EvaluacionesEspeciales:211]Llave_registrohistorico:11:=String:C10([Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2)+"."+String:C10([Alumnos_EvaluacionesEspeciales:211]Año:3)+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6))+"."+String:C10(Abs:C99([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4))
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
	
End if 