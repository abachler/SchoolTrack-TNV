//%attributes = {}
  //PF_Delete
C_TEXT:C284($vsUSR_UserName;$vsUSR_StartUpMethod;$vsUSR_Password;$vsUSR_GroupName)
C_LONGINT:C283($vlUSR_NbLogin;$vlUSR_GroupOwnerID)
C_DATE:C307($vdUSR_LastLogin)
ARRAY LONGINT:C221($alUSR_Membership;0)
ARRAY LONGINT:C221($al_idUrsGpo;0)

C_LONGINT:C283($r;$0)
If (USR_checkRights ("D";->[Profesores:4]))
	$mess:=""
	$go:=1
	READ WRITE:C146([xShell_Users:47])
	QUERY:C277([xShell_Users:47];[xShell_Users:47]NoEmployee:7=[Profesores:4]Numero:1)  //20111118 AS. para eliminar el  usuario ST, cuando se elimine el profesor.
	QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
	If (Records in selection:C76([Cursos:3])#0)
		$mess:=[Profesores:4]Apellidos_y_nombres:28+" es profesor jefe de "+[Cursos:3]Curso:1
		$messDlog:=__ ("Si elimina el registro de ")+[Profesores:4]Apellidos_y_nombres:28+__ (" deberá reasignar el profesor jefe a ")+[Cursos:3]Curso:1
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
			$messDlog:=__ ("Si elimina el registro de ")+[Profesores:4]Apellidos_y_nombres:28+__ (" deberá reasignar el profesor jefe a ")+[Cursos:3]Curso:1+__ (" y los profesores de asignatura en: ")+"\r"+$mess2
		Else 
			$mess:=__ ("Es profesor de las siguientes asignaturas: ")+"\r"+$mess2
			$messDlog:=__ ("Si elimina el registro de ")+[Profesores:4]Apellidos_y_nombres:28+__ (" deberá reasignar los profesores de asignatura en: ")+"\r"+$mess2
		End if 
	End if 
	QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=[Profesores:4]Numero:1)
	If (Records in selection:C76([Alumnos:2])>0)
		$mess:=[Profesores:4]Apellidos_y_nombres:28+" es tutor de  "+String:C10(Records in selection:C76([Alumnos:2]))+" alumnos."
		$messDlog:=__ ("Si elimina el registro de ")+[Profesores:4]Apellidos_y_nombres:28+__ (" deberá reasignar tutor a ")+String:C10(Records in selection:C76([Alumnos:2]))+__ (" alumnos.")
	End if 
	If ($mess#"")
		$r:=CD_Dlog (1;$messDlog+__ ("\r¿Desea realmente eliminar este registro de profesor?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			ARRAY TEXT:C222(aText1;0)
			ARRAY LONGINT:C221(aLong1;0)
			START TRANSACTION:C239
			READ WRITE:C146([Asignaturas:18])
			QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
			AT_DimArrays (Records in selection:C76([Asignaturas:18]);->aText1;->aLong1)
			OK:=KRL_Array2Selection (->aText1;->[Asignaturas:18]profesor_nombre:13;->aLong1;->[Asignaturas:18]profesor_numero:4)
			UNLOAD RECORD:C212([Asignaturas:18])
			READ ONLY:C145([Asignaturas:18])
			If (ok=1)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33=[Profesores:4]Numero:1)
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
				AT_DimArrays (Records in selection:C76([Alumnos:2]);->aText1;->aLong1)
				OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Tutor_Nombre:38;->aLong1;->[Alumnos:2]Tutor_numero:36)
				UNLOAD RECORD:C212([Alumnos:2])
				READ ONLY:C145([Alumnos:2])
			Else 
				ok:=0
			End if 
			If (ok=1)
				If (Not:C34(Locked:C147([xShell_Users:47])))
					  //MONO ticket 155612
					USR_GetUserProperties ([xShell_Users:47]No:1;->$vsUSR_UserName;->$vsUSR_StartUpMethod;->$vsUSR_Password;->$vlUSR_NbLogin;->$vdUSR_LastLogin;->$alUSR_Membership)
					If (Find in array:C230($alUSR_Membership;-15001)>0)  //grupo de administracion, validaremos que no se elimine un usuario cuando es el último que queda.
						USR_GetGroupProperties (-15001;->$vsUSR_GroupName;->$vlUSR_GroupOwnerID;->$al_idUrsGpo)
						If (Size of array:C274($al_idUrsGpo)=1)
							ok:=0
							CD_Dlog (0;__ ("El Grupo de Administración debe tener al menos un usuario"))
						Else 
							DELETE RECORD:C58([xShell_Users:47])
						End if 
					Else 
						DELETE RECORD:C58([xShell_Users:47])
					End if 
					KRL_ReloadAsReadOnly (->[xShell_Users:47])
				Else 
					ok:=0
				End if 
			Else 
				ok:=0
			End if 
			
			If (ok=1)
				DELETE RECORD:C58([Profesores:4])
				VALIDATE TRANSACTION:C240
				$0:=1
			Else 
				CANCEL TRANSACTION:C241
				$r:=CD_Dlog (0;__ ("El registro no puede ser eliminado en este momento (uno o más registros de asignaturas, cursos o usuario SchoolTrack están siendo utilizados por otros usuarios).\rPor favor intente nuevamente más tarde."))
				$0:=0
			End if 
		End if 
	Else 
		$r:=CD_Dlog (0;__ ("¿Desea Ud. realmente elimininar el registro de ")+[Profesores:4]Apellidos_y_nombres:28+__ ("?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			If (Not:C34(Locked:C147([xShell_Users:47])))
				  //MONO ticket 155612
				USR_GetUserProperties ([xShell_Users:47]No:1;->$vsUSR_UserName;->$vsUSR_StartUpMethod;->$vsUSR_Password;->$vlUSR_NbLogin;->$vdUSR_LastLogin;->$alUSR_Membership)
				If (Find in array:C230($alUSR_Membership;-15001)>0)  //grupo de administracion, validaremos que no se elimine un usuario cuando es el último que queda.
					USR_GetGroupProperties (-15001;->$vsUSR_GroupName;->$vlUSR_GroupOwnerID;->$al_idUrsGpo)
					If (Size of array:C274($al_idUrsGpo)=1)
						$delProfesor:=True:C214
						CD_Dlog (0;__ ("El Grupo de Administración debe tener al menos un usuario, este profesor no puede ser eliminado hasta que deje otro usuario más en el grupo Administración"))
					Else 
						DELETE RECORD:C58([xShell_Users:47])
						DELETE RECORD:C58([Profesores:4])
					End if 
				Else 
					DELETE RECORD:C58([xShell_Users:47])
					DELETE RECORD:C58([Profesores:4])
				End if 
				KRL_ReloadAsReadOnly (->[xShell_Users:47])
				$0:=1
			Else 
				$r:=CD_Dlog (0;__ ("El registro no puede ser eliminado en este momento (uno o más registros de asignaturas, cursos o usuario SchoolTrack están siendo utilizados por otros usuarios).\rPor favor intente nuevamente más tarde."))
				$0:=0
			End if 
			
		End if 
	End if 
Else 
	BEEP:C151
	USR_ALERT_UserHasNoRights (3)
End if 
