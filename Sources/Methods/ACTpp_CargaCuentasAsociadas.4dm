//%attributes = {}
  //ACTpp_CargaCuentasAsociadas

AL_UpdateArrays (xALP_Alumnos;0)

ACTpp_FormArraysDeclarations ("ArreglosAlumnos")

READ ONLY:C145([ACT_CuentasCorrientes:175])
ACT_relacionaCtasyApdos (2)
LOAD RECORD:C52([Personas:7])
ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)

ARRAY INTEGER:C220($aExApdode;0)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])

AT_RedimArrays (Records in selection:C76([ACT_CuentasCorrientes:175]);->arACT_CCFacturado;->arACT_CCVencido;->arACT_CCSaldo;->atACT_CCAlumno;->atACT_CCCurso;->$aExApdode;->atACT_CCModoPago)
CREATE SET:C116([ACT_CuentasCorrientes:175];"ctasOrigen")
FIRST RECORD:C50([ACT_CuentasCorrientes:175])
For ($o;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	atACT_CCAlumno{$o}:=[Alumnos:2]apellidos_y_nombres:40
	atACT_CCCurso{$o}:=[Alumnos:2]curso:20
	arACT_CCFacturado{$o}:=[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16
	arACT_CCSaldo{$o}:=[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21
	arACT_CCVencido{$o}:=[ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18
	atACT_CCModoPago{$o}:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_CuentasCorrientes:175]id_modo_de_pago:32)
	QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Apoderados_de_Cuenta:107]; & ;[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=[Personas:7]No:1)
	If (Records in selection:C76([ACT_Apoderados_de_Cuenta:107])=1)
		$aExApdode{$o}:=1
	Else 
		$aExApdode{$o}:=0
	End if 
	NEXT RECORD:C51([ACT_CuentasCorrientes:175])
End for 

AL_UpdateArrays (xALP_Alumnos;-2)
For ($o;1;Size of array:C274($aExApdode))
	If ($aExApdode{$o}=1)
		AL_SetRowColor (xALP_Alumnos;$o;"Red";0)
		AL_SetRowStyle (xALP_Alumnos;$o;2)
	Else 
		AL_SetRowColor (xALP_Alumnos;$o;"";16)
		AL_SetRowStyle (xALP_Alumnos;$o;0)
	End if 
End for 
