COPY ARRAY:C226(<>atACT_ModosdePago;atACT_Modo_de_Pago)
$modos:=AT_array2text (->atACT_Modo_de_Pago)
$choice:=Pop up menu:C542($modos)
If ($choice>0)
	[ACT_Terceros:138]Modo_de_Pago:30:=atACT_Modo_de_Pago{$choice}
	[ACT_Terceros:138]Id_Modo_de_Pago:61:=alACT_Modo_de_Pago{$choice}
	vt_ModoDePagoTer:=atACT_Modo_de_Pago{$choice}
	If ($choice=1)
		$r:=CD_Dlog (0;__ ("¿Desea eliminar la información de tarjeta de crédito y cuenta corriente ya no utilizadas?");__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			[ACT_Terceros:138]PAT_Apellidos:32:=""
			[ACT_Terceros:138]PAT_Nombres:33:=""
			[ACT_Terceros:138]PAT_Identificador:34:=""
			[ACT_Terceros:138]PAT_TipoTC:35:=""
			[ACT_Terceros:138]PAT_NumTC:36:=""
			[ACT_Terceros:138]PAT_VencAgnoTC:37:=""
			[ACT_Terceros:138]PAT_VencMesTC:38:=""
			[ACT_Terceros:138]PAT_Banco_Emisor:39:=""
			[ACT_Terceros:138]PAT_CodMandato:40:=""
			[ACT_Terceros:138]PAT_TCInter:41:=False:C215
			[ACT_Terceros:138]PAC_Apellidos:42:=""
			[ACT_Terceros:138]PAC_Nombres:43:=""
			[ACT_Terceros:138]PAC_Identificador:46:=""
			[ACT_Terceros:138]PAC_Banco_Nombre:44:=""
			[ACT_Terceros:138]PAC_Banco_ID:45:=""
			[ACT_Terceros:138]PAC_NumCta:47:=""
			[ACT_Terceros:138]PAC_CodMandato:48:=""
			vtACTTer_noTarjetaC:=""
		End if 
	End if 
Else 
	$choice:=Find in array:C230(atACT_Modo_de_Pago;[ACT_Terceros:138]Modo_de_Pago:30)
End if 

  //20161115 RCH
  //IT_SetEnterable ((($choice=2) | ($choice=3));0;->[ACT_Terceros]Dia_de_Cargo)
C_BOOLEAN:C305($b_enterable)
$b_enterable:=(([ACT_Terceros:138]Id_Modo_de_Pago:61=-9) | ([ACT_Terceros:138]Id_Modo_de_Pago:61=-10))
IT_SetEnterable ($b_enterable;0;->[ACT_Terceros:138]Dia_de_Cargo:31)