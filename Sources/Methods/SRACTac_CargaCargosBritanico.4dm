//%attributes = {}
  //SRACTac_CargaCargosBritanico

C_TEXT:C284(vAlumno1;vAlumno2)
C_TEXT:C284(vCodigo1;vCodigo2)
C_TEXT:C284(vCurso1;vCurso2)
C_TEXT:C284(vMesAviso1;vMesAviso2)
C_LONGINT:C283(vIDAviso1;vIDAviso2)
C_TEXT:C284(vRuta1;vRuta2)

C_REAL:C285(vPension1;vPension2)
C_REAL:C285(vTransporte1;vTransporte2)
C_REAL:C285(vAlimentacion1;vAlimentacion2)
C_REAL:C285(vOtros1;vOtros2)

C_REAL:C285(vSaldo1;vSaldo2)
C_DATE:C307(vFechaV11;vFechaV12;vFechaV13;vFechaV14)
C_DATE:C307(vFechaV21;vFechaV22;vFechaV23;vFechaV24)

C_REAL:C285(vTotal11;vTotal12;vTotal13;vTotal14)
C_REAL:C285(vTotal21;vTotal22;vTotal23;vTotal24)

C_POINTER:C301($ptr)

C_LONGINT:C283($1;$aviso)

$aviso:=$1

ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)

SRACTac_EndAvisoBritanico ($aviso)

READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
CREATE SET:C116([ACT_Cargos:173];"CargosAviso")

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])
QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)

$ptr:=Get pointer:C304("vAlumno"+String:C10($aviso))
$ptr->:=[Alumnos:2]apellidos_y_nombres:40

$ptr:=Get pointer:C304("vCodigo"+String:C10($aviso))
$ptr->:=[ACT_CuentasCorrientes:175]Codigo:19

$ptr:=Get pointer:C304("vCurso"+String:C10($aviso))
$ptr->:=[Alumnos:2]curso:20

$ptr:=Get pointer:C304("vRuta"+String:C10($aviso))
$ptr->:=_CampoPropio ("RUTA No.")

$ptr:=Get pointer:C304("vIDAviso"+String:C10($aviso))
$ptr->:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1

$ptr:=Get pointer:C304("vMesAviso"+String:C10($aviso))
$ptr->:=aMeses{[ACT_Avisos_de_Cobranza:124]Mes:6}

$ptr:=Get pointer:C304("vSaldo"+String:C10($aviso))
$ptr->:=[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12

$ptr:=Get pointer:C304("vFechaV"+String:C10($aviso)+"1")
$ptr->:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5

$ptr:=Get pointer:C304("vFechaV"+String:C10($aviso)+"2")
$ptr->:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18

$ptr:=Get pointer:C304("vFechaV"+String:C10($aviso)+"3")
$ptr->:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19

$ptr:=Get pointer:C304("vFechaV"+String:C10($aviso)+"4")
$ptr->:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20

SRACTac_CalcTotalCargoBuck ("@Pension@";$aviso;"vPension";"vTotal";"Pension")
SRACTac_CalcTotalCargoBuck ("@Alimentacion@";$aviso;"vAlimentacion";"vTotal";"Alimentacion")
SRACTac_CalcTotalCargoBuck ("@Transporte@";$aviso;"vTransporte";"vTotal";"Trasnporte")
SRACTac_CalcTotalCargoBuck ("@";$aviso;"vOtros";"vTotal";"Otros")

SET_ClearSets ("CargosAviso";"Pension";"Transporte";"Alimentacion";"Otros")
AT_Initialize (->aMeses)