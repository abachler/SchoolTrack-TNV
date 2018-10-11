//%attributes = {}
  //ACTqry_CtasXEgresar
C_LONGINT:C283($i;$vl_totalCta;$proc)
ARRAY LONGINT:C221($al_idsPersonas;0)

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])

$proc:=IT_UThermometer (1;0;__ ("Ejecutando consulta..."))
QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
SELECTION TO ARRAY:C260([Personas:7]No:1;$al_idsPersonas)
CREATE EMPTY SET:C140([Alumnos:2];"CtasXEgresar")
For ($i;1;Size of array:C274($al_idsPersonas))
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=$al_idsPersonas{$i})
	  //QUERY SELECTION([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]Estado=True)
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>=<>al_NumeroNivelRegular{1};*)
	QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)})
	$vl_totalCta:=Records in selection:C76([Alumnos:2])
	  //KRL_RelateSelection (->[Alumnos]Número;->[ACT_CuentasCorrientes]ID_Alumno;"")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)})
	If (Records in selection:C76([Alumnos:2])=$vl_totalCta)
		FIRST RECORD:C50([Alumnos:2])
		While (Not:C34(End selection:C36([Alumnos:2])))
			ADD TO SET:C119([Alumnos:2];"CtasXEgresar")
			NEXT RECORD:C51([Alumnos:2])
		End while 
	End if 
End for 
USE SET:C118("CtasXEgresar")
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Total_Saldos:8<0)
CLEAR SET:C117("CtasXEgresar")
IT_UThermometer (-2;$proc)