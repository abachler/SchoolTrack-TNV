$vl_idModoPago:=[ACT_CuentasCorrientes:175]id_modo_de_pago:32

$modos:=AT_array2text (->atACT_Modo_de_Pago)
$choice:=Pop up menu:C542($modos)
If ($choice>0)
	vtACT_ModoPago:=atACT_Modo_de_Pago{$choice}
	[ACT_CuentasCorrientes:175]id_modo_de_pago:32:=alACT_Modo_de_Pago{$choice}
	If (([ACT_CuentasCorrientes:175]id_modo_de_pago:32#-9) & ([ACT_CuentasCorrientes:175]id_modo_de_pago:32#-10))
		$r:=CD_Dlog (0;__ ("¿Desea eliminar la información de tarjeta de crédito y cuenta corriente ya no utilizadas?");__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			[ACT_CuentasCorrientes:175]PAT_Apellidos:34:=""
			[ACT_CuentasCorrientes:175]PAT_nombres:35:=""
			[ACT_CuentasCorrientes:175]PAT_identificador:36:=""
			[ACT_CuentasCorrientes:175]PAT_tipo_tc:37:=""
			[ACT_CuentasCorrientes:175]PAT_num_t_c:38:=""
			[ACT_CuentasCorrientes:175]PAT_year_venc:40:=""
			[ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39:=""
			[ACT_CuentasCorrientes:175]PAT_banco_emisor:41:=""
			[ACT_CuentasCorrientes:175]PAT_cod_mandato:42:=""
			[ACT_CuentasCorrientes:175]PAT_tarjeta_internacional:43:=False:C215
			[ACT_CuentasCorrientes:175]PAC_apellidos:44:=""
			[ACT_CuentasCorrientes:175]PAC_nombres:45:=""
			[ACT_CuentasCorrientes:175]PAC_identificador:49:=""
			[ACT_CuentasCorrientes:175]PAC_banco_nombre:47:=""
			[ACT_CuentasCorrientes:175]PAC_banco_id:48:=""
			[ACT_CuentasCorrientes:175]PAC_numero_de_cuenta:50:=""
			[ACT_CuentasCorrientes:175]PAC_codigo_mandato:51:=""
			vtACT_NumTC:=""
		End if 
	End if 
	If ($vl_idModoPago#[ACT_CuentasCorrientes:175]id_modo_de_pago:32)
		vbACT_CambioModoPago:=True:C214  //para el log
	End if 
End if 
IT_SetEnterable ((([ACT_CuentasCorrientes:175]id_modo_de_pago:32=-9) | ([ACT_CuentasCorrientes:175]id_modo_de_pago:32=-10));0;->[ACT_CuentasCorrientes:175]dia_de_cargo:33)