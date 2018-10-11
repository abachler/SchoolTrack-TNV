  // con shift presionado se salta la ptrgunta
C_LONGINT:C283($vl_resp)
If (csACTcfg_ModosPagoXCuenta=1)
	If (Shift down:C543)
		$vl_resp:=1
	Else 
		$vl_resp:=CD_Dlog (0;__ ("El sistema está configurado para asignar modos de pago por Cuenta Corriente. Si continúa se actualizarán los modos de pago de las Cuentas Corrientes asociadas, según lo seleccionado.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
	End if 
Else 
	$vl_resp:=1
End if 
If ($vl_resp=1)
	$vtACT_modoPago:=[Personas:7]ACT_Modo_de_pago:39
	$vl_idModoPago:=[Personas:7]ACT_id_modo_de_pago:94
	$modos:=AT_array2text (->atACT_Modo_de_Pago)
	$choice:=Pop up menu:C542($modos)
	If ($choice>0)
		[Personas:7]ACT_Modo_de_pago:39:=atACT_Modo_de_Pago{$choice}
		[Personas:7]ACT_modo_de_pago_new:95:=atACT_Modo_de_Pago{$choice}
		[Personas:7]ACT_id_modo_de_pago:94:=alACT_Modo_de_Pago{$choice}
		vt_ModoDePago:=atACT_Modo_de_Pago{$choice}
		If (([Personas:7]ACT_id_modo_de_pago:94#-9) & ([Personas:7]ACT_id_modo_de_pago:94#-10))
			$r:=CD_Dlog (0;__ ("¿Desea eliminar la información de tarjeta de crédito y cuenta corriente para este apoderado?");__ ("");__ ("Si");__ ("No"))
			If ($r=1)
				[Personas:7]ACT_Apellido_Paterno_TC:71:=""
				[Personas:7]ACT_Apellido_Materno_TC:72:=""
				[Personas:7]ACT_Nombres_TC:73:=""
				[Personas:7]ACT_Titular_TC:55:=""
				[Personas:7]ACT_RUTTitular_TC:56:=""
				[Personas:7]ACT_Tipo_TC:52:=""
				[Personas:7]ACT_Numero_TC:54:=""
				[Personas:7]ACT_MesVenc_TC:57:=""
				[Personas:7]ACT_AñoVenc_TC:58:=""
				[Personas:7]ACT_Banco_TC:53:=""
				[Personas:7]ACT_CodMandatoPAT:63:=""
				[Personas:7]ACT_Apellido_Paterno_Cta:74:=""
				[Personas:7]ACT_Apellido_Materno_Cta:75:=""
				[Personas:7]ACT_Nombres_Cta:76:=""
				[Personas:7]ACT_Titular_Cta:49:=""
				[Personas:7]ACT_RUTTitutal_Cta:50:=""
				[Personas:7]ACT_Banco_Cta:47:=""
				[Personas:7]ACT_Numero_Cta:51:=""
				[Personas:7]ACT_CodMandatoPAC:62:=""
				[Personas:7]ACT_ID_Banco_Cta:48:=""
				vt_noTarjetaC:=""
			End if 
		End if 
		If ($vtACT_modoPago#[Personas:7]ACT_Modo_de_pago:39)
			vbACT_CambioModoPago:=True:C214  //para el log
			ACTcfg_OpcionesGenABancarios ("ActualizaModoPagoEnCuentas";->[Personas:7]No:1;->[Personas:7]ACT_id_modo_de_pago:94)
			$vl_recNum:=Record number:C243([Personas:7])
			SAVE RECORD:C53([Personas:7])
			ACTpp_CargaCuentasAsociadas 
			KRL_GotoRecord (->[Personas:7];$vl_recNum;True:C214)
		End if 
	Else 
		$choice:=Find in array:C230(atACT_Modo_de_Pago;[Personas:7]ACT_Modo_de_pago:39)
	End if 
	IT_SetEnterable ((([Personas:7]ACT_id_modo_de_pago:94=-9) | ([Personas:7]ACT_id_modo_de_pago:94=-10));0;->[Personas:7]ACT_DiaCargo:61)
	IT_SetEnterable ([Personas:7]ACT_id_modo_de_pago:94=-11;0;->[Personas:7]ACT_NoCuotasCup:80)
	If (([Personas:7]ACT_id_modo_de_pago:94=-11) & ([Personas:7]ACT_NoCuotasCup:80=0))
		[Personas:7]ACT_NoCuotasCup:80:=10
	End if 
End if 