//%attributes = {}
  //SRACTac_CargaCargosLFrances

C_TEXT:C284(vAlumno1;vAlumno2;vAlumno3)
C_TEXT:C284(vCodigo1;vCodigo2;vCodigo3)
C_TEXT:C284(vMesPension1;vMesPension2;vMesPension3)
C_REAL:C285(vMatricula1;vMatricula2;vMatricula3)
C_REAL:C285(vSeguro1;vSeguro2;vSeguro3)
C_REAL:C285(vOtros1;vOtros2;vOtros3)
C_REAL:C285(vTotal11;vTotal12;vTotal13)
C_REAL:C285(vSolidaridad1;vSolidaridad2;vSolidaridad3)
C_REAL:C285(vCoop1;vCoop2;vCoop3)
C_REAL:C285(vAPA1;vAPA2;vAPA3)
C_REAL:C285(vTotal21;vTotal22;vTotal23)
C_REAL:C285(vTotal31;vTotal32;vTotal33)
C_REAL:C285(vTotal1;vTotal2;vTotal3)
C_REAL:C285(vPension1;vPension2;vPension3)
C_REAL:C285(vCafeteria1;vCafeteria2;vCafeteria3)
C_REAL:C285(vRefri1;vRefri2;vRefri3)

C_REAL:C285($total1;$total2;$total3)
C_POINTER:C301($ptr)

C_LONGINT:C283($1;$aviso)

$aviso:=$1

ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)

SRACTac_EndAvisoLFrances ($aviso)

$total1:=0
$total2:=0
$total3:=0

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

$ptr:=Get pointer:C304("vMesPension"+String:C10($aviso))
$ptr->:=aMeses{[ACT_Avisos_de_Cobranza:124]Mes:6}

QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@Matricula@")
$ptr:=Get pointer:C304("vMatricula"+String:C10($aviso))
$ptr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$total1:=$total1+$ptr->
CREATE SET:C116([ACT_Cargos:173];"Matricula")
DIFFERENCE:C122("CargosAviso";"Matricula";"CargosAviso")

USE SET:C118("CargosAviso")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@Carnet@";*)
QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12="@Correspondencia@";*)
QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12="@Material@";*)
QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12="@Seguro@";*)
QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12="@Talonario@")
$ptr:=Get pointer:C304("vSeguro"+String:C10($aviso))
$ptr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$total1:=$total1+$ptr->
CREATE SET:C116([ACT_Cargos:173];"Seguro")
DIFFERENCE:C122("CargosAviso";"Seguro";"CargosAviso")

USE SET:C118("CargosAviso")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@Solidaridad@")
$ptr:=Get pointer:C304("vSolidaridad"+String:C10($aviso))
$ptr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$total2:=$total2+$ptr->
CREATE SET:C116([ACT_Cargos:173];"Solidaridad")
DIFFERENCE:C122("CargosAviso";"Solidaridad";"CargosAviso")

USE SET:C118("CargosAviso")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@Cooperativa@")
$ptr:=Get pointer:C304("vCoop"+String:C10($aviso))
$ptr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$total2:=$total2+$ptr->
CREATE SET:C116([ACT_Cargos:173];"Cooperativa")
DIFFERENCE:C122("CargosAviso";"Cooperativa";"CargosAviso")

USE SET:C118("CargosAviso")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@APA@";*)
QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12="@A.P.A@")
$ptr:=Get pointer:C304("vAPA"+String:C10($aviso))
$ptr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$total2:=$total2+$ptr->
CREATE SET:C116([ACT_Cargos:173];"APA")
DIFFERENCE:C122("CargosAviso";"APA";"CargosAviso")

USE SET:C118("CargosAviso")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@Pension@";*)
QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12="@Pensien@")
$ptr:=Get pointer:C304("vPension"+String:C10($aviso))
$ptr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$total3:=$total3+$ptr->
CREATE SET:C116([ACT_Cargos:173];"Pension")
DIFFERENCE:C122("CargosAviso";"Pension";"CargosAviso")

USE SET:C118("CargosAviso")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@Cafeteria@")
$ptr:=Get pointer:C304("vCafeteria"+String:C10($aviso))
$ptr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$total3:=$total3+$ptr->
CREATE SET:C116([ACT_Cargos:173];"Cafeteria")
DIFFERENCE:C122("CargosAviso";"Cafeteria";"CargosAviso")

USE SET:C118("CargosAviso")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@Refrigerio@")
$ptr:=Get pointer:C304("vRefri"+String:C10($aviso))
$ptr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$total3:=$total3+$ptr->
CREATE SET:C116([ACT_Cargos:173];"Refrigerio")
DIFFERENCE:C122("CargosAviso";"Refrigerio";"CargosAviso")

USE SET:C118("CargosAviso")
$ptr:=Get pointer:C304("vOtros"+String:C10($aviso))
$ptr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$total1:=$total1+$ptr->

$ptr:=Get pointer:C304("vTotal"+String:C10($aviso)+"1")
$ptr->:=$total1
$ptr:=Get pointer:C304("vTotal"+String:C10($aviso)+"2")
$ptr->:=$total2
$ptr:=Get pointer:C304("vTotal"+String:C10($aviso))
$ptr->:=$total3

SET_ClearSets ("CargosAviso";"Matricula";"Seguro";"Solidaridad";"Cooperativa";"APA";"Pension";"Cafeteria";"Refrigerio")
AT_Initialize (->aMeses)