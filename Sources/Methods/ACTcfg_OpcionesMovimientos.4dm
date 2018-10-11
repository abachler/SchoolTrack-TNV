//%attributes = {}
  //ACTcfg_OpcionesMovimientos

C_TEXT:C284($vt_accion;$1;$0;$vt_retorno;$vt_evento;$vt_cta)
C_POINTER:C301($ptr1;$ptr2;$ptr3)
C_POINTER:C301(${2})
C_BOOLEAN:C305($vb_mostrarAlerta)
C_LONGINT:C283($vl_idFormaDePago;$vl_idEstado;$vl_cta)

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 
If (Count parameters:C259>=6)
	$ptr5:=$6
End if 

Case of 
	: ($vt_accion="ValidaCambioEstadoPagares")
		If (Old:C35([ACT_Pagares:184]ID_Estado:6)#[ACT_Pagares:184]ID_Estado:6)
			  //ACTmov_CreateRecord (-16;[ACT_Pagares]ID_Estado;[ACT_Pagares]ID)
			$vt_retorno:=String:C10(ACTmov_CreateRecord (-16;[ACT_Pagares:184]ID_Estado:6;[ACT_Pagares:184]ID:12))
		End if 
		
	: ($vt_accion="ValidaCambioEstadoDctoPago")
		  // siempre se llena la tabla con los movimientos, dentro de la tabla hay un campo que indica si el registro genera un movimiento contable o no.
		If ((Old:C35([ACT_Documentos_de_Pago:176]id_estado:53)#[ACT_Documentos_de_Pago:176]id_estado:53) | (Is new record:C668([ACT_Documentos_de_Pago:176])))
			$vt_retorno:=String:C10(ACTmov_CreateRecord ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51;[ACT_Documentos_de_Pago:176]id_estado:53;[ACT_Documentos_de_Pago:176]ID:1))
		End if 
		
	: ($vt_accion="CambioCtaContableEnConf")
		$vl_idFormaDePago:=$ptr1->
		$vl_idEstado:=$ptr2->
		$vl_cta:=$ptr3->
		
		READ WRITE:C146([ACT_Movimientos_Estados:288])
		QUERY:C277([ACT_Movimientos_Estados:288];[ACT_Movimientos_Estados:288]id_forma_de_pago:2=$vl_idFormaDePago;*)
		QUERY:C277([ACT_Movimientos_Estados:288]; & ;[ACT_Movimientos_Estados:288]id_estado:3=$vl_idEstado)
		APPLY TO SELECTION:C70([ACT_Movimientos_Estados:288];$ptr4->:=$vl_cta)
		
		$vt_cta:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->$vl_cta;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
		Case of 
			: (KRL_isSameField ($ptr4;->[ACT_Movimientos_Estados:288]id_cta_contable:8))
				APPLY TO SELECTION:C70([ACT_Movimientos_Estados:288];[ACT_Movimientos_Estados:288]cuenta_contable:9:=$vt_cta)
				$vt_cta:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->$vl_cta;->[ACT_Cuentas_Contables:286]codigo_aux:5)
				APPLY TO SELECTION:C70([ACT_Movimientos_Estados:288];[ACT_Movimientos_Estados:288]codigo_auxiliar:10:=$vt_cta)
				
			: (KRL_isSameField ($ptr4;->[ACT_Movimientos_Estados:288]id_contra_cuenta_contable:13))
				APPLY TO SELECTION:C70([ACT_Movimientos_Estados:288];[ACT_Movimientos_Estados:288]contra_cuenta_contable:14:=$vt_cta)
				$vt_cta:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->$vl_cta;->[ACT_Cuentas_Contables:286]codigo_aux:5)
				APPLY TO SELECTION:C70([ACT_Movimientos_Estados:288];[ACT_Movimientos_Estados:288]codigo_auxiliar_contra:15:=$vt_cta)
				
			: (KRL_isSameField ($ptr4;->[ACT_Movimientos_Estados:288]id_centro_costo:11))
				APPLY TO SELECTION:C70([ACT_Movimientos_Estados:288];[ACT_Movimientos_Estados:288]centro_costo:12:=$vt_cta)
				
			: (KRL_isSameField ($ptr4;->[ACT_Movimientos_Estados:288]id_centro_costo_contra:16))
				APPLY TO SELECTION:C70([ACT_Movimientos_Estados:288];[ACT_Movimientos_Estados:288]centro_costo_contra:17:=$vt_cta)
				
		End case 
		
		KRL_UnloadReadOnly (->[ACT_Movimientos_Estados:288])
		
End case 

$0:=$vt_retorno