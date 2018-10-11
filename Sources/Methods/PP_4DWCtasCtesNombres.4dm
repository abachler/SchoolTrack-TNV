//%attributes = {}
  //PP_4DWCtasCtesNombres

If (Count parameters:C259=0)
	ACT_relacionaCtasyApdos (2;"current")
	LOAD RECORD:C52([Personas:7])
	ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
	FIRST RECORD:C50([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
	READ ONLY:C145([ACT_Pagos:172])
	C_TEXT:C284(vt_StudentName)
	  //Buscar ID de los items que contengan la palabra Colegiatura
	vt_StudentName:=""
	For ($x;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		vt_StudentName:=vt_StudentName+[Alumnos:2]apellidos_y_nombres:40+"\r"
		NEXT RECORD:C51([ACT_CuentasCorrientes:175])
	End for 
	$0:=vt_StudentName
Else 
	C_LONGINT:C283($1)
	LOAD RECORD:C52([Personas:7])
	CREATE SET:C116([Personas:7];"Apoderados")
	QUERY:C277([Personas:7];[Personas:7]No:1;=;$1)
	ACT_relacionaCtasyApdos (2)
	ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
	FIRST RECORD:C50([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
	READ ONLY:C145([ACT_Pagos:172])
	C_TEXT:C284(vt_StudentName)
	  //Buscar ID de los items que contengan la palabra Colegiatura
	vt_StudentName:=""
	For ($x;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		vt_StudentName:=vt_StudentName+[Alumnos:2]apellidos_y_nombres:40+"\r"
		NEXT RECORD:C51([ACT_CuentasCorrientes:175])
	End for 
	$0:=vt_StudentName
	USE SET:C118("Apoderados")
	CLEAR SET:C117("Apoderados")
End if 

