//%attributes = {}
  //ACTwa_RetornaDeudaApdo 


C_LONGINT:C283($l_id)
C_DATE:C307($d_fecha)
C_REAL:C285(RNApdo;RNCta)
C_LONGINT:C283(RNTercero)
C_OBJECT:C1216($ob_cargos)

RNApdo:=-1
RNCta:=-1
RNTercero:=-1

$ob_cargos:=$1
$l_id:=$2
$d_fecha:=$3

ACTcfg_LoadBancos 

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])

RNApdo:=KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_id;False:C215)

ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
ACTpgs_CargaDatosPagoApdo (False:C215;$d_fecha)

OB SET ARRAY:C1227($ob_cargos;"idcuenta";alACT_CIDCtaCte)
OB SET ARRAY:C1227($ob_cargos;"vencimiento";adACT_CFechaVencimiento)
OB SET ARRAY:C1227($ob_cargos;"glosa";atACT_CGlosa)
OB SET ARRAY:C1227($ob_cargos;"neto";arACT_CMontoNeto)
OB SET ARRAY:C1227($ob_cargos;"saldo";arACT_CSaldo)

ACTpgs_DeclaraArreglosCargosT 
ACTpgs_DeclareArraysAvisos 
