//%attributes = {}
  // AL_CreaRegistros()
  // Por: Alberto Bachler K.: 14-05-14, 11:55:58
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


  // Alberto Bachler K.: 14-05-14, 11:56:06
  // Cambio la verificación de numero de nivel para evitar que se creen regiostros de sintesis anual de nivel 0
  // hasta ahora se verificaba ($l_numeroNivel>-1000) & ($l_numeroNivel>Nivel_AdmisionDirecta) & ($l_numeroNivel<Nivel_Egresados)
  // lo que permitia la creación de registros de síntesis anual de nivel 0
  // ---------------------------------------------

C_LONGINT:C283($l_IdAlumno;$l_numeroNivel;$l_proceso)
C_TEXT:C284($t_curso)



If (Trigger level:C398>0)
	$l_proceso:=New process:C317(Current method name:C684;128000;Current method name:C684;[Alumnos:2]numero:1)
Else 
	If (Count parameters:C259=1)
		$l_IdAlumno:=$1
		KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_IdAlumno)
	Else 
		$l_IdAlumno:=[Alumnos:2]numero:1
	End if 
	$t_curso:=[Alumnos:2]curso:20
	$l_numeroNivel:=[Alumnos:2]nivel_numero:29
	If (($l_numeroNivel#0) & ($l_numeroNivel>Nivel_AdmisionDirecta) & ($l_numeroNivel<Nivel_Egresados) & ($l_IdAlumno#0))
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		AL_CreaRegistrosSintesis ($l_IdAlumno;<>gYear;$l_numeroNivel)
		AL_CreaRegistroConducta ($l_IdAlumno)
		AL_CreaRegistroSalud ($l_IdAlumno)
		AL_CreaRegistroEvalPersonal ($l_IdAlumno)
	Else 
		  //20140611 ASM para crear el registro de ficha medica cuando el alumno se encuentra en admisión directa.
		  //If ($l_numeroNivel=Nivel_AdmisionDirecta)
		  // 20181008 ASM Ticket 214887 creo el registro de Salud (Al eliminar al alumno este registro se elimina también.)
		If (($l_numeroNivel=Nivel_AdmisionDirecta) | ($l_numeroNivel=Nivel_AdmissionTrack))
			AL_CreaRegistroSalud ($l_IdAlumno)
		End if 
	End if 
End if 
