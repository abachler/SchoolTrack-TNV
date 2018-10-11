C_LONGINT:C283($r)
If (USR_checkRights ("D";->[Profesores:4]))
	If (Self:C308->)
		$mess:=""
		$go:=1
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
		If (Records in selection:C76([Cursos:3])#0)
			$mess:=[Profesores:4]Apellidos_y_nombres:28+" es profesor jefe de "+[Cursos:3]Curso:1
			$messDlog:="Si inactiva a "+[Profesores:4]Apellidos_y_nombres:28+" deberá reasignar el profesor jefe a "+[Cursos:3]Curso:1
		End if 
		QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
		SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$aSubject;[Asignaturas:18]Curso:5;$aClass)
		$mess2:=""
		For ($i;1;Size of array:C274($aSubject))
			$mess2:=$mess2+$aSubject{$i}+", "+$aClass{$i}+"\r"
		End for 
		If ($mess2#"")
			If ($mess#"")
				$mess:=$mess+"\r"+" y profesor de las siguientes asignaturas: "+"\r"+$mess2
				$messDlog:="Si inactiva a "+[Profesores:4]Apellidos_y_nombres:28+" deberá reasignar el profesor jefe a "+[Cursos:3]Curso:1+" y los profesores de asignatura en: "+"\r"+$mess2
			Else 
				$mess:="Es profesor de las siguientes asignaturas: "+"\r"+$mess2
				$messDlog:="Si inactiva a "+[Profesores:4]Apellidos_y_nombres:28+" deberá reasignar los profesores de asignatura en: "+"\r"+$mess2
			End if 
		End if 
		QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=[Profesores:4]Numero:1)
		If (Records in selection:C76([Alumnos:2])>0)
			$mess:=[Profesores:4]Apellidos_y_nombres:28+" es tutor de  "+String:C10(Records in selection:C76([Alumnos:2]))+" alumnos."
			$messDlog:="Si inactiva a "+[Profesores:4]Apellidos_y_nombres:28+" deberá reasignar tutor a "+String:C10(Records in selection:C76([Alumnos:2]))+" alumnos."
		End if 
		If ($mess#"")
			$r:=CD_Dlog (1;$messDlog+__ ("\r¿Desea realmente inactivar este profesor?");__ ("");__ ("No");__ ("Inactivar"))
			If ($r=2)
				ARRAY TEXT:C222(aText1;0)
				ARRAY LONGINT:C221(aLong1;0)
				START TRANSACTION:C239
				READ WRITE:C146([Asignaturas:18])
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
				AT_Initialize (->aText1;->aLong1)
				AT_DimArrays (Records in selection:C76([Asignaturas:18]);->aText1;->aLong1)
				OK:=KRL_Array2Selection (->aText1;->[Asignaturas:18]profesor_nombre:13;->aLong1;->[Asignaturas:18]profesor_numero:4)
				UNLOAD RECORD:C212([Asignaturas:18])
				READ ONLY:C145([Asignaturas:18])
				If (ok=1)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33=[Profesores:4]Numero:1)
					AT_Initialize (->aText1;->aLong1)
					AT_DimArrays (Records in selection:C76([Asignaturas:18]);->aText1;->aLong1)
					OK:=KRL_Array2Selection (->aText1;->[Asignaturas:18]profesor_firmante_Nombre:34;->aLong1;->[Asignaturas:18]profesor_firmante_numero:33)
					UNLOAD RECORD:C212([Asignaturas:18])
					READ ONLY:C145([Asignaturas:18])
				End if 
				If (ok=1)
					READ WRITE:C146([Cursos:3])
					QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
					If (Not:C34(Locked:C147([Cursos:3])))
						[Cursos:3]Numero_del_profesor_jefe:2:=0
						SAVE RECORD:C53([Cursos:3])
						UNLOAD RECORD:C212([Cursos:3])
						READ ONLY:C145([Cursos:3])
					Else 
						OK:=0
					End if 
				End if 
				If (ok=1)
					READ WRITE:C146([Alumnos:2])
					QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=[Profesores:4]Numero:1)
					AT_Initialize (->aText1;->aLong1)
					AT_DimArrays (Records in selection:C76([Alumnos:2]);->aText1;->aLong1)
					OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Tutor_Nombre:38;->aLong1;->[Alumnos:2]Tutor_numero:36)
					UNLOAD RECORD:C212([Alumnos:2])
					READ ONLY:C145([Alumnos:2])
				Else 
					ok:=0
				End if 
				If (ok=1)
					[Profesores:4]Inactivo:62:=True:C214
					LOG_RegisterEvt ("Cambio de estatus del Profesor "+[Profesores:4]Apellidos_y_nombres:28+" a Inactivo")
					SAVE RECORD:C53([Profesores:4])
					VALIDATE TRANSACTION:C240
				Else 
					[Profesores:4]Inactivo:62:=False:C215
					CANCEL TRANSACTION:C241
					$r:=CD_Dlog (0;__ ("El profesor no puede ser inactivado en este momento (uno o más registros de asignaturas o cursos están siendo utilizados por otros usuarios).\rPor favor intente nuevamente más tarde."))
				End if 
			Else 
				[Profesores:4]Inactivo:62:=False:C215
			End if 
		Else 
			$r:=CD_Dlog (0;__ ("¿Desea Ud. realmente inactivar el profesor ")+[Profesores:4]Apellidos_y_nombres:28+__ ("?");__ ("");__ ("No");__ ("Inactivar"))
			If ($r=2)
				LOG_RegisterEvt ("Cambio de estatus del Profesor "+[Profesores:4]Apellidos_y_nombres:28+" a Inactivo")
			Else 
				[Profesores:4]Inactivo:62:=False:C215
			End if 
		End if 
	End if 
Else 
	BEEP:C151
	USR_ALERT_UserHasNoRights (3)
End if 
