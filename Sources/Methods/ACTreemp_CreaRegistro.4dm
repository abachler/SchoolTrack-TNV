//%attributes = {}
  //ACTreemp_CreaRegistro
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_REAL:C285($3)
C_DATE:C307($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)
C_BLOB:C604($7)

C_DATE:C307($vd_fecha)
C_LONGINT:C283($vl_idApdo;$vl_idTercero;$vl_id;$vl_idDocCartera)
C_REAL:C285($vr_montoTotal)
C_BLOB:C604($vy_blob)

If (False:C215)
	C_LONGINT:C283(ACTreemp_CreaRegistro ;$0)
	C_LONGINT:C283(ACTreemp_CreaRegistro ;$1)
	C_LONGINT:C283(ACTreemp_CreaRegistro ;$2)
	C_REAL:C285(ACTreemp_CreaRegistro ;$3)
	C_DATE:C307(ACTreemp_CreaRegistro ;$4)
	C_LONGINT:C283(ACTreemp_CreaRegistro ;$5)
	C_LONGINT:C283(ACTreemp_CreaRegistro ;$6)
	C_BLOB:C604(ACTreemp_CreaRegistro ;$7)
End if 
$vl_idApdo:=$1
$vl_idTercero:=$2
$vr_montoTotal:=$3
$vd_fecha:=$4
$vl_modo:=$5
$vl_idDocCartera:=$6
If (Count parameters:C259>=7)
	$vy_blob:=$7
End if 

CREATE RECORD:C68([ACT_ReemplazosDC:292])

  //20130827 RCH
  //$vl_id:=SQ_SeqNumber (->[ACT_ReemplazosDC]id)
C_LONGINT:C283($vl_id;$l_recNum)
While ($l_recNum#-1)
	$vl_id:=SQ_SeqNumber (->[ACT_ReemplazosDC:292]id:1)
	$l_recNum:=Find in field:C653([ACT_ReemplazosDC:292]id:1;$vl_id)
End while 

[ACT_ReemplazosDC:292]id:1:=$vl_id
[ACT_ReemplazosDC:292]id_apoderado:2:=$vl_idApdo
[ACT_ReemplazosDC:292]id_tercero:3:=$vl_idTercero
[ACT_ReemplazosDC:292]fecha_reemplazo:4:=$vd_fecha
[ACT_ReemplazosDC:292]monto:5:=$vr_montoTotal
[ACT_ReemplazosDC:292]id_modoReemplazo:6:=$vl_modo
[ACT_ReemplazosDC:292]id_doc_cartera:7:=$vl_idDocCartera
[ACT_ReemplazosDC:292]xBlob:8:=$vy_blob
KRL_SaveUnLoadReadOnly (->[ACT_ReemplazosDC:292])

$0:=$vl_id