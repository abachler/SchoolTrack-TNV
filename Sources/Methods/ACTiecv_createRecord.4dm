//%attributes = {}
  //ACTiecv_createRecord
C_LONGINT:C283($l_numeroSegmento;$l_tipoEnvio;$l_tipoLibro;$l_tipoOperacion;$l_id;$0)
C_LONGINT:C283($l_idRazonSocial)
C_REAL:C285($r_folioNotificacion)
C_TEXT:C284($t_periodo;$t_codigoReemplazo)
C_BLOB:C604($x_archivoTexto)

$l_tipoOperacion:=$1
$t_periodo:=$2
$x_archivoTexto:=$3
$l_idRazonSocial:=$4

$l_tipoLibro:=1
$l_tipoEnvio:=3
$l_numeroSegmento:=0
$r_folioNotificacion:=0
$t_codigoReemplazo:=""

If (Count parameters:C259>=5)
	$l_tipoLibro:=$5
End if 
If (Count parameters:C259>=6)
	$l_tipoEnvio:=$6
End if 
If (Count parameters:C259>=7)
	$l_numeroSegmento:=$7
End if 
If (Count parameters:C259>=8)
	$r_folioNotificacion:=$8
End if 
If (Count parameters:C259>=9)
	$t_codigoReemplazo:=$9
End if 

CREATE RECORD:C68([ACT_IECV:253])
$l_id:=SQ_SeqNumber (->[ACT_IECV:253]id:1)

  //20150429 RCH
While (Find in field:C653([ACT_IECV:253]id:1;$l_id)#-1)
	$l_id:=SQ_SeqNumber (->[ACT_IECV:253]id:1)
End while 

Case of 
	: ($r_folioNotificacion#0)  //si tiene folio de notificacion, el tipo de libro es especial
		$l_tipoLibro:=2
	: ($t_codigoReemplazo#"")  //si tiene codigo de reemplazo, el tipo de libro es rectifica
		$l_tipoLibro:=3
End case 

[ACT_IECV:253]id:1:=$l_id
[ACT_IECV:253]fecha_generacion_dts:2:=DTS_MakeFromDateTime 
[ACT_IECV:253]id_iecv_dtenet:4:=0
[ACT_IECV:253]tipo_operacion:5:=$l_tipoOperacion
[ACT_IECV:253]periodo:6:=$t_periodo
[ACT_IECV:253]tipo_libro:7:=$l_tipoLibro
[ACT_IECV:253]tipo_envio:8:=$l_tipoEnvio
[ACT_IECV:253]numero_segmento:9:=$l_numeroSegmento
[ACT_IECV:253]folio_notificacion:10:=$r_folioNotificacion
[ACT_IECV:253]codigo_reemplazo_libro:11:=$t_codigoReemplazo
[ACT_IECV:253]glosa_procesamiento_dtenet:12:=""
[ACT_IECV:253]x_txt_enviado:13:=$x_archivoTexto
[ACT_IECV:253]estado:14:=[ACT_IECV:253]estado:14 ?+ 0
[ACT_IECV:253]id_razon_social:15:=$l_idRazonSocial
SAVE RECORD:C53([ACT_IECV:253])
KRL_UnloadReadOnly (->[ACT_IECV:253])

$0:=$l_id