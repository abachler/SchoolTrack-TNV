//%attributes = {}
  //ACTdte_RetornaTextos

C_TEXT:C284($0;$t_accion;$1;$t_retorno)
C_POINTER:C301($vy_pointer1)
C_LONGINT:C283($l_bit)

$t_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 

Case of 
	: ($t_accion="IECV_tipoOperacion")
		  //[ACT_IECV]tipo_operacion
		$l_bit:=$vy_pointer1->
		Case of 
			: ($l_bit ?? 0)
				$t_retorno:="Compra"
			: ($l_bit ?? 1)
				$t_retorno:="Venta"
			: ($l_bit ?? 2)
				$t_retorno:="Boleta"
			: ($l_bit ?? 3)
				$t_retorno:="Guía"
			Else 
				$t_retorno:="Error"
		End case 
		
	: ($t_accion="IECV_estado")
		  //0: emitido. bit 0
		  //1: enviado_dte. bit 1
		  //2: recibido_dte. bit 2
		  //4: validado_dte. bit 3
		  //8: enviado_sii. bit 4
		  //16: aceptado_sii. bit 5
		  //32: aceptado_reparo_sii. bit 6
		  //64: rechazado_sii. bit 7
		
		$l_bit:=$vy_pointer1->
		Case of 
			: ($l_bit ?? 7)
				$t_retorno:="Rechazado SII"
			: ($l_bit ?? 6)
				$t_retorno:="Aceptado con reparos SII"
			: ($l_bit ?? 5)
				$t_retorno:="Aceptado SII"
			: ($l_bit ?? 4)
				$t_retorno:="Enviado SII"
			: ($l_bit ?? 3)
				$t_retorno:="Validado"
			: ($l_bit ?? 2)
				$t_retorno:="Libro con errores"
			: ($l_bit ?? 1)
				$t_retorno:="Enviado DTE"
			: ($l_bit ?? 0)
				$t_retorno:="Emitido"
			Else 
				$t_retorno:="Error"
		End case 
		
End case 

$0:=$t_retorno