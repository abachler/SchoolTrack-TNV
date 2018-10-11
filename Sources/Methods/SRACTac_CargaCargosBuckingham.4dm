//%attributes = {}
  //SRACTac_CargaCargosBuckingham

C_TEXT:C284(vAlumno1;vAlumno2)
C_TEXT:C284(vCodigo1;vCodigo2)
C_TEXT:C284(vCurso1;vCurso2)
C_TEXT:C284(vMesAviso1;vMesAviso2)

C_REAL:C285(vMatricula1;vMatricula2)
C_REAL:C285(vPapeleria1;vPapeleria2)
C_REAL:C285(vTextos1;vTextos2)

C_REAL:C285(vPension1;vPension2)
C_REAL:C285(vTransporte1;vTransporte2)
C_REAL:C285(vAlmuerzo1;vAlmuerzo2)
C_REAL:C285(vCafeteria1;vCafeteria2)
C_REAL:C285(vDeportes1;vDeportes2)
C_REAL:C285(vSistematIB1;vSistematIB2)
C_REAL:C285(vSistematizacion1;vSistematizacion2)

C_REAL:C285(vEventos1;vEventos2)

C_REAL:C285(vNotaC1;vNotaC2)
C_REAL:C285(vNotaD1;vNotaD2)

C_REAL:C285(vIntereses1;vIntereses2)

C_REAL:C285(vSaldo1;vSaldo2)
C_DATE:C307(vFechaV11;vFechaV12;vFechaV13;vFechaV14)
C_DATE:C307(vFechaV21;vFechaV22;vFechaV23;vFechaV24)

C_REAL:C285(vTotalMatricula11;vTotalMatricula12;vTotalMatricula13;vTotalMatricula14)
C_REAL:C285(vTotalPension11;vTotalPension12;vTotalPension13;vTotalPension14)
C_REAL:C285(vTotalBono11;vTotalBono12;vTotalBono13;vTotalBono14)
C_REAL:C285(vTotalIntereses11;vTotalIntereses12;vTotalIntereses13;vTotalIntereses14)
C_REAL:C285(vTotalMatricula21;vTotalMatricula22;vTotalMatricula23;vTotalMatricula24)
C_REAL:C285(vTotalPension21;vTotalPension22;vTotalPension23;vTotalPension24)
C_REAL:C285(vTotalBono21;vTotalBono22;vTotalBono23;vTotalBono24)
C_REAL:C285(vTotalIntereses21;vTotalIntereses22;vTotalIntereses23;vTotalIntereses24)

C_POINTER:C301($ptr)

C_LONGINT:C283($1;$aviso)

$aviso:=$1

ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)

SRACTac_EndAvisoBuckingham ($aviso)

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

SRACTac_CalcTotalCargoBuck ("@Matricula@";$aviso;"vMatricula";"vTotalMatricula";"Matricula")
SRACTac_CalcTotalCargoBuck ("@Papeler@";$aviso;"vPapeleria";"vTotalMatricula";"Papeleria")
SRACTac_CalcTotalCargoBuck ("@Texto@";$aviso;"vTextos";"vTotalMatricula";"Textos")
SRACTac_CalcTotalCargoBuck ("@Pension@";$aviso;"vPension";"vTotalPension";"Pension")
SRACTac_CalcTotalCargoBuck ("@Transporte@";$aviso;"vTransporte";"vTotalPension";"Transporte")
SRACTac_CalcTotalCargoBuck ("@Almuerzo@";$aviso;"vAlmuerzo";"vTotalPension";"Almuerzo")
SRACTac_CalcTotalCargoBuck ("@Cafeteria@";$aviso;"vCafeteria";"vTotalPension";"Cafeteria")
SRACTac_CalcTotalCargoBuck ("@Once@";$aviso;"vCafeteria";"vTotalPension";"Cafeteria")
SRACTac_CalcTotalCargoBuck ("@Deporte@";$aviso;"vDeportes";"vTotalPension";"Deportes")
SRACTac_CalcTotalCargoBuck ("@Sistematizacion @";$aviso;"vSistematIB";"vTotalPension";"SistematIB")
SRACTac_CalcTotalCargoBuck ("@Sistematizacion@";$aviso;"vSistematizacion";"vTotalPension";"Sistematizacion")
SRACTac_CalcTotalCargoBuck ("@Eventos@";$aviso;"vEventos";"vTotalBono";"Eventos")
SRACTac_CalcTotalCargoBuck ("@Nota Credito@";$aviso;"vNotaC";"vTotalPension";"NotaC")
SRACTac_CalcTotalCargoBuck ("@Nota Debito@";$aviso;"vNotaD";"vTotalPension";"NotaD")
SRACTac_CalcTotalCargoBuck ("Intereses";$aviso;"vIntereses";"vTotalIntereses";"Intereses")

SET_ClearSets ("CargosAviso";"Matricula";"Papeleria";"Textos";"Pension";"Transporte";"Pension";"Almuerzo";"Cafeteria";"Deportes";"SistematIB";"Sistematizacion";"Eventos";"NotaC";"NotaD";"Intereses")
AT_Initialize (->aMeses)