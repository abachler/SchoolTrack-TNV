Case of 
	: (Form event:C388=On Data Change:K2:15)
		If (lb_descuentosTodos<=Size of array:C274(arACT_DescuentosT))
			
			C_LONGINT:C283($l_max)
			  //$l_max:=KRL_GetNumericFieldData (->[ACT_DctosIndividuales_Cuentas]ID;->alACT_DescuentosIdsCFG_T{lb_descuentosTodos};->[ACT_DctosIndividuales_Cuentas]ID_CuentaCorriente)
			$l_max:=KRL_GetNumericFieldData (->[ACT_CFG_DctosIndividuales:229]ID:1;->alACT_DescuentosIdsCFG_T{lb_descuentosTodos};->[ACT_CFG_DctosIndividuales:229]Porcentaje_Maximo:6)
			If (arACT_DescuentosT{lb_descuentosTodos}>100)
				arACT_DescuentosT{lb_descuentosTodos}:=100
				BEEP:C151
			End if 
			
			If (arACT_DescuentosT{lb_descuentosTodos}<0)
				arACT_DescuentosT{lb_descuentosTodos}:=0
				BEEP:C151
			End if 
			
			arACT_DescuentosT{lb_descuentosTodos}:=Round:C94(arACT_DescuentosT{lb_descuentosTodos};2)
			
			  //se valida el dcto maximo configurado
			If ($l_max#0)
				If (arACT_DescuentosT{lb_descuentosTodos}>$l_max)
					arACT_DescuentosT{lb_descuentosTodos}:=$l_max
					CD_Dlog (0;"El descuento ingresado superaba el máximo permitido en la configuración."+"\r\r"+"Fue asignado el descuento máximo permitido.")
				End if 
			End if 
			
			$l_descuentoIngresado:=Num:C11(ACTcc_OpcionesDctos ("ObtieneSumaDescuentos";->abACT_InactivosT;->arACT_DescuentosT))
			If ($l_descuentoIngresado>100)
				arACT_DescuentosT{lb_descuentosTodos}:=arACT_DescuentosT{0}
				CD_Dlog (0;"El descuento ingresado sobrepasa el 100%. Por favor ingrese un valor inferior.")
			End if 
			
			ACTinit_LoadPrefs 
			If (cbConsiderarDctoMaximo=1)
				If (vr_descuentoMaximo#0)
					If ($l_descuentoIngresado>vr_descuentoMaximo)
						$vt_text:="El descuento ingresado es superior al descuento máximo ingresado en la configurac"+"ión."+"\r\r"+"Para que el descuento por "+String:C10($l_descuentoIngresado)+"% sea aplicado recuerde "
						$vt_text:=$vt_text+ST_Boolean2Str (([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30);"mantener marcada ";"marcar ")
						$vt_text:=$vt_text+"la opción "+ST_Qte ("No aplica máximo de descuento"+".")
						CD_Dlog (0;$vt_text)
					End if 
				End if 
			End if 
			
			ACTcc_OpcionesDctos ("CargaResumen")
			
			  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
			  // y en este caso particular, los descuentos individuales
			vb_guardarCambios:=True:C214
			
		End if 
End case 