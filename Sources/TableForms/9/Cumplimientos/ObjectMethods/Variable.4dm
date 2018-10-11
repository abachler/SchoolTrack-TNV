USE SET:C118("Castigos")
QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=False:C215)
If (Records in selection:C76([Alumnos_Castigos:9])=0)
	CD_Dlog (0;"No hay ningún castigo pendiente en la selección.")
Else 
	$n:=Day number:C114(Current date:C33)
	$offset:=7-$n
	$date:=Current date:C33+$offset
	$date2Txt:=CD_Request ("Fecha de la sesión: ";"Aceptar";"";"";String:C10($date;"00/00/0000"))
	$date2:=Date:C102($date2Txt)
	dSesion:=DT_GetDateFromDayMonthYear (Day of:C23($date2);Month of:C24($date2);Year of:C25($date2))
	dDate:=Current date:C33
	hHeure:=Current time:C178
	iTotal:=Size of array:C274(alCastigos_RecNums)
	If (dSesion#!00-00-00!)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([Alumnos_Castigos:9];alCastigos_RecNums;[Alumnos_Castigos:9]Castigo_cumplido:4;abCastigo_Cumplimiento;[Alumnos_Castigos:9]Fecha:9;adCastigo_Fecha;[Alumnos_Castigos:9]Horas_de_castigo:7;aiCastigo_Horas;[Alumnos:2]curso:20;atCastigos_curso;[Alumnos:2]nivel_numero:29;alCastigos_NoNivel;[Alumnos:2]no_de_lista:53;aiCastigos_NumeroLista;[Alumnos:2]apellidos_y_nombres:40;atCastigos_NombreAlumno)
		
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		dDate:=Current date:C33(*)
		hHeure:=Current time:C178(*)
		iTotal:=Size of array:C274(alCastigos_RecNums)
		ACCEPT:C269
	Else 
		CD_Dlog (0;"La fecha no es correcta.")
	End if 
End if 