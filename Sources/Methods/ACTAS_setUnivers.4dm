//%attributes = {}
  //ACTAS_setUnivers
PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)

QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50#"En Trámite";*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50#"Oyente")
CREATE SET:C116([Alumnos:2];"Curso")
$t_totalAlumnos:=Records in selection:C76([Alumnos:2])

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="Y";*)
QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Fecha_de_retiro:42>=adSTR_Periodos_Desde{1})
iret:=Records in selection:C76([Alumnos:2])

iMatfin:=$t_totalAlumnos-iRet


USE SET:C118("Curso")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="??")
If (Records in selection:C76([Alumnos:2])>0)
	vs_AlumnosPendientes:=String:C10(Records in selection:C76([Alumnos:2]))+" alumnos con Situación final PENDIENTE"
Else 
	vs_AlumnosPendientes:=""
End if 

USE SET:C118("Curso")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="P";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="R";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="??";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="Y")
iTotalAlumnos:=Records in selection:C76([Alumnos:2])

If (<>bActas_PrintSelected)
	USE NAMED SELECTION:C332("◊Actas")
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$alumnos)
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="??")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If ($alumnos>0)
		vs_AlumnosPendientes:=String:C10($alumnos)+__ (" alumnos con Situación final PENDIENTE")
	Else 
		vs_AlumnosPendientes:=""
	End if 
	
	<>bActas_PrintSelected:=False:C215
	$month:=Month of:C24(Current date:C33(*))
	$day:=Day of:C23(Current date:C33(*))
	
	  //PS 27-06-2012: se modifica y se incorpora el año a la validacion ya que si si se queria imprimir para años anteriores salia en blanco
	$date1:=DT_GetDateFromDayMonthYear (30;11;<>gYear)
	
	If (Current date:C33(*)<$date1)
		iMatfin:=0
	End if 
End if 