//%attributes = {}
  //ACTdctos_OnRecordLoad

C_LONGINT:C283($l_idCta;$1)
C_POINTER:C301(${4})
C_BOOLEAN:C305($2;$b_conInactivos)

$l_idCta:=$1
$b_conInactivos:=$2
For ($i;3;Count parameters:C259)
	AT_Initialize (${$i})
End for 

READ ONLY:C145([ACT_DctosIndividuales_Cuentas:228])
QUERY:C277([ACT_DctosIndividuales_Cuentas:228];[ACT_DctosIndividuales_Cuentas:228]ID_CuentaCorriente:6=$l_idCta;*)
If (Not:C34($b_conInactivos))
	QUERY:C277([ACT_DctosIndividuales_Cuentas:228]; & ;[ACT_DctosIndividuales_Cuentas:228]Inactivo:10=$b_conInactivos)
Else 
	QUERY:C277([ACT_DctosIndividuales_Cuentas:228])
End if 
  //SET AUTOMATIC RELATIONS(True;False)
ORDER BY:C49([ACT_DctosIndividuales_Cuentas:228];[ACT_DctosIndividuales_Cuentas:228]Inactivo:10;>;[ACT_DctosIndividuales_Cuentas:228]Orden:8;>)
SET FIELD RELATION:C919([ACT_DctosIndividuales_Cuentas:228];Automatic:K51:4;Manual:K51:3)
SELECTION TO ARRAY:C260([ACT_DctosIndividuales_Cuentas:228]Porcentaje:7;$3->;[ACT_CFG_DctosIndividuales:229]Nombre:5;$4->;[ACT_DctosIndividuales_Cuentas:228]Periodo:9;$5->;[ACT_DctosIndividuales_Cuentas:228]Inactivo:10;$6->;[ACT_DctosIndividuales_Cuentas:228]ID:1;$7->;[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5;$8->)
  //SET AUTOMATIC RELATIONS(False;False)
SET FIELD RELATION:C919([ACT_DctosIndividuales_Cuentas:228];Structure configuration:K51:2;Structure configuration:K51:2)