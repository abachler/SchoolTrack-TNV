//%attributes = {}
  // XCR_apInscribe()
  // Por: Alberto Bachler K.: 02-06-14, 19:22:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_periodo;$l_recNumAlumno)

If (False:C215)
	C_LONGINT:C283(XCR_apInscribe ;$1)
	C_LONGINT:C283(XCR_apInscribe ;$2)
End if 

$l_recNumAlumno:=$1
If (Count parameters:C259=2)
	$l_periodo:=$2
Else 
	$l_periodo:=0
End if 



KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;False:C215)
READ WRITE:C146([Alumnos_Actividades:28])
QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Alumno_Numero:1=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Actividades:28]; & [Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Año:3=<>gYear)  //ASM 201405112
If (Records in selection:C76([Alumnos_Actividades:28])=0)
	CREATE RECORD:C68([Alumnos_Actividades:28])
	[Alumnos_Actividades:28]Año:3:=<>gYear
	[Alumnos_Actividades:28]Alumno_Numero:1:=[Alumnos:2]numero:1
	[Alumnos_Actividades:28]Nivel_Numero:64:=[Alumnos:2]nivel_numero:29
	[Alumnos_Actividades:28]Actividad_numero:2:=[Actividades:29]ID:1
	[Alumnos_Actividades:28]NombreActividad:43:=[Actividades:29]Nombre:2
	[Alumnos_Actividades:28]Periodos_Inscritos:44:=[Alumnos_Actividades:28]Periodos_Inscritos:44 ?+ $l_periodo
	LOG_RegisterEvt ("Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Actividades:28]Alumno_Numero:1;->[Alumnos:2]apellidos_y_nombres:40)+" inscrito en la actividad "+[Actividades:29]Nombre:2+", ID: "+String:C10([Actividades:29]ID:1)+".")
	SAVE RECORD:C53([Alumnos_Actividades:28])
Else 
	If ($l_periodo=0)
		[Alumnos_Actividades:28]Periodos_Inscritos:44:=0
		[Alumnos_Actividades:28]Periodos_Inscritos:44:=[Alumnos_Actividades:28]Periodos_Inscritos:44 ?+ 0
	Else 
		If ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0)
			  //ya esta en todos, no hacemos nada
		Else 
			[Alumnos_Actividades:28]Periodos_Inscritos:44:=[Alumnos_Actividades:28]Periodos_Inscritos:44 ?+ $l_periodo
			$l_numeroPeriodosInscrito:=0
			For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
				$l_numeroPeriodosInscrito:=$l_numeroPeriodosInscrito+Num:C11([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? $i)
			End for 
			If ($l_numeroPeriodosInscrito=Size of array:C274(atSTR_Periodos_Nombre))
				[Alumnos_Actividades:28]Periodos_Inscritos:44:=1
			End if 
			LOG_RegisterEvt ("Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Actividades:28]Alumno_Numero:1;->[Alumnos:2]apellidos_y_nombres:40)+" inscrito en la actividad "+[Actividades:29]Nombre:2+", ID: "+String:C10([Actividades:29]ID:1)+".")
		End if 
	End if 
	SAVE RECORD:C53([Alumnos_Actividades:28])
	KRL_ReloadAsReadOnly (->[Alumnos_Actividades:28])
End if 