//%attributes = {}
  //ACTdteRec_RespondeDTE

  //obtiene PDF de facturas recibidas
C_TEXT:C284($t_rutEmisor;$t_rutReceptor;$t_tipoArchivo)
C_REAL:C285($r_folio;$r_tipoArchivo)
C_TIME:C306($refDoc)
C_TEXT:C284($t_retorno;$0)
C_LONGINT:C283($l_idDTER;$6)
C_TEXT:C284($t_tipoAprobacion;$t_dato)

$t_rutEmisor:=$1
$t_rutReceptor:=$2
$r_tipoArchivo:=Num:C11($3)
$r_folio:=$4
$t_glosaAprobacion:=$5
$l_idDTER:=$6
If (Count parameters:C259>=7)
	$t_tipoAprobacion:=$7
End if 
If (Count parameters:C259>=8)
	$t_dato:=$8
End if 

If ($t_tipoAprobacion="")
	$t_tipoAprobacion:="comercial"
End if 
If ($t_dato="")
	$t_dato:="ARC"  //rechazo
End if 

$t_rutEmisor:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rutEmisor)
$t_rutReceptor:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rutReceptor)

vlWS_estado:=WSactdte_RechazaDTE ($t_rutEmisor;$t_rutReceptor;$r_tipoArchivo;$r_folio;$t_tipoAprobacion;$t_dato;$t_glosaAprobacion)

If (vlWS_estado=1)
	C_LONGINT:C283($l_bit)
	If ($t_tipoAprobacion#"mercaderias")
		$t_dato:=""
		$l_bit:=3
	Else 
		$t_glosaAprobacion:=""
		$l_bit:=4
	End if 
	
	$t_parametro:=ST_Concatenate ("";->$l_idDTER;->$t_glosaAprobacion;->$t_dato;->$l_bit)
	$b_hecho:=ACTdteRec_ActualizaEstado ($t_parametro)
	If (Not:C34($b_hecho))
		BM_CreateRequest ("ACT_rechazaDTERecibido";$t_parametro;String:C10($l_idDTER))
	End if 
End if 
