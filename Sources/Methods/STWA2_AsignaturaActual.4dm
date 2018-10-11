//%attributes = {}
  // STWA2_AsignaturaActual()
  // Por: Alberto Bachler Klein: 18-11-15, 15:53:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_idProfesor;$l_recNum)

If (False:C215)
	C_LONGINT:C283(STWA2_AsignaturaActual ;$0)
	C_LONGINT:C283(STWA2_AsignaturaActual ;$1)
End if 

$l_idProfesor:=$1

$l_recNum:=-1
If ($l_idProfesor>0)
	READ ONLY:C145([TMT_Horario:166])
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Teacher:9=$l_idProfesor)
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=Current date:C33;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=Current date:C33)
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=DT_GetDayNumber_ISO8601 (Current date:C33);*)
	QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Desde:3<=Current time:C178;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Hasta:4>=Current time:C178)
	If (Records in selection:C76([TMT_Horario:166])>0)
		FIRST RECORD:C50([TMT_Horario:166])
		$l_recNum:=Find in field:C653([Asignaturas:18]Numero:1;[TMT_Horario:166]ID_Asignatura:5)
	End if 
	$0:=$l_recNum
End if 



