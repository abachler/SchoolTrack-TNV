//%attributes = {}
C_LONGINT:C283($vl_idFormaPago;$1;$vl_idEstado;$2;$vl_idRecordRecOrg;$3;$vl_pos;$vl_idRecord;$0)
C_DATE:C307(vdACT_fecha)

$vl_idFormaPago:=$1
$vl_idEstado:=$2
$vl_idRecordRecOrg:=$3

If (vdACT_fecha=!00-00-00!)
	vdACT_fecha:=Current date:C33(*)
End if 


CREATE RECORD:C68([ACT_Movimientos_Estados:288])

$vl_idRecord:=SQ_SeqNumber (->[ACT_Movimientos_Estados:288]id:1)
  //20121130 RCH Aparecieron algunos errores de llave duplicada...
While (Find in field:C653([ACT_Movimientos_Estados:288]id:1;$vl_idRecord)#-1)
	$vl_idRecord:=SQ_SeqNumber (->[ACT_Movimientos_Estados:288]id:1)
End while 
[ACT_Movimientos_Estados:288]id:1:=$vl_idRecord
[ACT_Movimientos_Estados:288]id_forma_de_pago:2:=$vl_idFormaPago
[ACT_Movimientos_Estados:288]id_estado:3:=$vl_idEstado
[ACT_Movimientos_Estados:288]id_record:4:=$vl_idRecordRecOrg
[ACT_Movimientos_Estados:288]asignado_por:7:=<>tUSR_CurrentUser
  //[ACT_Movimientos_Estados]Fecha:=Current date(*)
[ACT_Movimientos_Estados:288]Fecha:5:=vdACT_fecha
[ACT_Movimientos_Estados:288]DTS_Creacion:6:=DTS_MakeFromDateTime 

If ([ACT_Movimientos_Estados:288]id_estado:3#0)
	ACTcfg_OpcionesEstadosPagos ("CargaArreglos";->[ACT_Movimientos_Estados:288]id_forma_de_pago:2)
	$vl_pos:=Find in array:C230(alACT_estadosID;[ACT_Movimientos_Estados:288]id_estado:3)
	If ($vl_pos>0)
		[ACT_Movimientos_Estados:288]id_cta_contable:8:=alACT_estadosIDCta{$vl_pos}
		[ACT_Movimientos_Estados:288]cuenta_contable:9:=atACT_estadosCta{$vl_pos}
		[ACT_Movimientos_Estados:288]codigo_auxiliar:10:=atACT_estadosCtaCA{$vl_pos}
		[ACT_Movimientos_Estados:288]id_centro_costo:11:=alACT_estadosIDCentro{$vl_pos}
		[ACT_Movimientos_Estados:288]centro_costo:12:=atACT_estadosCentro{$vl_pos}
		
		[ACT_Movimientos_Estados:288]id_contra_cuenta_contable:13:=alACT_estadosIDCCta{$vl_pos}
		[ACT_Movimientos_Estados:288]contra_cuenta_contable:14:=atACT_estadosCCta{$vl_pos}
		[ACT_Movimientos_Estados:288]codigo_auxiliar_contra:15:=atACT_estadosCCtaCA{$vl_pos}
		[ACT_Movimientos_Estados:288]id_centro_costo_contra:16:=alACT_estadosIDCCentro{$vl_pos}
		[ACT_Movimientos_Estados:288]centro_costo_contra:17:=atACT_estadosCCentro{$vl_pos}
		
		[ACT_Movimientos_Estados:288]genera_movimiento_cont:18:=abACT_generaMovimientoCont{$vl_pos}
	End if 
End if 

SAVE RECORD:C53([ACT_Movimientos_Estados:288])
KRL_UnloadReadOnly (->[ACT_Movimientos_Estados:288])

$0:=$vl_idRecord