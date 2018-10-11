QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;=;<>al_NumeroNivelesActivos{<>at_NombreNivelesActivos};*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Curso:5;=;at_CursoOrigen{at_CursoOrigen};*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17;=;False:C215;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]nivel_jerarquico:107=0)
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>;[Asignaturas:18]Asignatura:3;>)

SELECTION TO ARRAY:C260([Asignaturas:18];al_RecNumAsignaturasOrigen;[Asignaturas:18]Asignatura:3;at_AsignaturasOrigen;[Asignaturas:18]nivel_jerarquico:107;$aNivelH)
For ($i;1;Size of array:C274(al_RecNumAsignaturasOrigen))
	at_AsignaturasOrigen{$i}:=("  ")*$aNivelH{$i}+at_AsignaturasOrigen{$i}
End for 
LISTBOX SELECT ROW:C912(lb_Asignaturas;0;lk remove from selection:K53:3)

COPY ARRAY:C226(at_CursoOrigen;at_CursosDestino)
$el:=Find in array:C230(at_CursosDestino;at_CursoOrigen{at_CursoOrigen})
DELETE FROM ARRAY:C228(at_CursosDestino;$el)
DELETE FROM ARRAY:C228(lb_CursosDestino;$el)


For ($i;1;Size of array:C274(lb_CursosDestino))
	If (lb_CursosDestino{$i}=True:C214)
		$letra:=ST_GetWord (at_CursosDestino{$i};2;"-")
		If (Find in array:C230(at_Secciones;$letra)<0)
			APPEND TO ARRAY:C911(at_Secciones;$letra)
		End if 
	Else 
		$letra:=ST_GetWord (at_CursosDestino{$i};2;"-")
		$el:=Find in array:C230(at_Secciones;$letra)
		If ($el>0)
			DELETE FROM ARRAY:C228(at_Secciones;$el)
		End if 
	End if 
End for 
SORT ARRAY:C229(at_Secciones;>)
$letraCursoOrigen:=ST_ClearSpaces (ST_GetWord (at_CursoOrigen{at_CursoOrigen};2;"-"))
$el:=Find in array:C230(at_Secciones;$letraCursoOrigen)
If ($el>0)
	DELETE FROM ARRAY:C228(at_Secciones;$el)
End if 
vt_secciones:=AT_array2text (->at_Secciones;", ")
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>;[Asignaturas:18]Asignatura:3;>)

SELECTION TO ARRAY:C260([Asignaturas:18];al_RecNumAsignaturasOrigen;[Asignaturas:18]Asignatura:3;at_AsignaturasOrigen;[Asignaturas:18]nivel_jerarquico:107;$aNivelH)
For ($i;1;Size of array:C274(al_RecNumAsignaturasOrigen))
	at_AsignaturasOrigen{$i}:=("  ")*$aNivelH{$i}+at_AsignaturasOrigen{$i}
End for 
LISTBOX SELECT ROW:C912(lb_Asignaturas;0;lk remove from selection:K53:3)

COPY ARRAY:C226(at_CursoOrigen;at_CursosDestino)
$el:=Find in array:C230(at_CursosDestino;at_CursoOrigen{at_CursoOrigen})
DELETE FROM ARRAY:C228(at_CursosDestino;$el)
DELETE FROM ARRAY:C228(lb_CursosDestino;$el)


For ($i;1;Size of array:C274(lb_CursosDestino))
	If (lb_CursosDestino{$i}=True:C214)
		$letra:=ST_GetWord (at_CursosDestino{$i};2;"-")
		If (Find in array:C230(at_Secciones;$letra)<0)
			APPEND TO ARRAY:C911(at_Secciones;$letra)
		End if 
	Else 
		$letra:=ST_GetWord (at_CursosDestino{$i};2;"-")
		$el:=Find in array:C230(at_Secciones;$letra)
		If ($el>0)
			DELETE FROM ARRAY:C228(at_Secciones;$el)
		End if 
	End if 
End for 
SORT ARRAY:C229(at_Secciones;>)
$letraCursoOrigen:=ST_ClearSpaces (ST_GetWord (at_CursoOrigen{at_CursoOrigen};2;"-"))
$el:=Find in array:C230(at_Secciones;$letraCursoOrigen)
If ($el>0)
	DELETE FROM ARRAY:C228(at_Secciones;$el)
End if 
vt_secciones:=AT_array2text (->at_Secciones;", ")