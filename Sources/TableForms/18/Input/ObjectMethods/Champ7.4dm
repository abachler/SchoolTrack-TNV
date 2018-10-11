  //20120222 RCH ticket 107696
  //Self->:=Replace string(Replace string(Self->;"(";"[");")";"]")

Self:C308->:=ST_Format (Self:C308)
If ([Asignaturas:18]denominacion_interna:16="")
	[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]Asignatura:3
End if 
[Asignaturas:18]denominacion_interna:16:=ST_GetCleanString ([Asignaturas:18]denominacion_interna:16)
  //[Asignaturas]Denominación_interna:=Replace string([Asignaturas]Denominación_interna;"-";"_")
  //[Asignaturas]Denominación_interna:=Replace string([Asignaturas]Denominación_interna;"(";"[")
  //[Asignaturas]Denominación_interna:=Replace string([Asignaturas]Denominación_interna;")";"]")

AS_AsignaNumeroOrdenamiento 
$r:=AS_fExist 
If (Not:C34($r))
	AS_fSave 
	$recNum:=Record number:C243([Asignaturas:18])
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
		ARRAY TEXT:C222($aText1;Records in selection:C76([Alumnos_Calificaciones:208]))
		AT_Populate (->$aText1;->[Alumnos_Calificaciones:208]NombreInternoAsignatura:8)
		KRL_Array2Selection (->$aText1;->[Alumnos_Calificaciones:208]NombreInternoAsignatura:8)
		KRL_GotoRecord (->[Asignaturas:18];$recNum;True:C214)
	End if 
End if 
