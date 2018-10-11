//%attributes = {}
  // Método: ACTcc_MostrarCuentasExcluidas
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 01-12-10, 12:29:12
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




  //ACTcc_MostrarCuentasExcluidas

ARRAY LONGINT:C221($alACT_CuentasTomadas;0)

COPY ARRAY:C226($1->;$alACT_CuentasTomadas)

ARRAY TEXT:C222(aDeletedNames;0)
ARRAY TEXT:C222(aMotivo;0)
READ ONLY:C145([ACT_CuentasCorrientes:175])
For ($i;1;Size of array:C274($alACT_CuentasTomadas))
	GOTO RECORD:C242([ACT_CuentasCorrientes:175];$alACT_CuentasTomadas{$i})
	AT_Insert (1;1;->aDeletedNames;->aMotivo)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	aMotivo{1}:="La cuenta corriente estaba siendo utilizada por otro proceso."
	aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
	
	  //20120107 RCH Para mayor control...
	LOG_RegisterEvt ("Generación de Cargos: Cargos no generados completamente. Alumno "+aDeletedNames{1}+". Motivo: "+aMotivo{1})
End for 
vReportTitle:="Cuentas corrientes que fueron excluidas de la generación"
vBtnTitle:=__ ("Aceptar")
vbACT_MostrarBoton:=False:C215  //usada para esconder el segundo boton del informe (ver form method de CtasExcluidas)
$r:=CD_Dlog (0;__ ("Algunas cuentas fueron excluídas de la generación.");"";__ ("Ver cuentas excluídas");__ ("Aceptar"))
If ($r=1)
	SORT ARRAY:C229(aDeletedNames;aMotivo;>)
	WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasExcluidas";0;4;__ ("Cuentas Excluídas"))
	DIALOG:C40([ACT_CuentasCorrientes:175];"CtasExcluidas")
	CLOSE WINDOW:C154
	AT_Initialize (->aDeletedNames;->aMotivo)
End if 