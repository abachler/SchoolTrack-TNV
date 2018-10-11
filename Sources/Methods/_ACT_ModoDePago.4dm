//%attributes = {}
  //_ACT_ModoDePago
  // Metodo recibe el id de la forma de pago. POr ejemplo: _ACT_ModoDePago ([Personas]ACT_id_modo_de_pago) 

C_LONGINT:C283($l_idFormaDePago;$1)
C_TEXT:C284($t_formaDePago;$0)

If (Count parameters:C259>=1)
	$l_idFormaDePago:=$1
	$t_formaDePago:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->$l_idFormaDePago)
Else 
	$t_formaDePago:="NO EXISTE"
End if 

$0:=$t_formaDePago

