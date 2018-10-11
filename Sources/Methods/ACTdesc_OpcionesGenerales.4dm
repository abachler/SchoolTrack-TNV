//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 06-05-17, 22:02:12
  // ----------------------------------------------------
  // Método: ACTdesc_OpcionesGenerales
  // Descripción
  // Se encarga de manejar la nueva configuración de cáclulo de descuentos por caja automáticamente
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$t_accion)
C_OBJECT:C1216($0;$o_retorno)
C_OBJECT:C1216($o_configuracion;$o_afecto;$o_exento;$o_param1)
C_REAL:C285($r_monto)

$t_accion:=$1
If (Count parameters:C259>=2)
	$o_param1:=$2
End if 

If (False:C215)  //20170717 RCH Se deshabilita opción y se oculta configuración...
	Case of 
		: ($t_accion="OnLoadConf")
			$o_configuracion:=ACTdesc_OpcionesGenerales ("LeePreferencia")
			
			$o_afecto:=OB Get:C1224($o_configuracion;"afecto")
			$o_exento:=OB Get:C1224($o_configuracion;"exento")
			
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_CalcularAfecto"))->:=OB Get:C1224($o_afecto;"calcular_descuento")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_DiasCalculoAfecto"))->:=OB Get:C1224($o_afecto;"usar_dias")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIESoloAfectosAfecto"))->:=OB Get:C1224($o_afecto;"solo_montosafectosadescuentoscargos")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_ModificaAfecto"))->:=OB Get:C1224($o_afecto;"permitir_modificar")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_lIE_PctAfecto"))->:=OB Get:C1224($o_afecto;"porcentaje_descuento")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_lIE_DiasAfecto"))->:=OB Get:C1224($o_afecto;"dias_descuento")
			
			
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_CalcularExento"))->:=OB Get:C1224($o_exento;"calcular_descuento")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_DiasCalculoExento"))->:=OB Get:C1224($o_exento;"usar_dias")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIESoloAfectosExento"))->:=OB Get:C1224($o_exento;"solo_montosafectosadescuentoscargos")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_ModificaExento"))->:=OB Get:C1224($o_exento;"permitir_modificar")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_lIE_PctExento"))->:=OB Get:C1224($o_exento;"porcentaje_descuento")
			(OBJECT Get pointer:C1124(Object named:K67:5;"o_lIE_DiasExento"))->:=OB Get:C1224($o_exento;"dias_descuento")
			
			
		: (($t_accion="ConfXdefecto") | ($t_accion="Configuracion"))
			
			  //Por defecto los valores son 0
			C_LONGINT:C283($l_calcular;$l_pctDescuento;$l_usarDias;$l_diasDcto;$l_soloAfectos;$l_permiteMod)
			C_LONGINT:C283($l_calcularE;$l_pctDescuentoE;$l_usarDiasE;$l_diasDctoE;$l_soloAfectosE;$l_permiteModE)
			
			If ($t_accion="Configuracion")
				$l_calcular:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_CalcularAfecto"))->
				$l_pctDescuento:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_lIE_PctAfecto"))->
				$l_usarDias:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_DiasCalculoAfecto"))->
				$l_diasDcto:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_lIE_DiasAfecto"))->
				$l_soloAfectos:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIESoloAfectosAfecto"))->
				$l_permiteMod:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_ModificaAfecto"))->
				
				$l_calcularE:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_CalcularExento"))->
				$l_pctDescuentoE:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_lIE_PctExento"))->
				$l_usarDiasE:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_DiasCalculoExento"))->
				$l_diasDctoE:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_lIE_DiasExento"))->
				$l_soloAfectosE:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIESoloAfectosExento"))->
				$l_permiteModE:=(OBJECT Get pointer:C1124(Object named:K67:5;"o_csIE_ModificaExento"))->
				
			End if 
			
			If ($l_pctDescuento<0)
				$l_pctDescuento:=0
			End if 
			
			If ($l_pctDescuento>100)
				$l_pctDescuento:=100
			End if 
			
			If ($l_diasDcto<0)
				$l_diasDcto:=0
			End if 
			
			If ($l_pctDescuentoE<0)
				$l_pctDescuentoE:=0
			End if 
			If ($l_pctDescuentoE>100)
				$l_pctDescuentoE:=100
			End if 
			If ($l_diasDctoE<0)
				$l_diasDctoE:=0
			End if 
			
			OB SET:C1220($o_afecto;"calcular_descuento";$l_calcular)
			OB SET:C1220($o_afecto;"porcentaje_descuento";$l_pctDescuento)
			OB SET:C1220($o_afecto;"usar_dias";$l_usarDias)
			OB SET:C1220($o_afecto;"dias_descuento";$l_diasDcto)
			OB SET:C1220($o_afecto;"solo_montosafectosadescuentoscargos";$l_soloAfectos)
			OB SET:C1220($o_afecto;"permitir_modificar";$l_permiteMod)
			
			OB SET:C1220($o_exento;"calcular_descuento";$l_calcularE)
			OB SET:C1220($o_exento;"porcentaje_descuento";$l_pctDescuentoE)
			OB SET:C1220($o_exento;"usar_dias";$l_usarDiasE)
			OB SET:C1220($o_exento;"dias_descuento";$l_diasDctoE)
			OB SET:C1220($o_exento;"solo_montosafectosadescuentoscargos";$l_soloAfectosE)
			OB SET:C1220($o_exento;"permitir_modificar";$l_permiteModE)
			
			OB SET:C1220($o_configuracion;"afecto";$o_afecto)
			OB SET:C1220($o_configuracion;"exento";$o_exento)
			
			  //SET TEXT TO PASTEBOARD(JSON Stringify($o_configuracion;*))
			
			$o_retorno:=$o_configuracion
			
		: ($t_accion="LeePreferencia")
			$o_configuracion:=ACTdesc_OpcionesGenerales ("ConfXdefecto")
			$o_configuracion:=PREF_fGetObject (0;"ACT_calculoDesctoXCaja";$o_configuracion)
			$o_retorno:=$o_configuracion
			
		: ($t_accion="GuardaConfiguracion")
			$o_configuracion:=ACTdesc_OpcionesGenerales ("Configuracion")
			PREF_SetObject (0;"ACT_calculoDesctoXCaja";$o_configuracion)
			
		: ($t_accion="CalculaDesdeIngresoPago")
			
			$o_configuracion:=ACTdesc_OpcionesGenerales ("LeePreferencia")
			
			$o_afecto:=OB Get:C1224($o_configuracion;"afecto")
			$o_exento:=OB Get:C1224($o_configuracion;"exento")
			
			  //DESCUENTO AFECTO
			If ((OB Get:C1224($o_afecto;"calcular_descuento")=1) | (OB Get:C1224($o_exento;"calcular_descuento")=1))
				
				ARRAY LONGINT:C221($laACT_idsCargos;0)  //cargos seleccionados
				For ($l_indice;1;Size of array:C274(abACT_ASelectedCargo))
					If (abACT_ASelectedCargo{$l_indice})
						APPEND TO ARRAY:C911($laACT_idsCargos;alACT_CIdsCargos{$l_indice})
					End if 
				End for 
				
				If (OB Get:C1224($o_afecto;"calcular_descuento")=1)
					If (OB Get:C1224($o_afecto;"porcentaje_descuento")>0)
						
						READ ONLY:C145([ACT_Cargos:173])
						QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;$laACT_idsCargos)
						
						$r_monto:=OB Get:C1224(ACTdesc_OpcionesGenerales ("CalculaAfectoDesdeCargos";$o_afecto);"monto_afecto")
						vrACT_MontoDesctoAfecto:=Round:C94($r_monto*(OB Get:C1224($o_afecto;"porcentaje_descuento")/100);<>vlACT_Decimales)
						vrACT_MontoaPagarAfecto:=vrACT_SeleccionadoAfecto-vrACT_MontoDesctoAfecto
						
						  //OBJECT SET ENTERABLE(vrACT_MontoDesctoAfecto;(OB Get($o_afecto;"permitir_modificar")=1))
						  //OBJECT SET ENABLED(*;"btn_Afecto1";(OB Get($o_afecto;"permitir_modificar")=1))
					End if 
				End if 
				
				  //DESCUENTO EXENTO
				If (OB Get:C1224($o_exento;"calcular_descuento")=1)
					If (OB Get:C1224($o_exento;"porcentaje_descuento")>0)
						
						READ ONLY:C145([ACT_Cargos:173])
						QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;$laACT_idsCargos)
						
						$r_monto:=OB Get:C1224(ACTdesc_OpcionesGenerales ("CalculaExentoDesdeCargos";$o_exento);"monto_exento")
						
						vrACT_MontoDesctoExento:=Round:C94($r_monto*(OB Get:C1224($o_exento;"porcentaje_descuento")/100);<>vlACT_Decimales)
						vrACT_MontoaPagarExento:=vrACT_SeleccionadoExento-vrACT_MontoDesctoExento
						
						
						  //OBJECT SET ENTERABLE(vrACT_MontoDesctoExento;(OB Get($o_exento;"permitir_modificar")=1))
						  //OBJECT SET ENABLED(*;"btn_Afecto2";(OB Get($o_exento;"permitir_modificar")=1))
					End if 
					
				End if 
				vrACT_MontoDescto:=vrACT_MontoDesctoAfecto+vrACT_MontoDesctoExento
				vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
				vrACT_MontoPago:=vrACT_MontoaPagar
			End if 
			
			ACTdesc_OpcionesGenerales ("OnLoadVentanaPagos";$o_configuracion)
			
		: (($t_accion="CalculaExentoDesdeCargos") | ($t_accion="CalculaAfectoDesdeCargos"))
			
			CREATE SET:C116([ACT_Cargos:173];"$setC1")  // 20170509 RCH
			If (OB Get:C1224($o_param1;"solo_montosafectosadescuentoscargos")=1)
				SET FIELD RELATION:C919([ACT_Cargos:173]Ref_Item:16;Automatic:K51:4;Do not modify:K51:1)
				QUERY SELECTION:C341([ACT_Cargos:173];[xxACT_Items:179]Afecto_a_descuentos:4=True:C214)
				SET FIELD RELATION:C919([ACT_Cargos:173]Ref_Item:16;Structure configuration:K51:2;Structure configuration:K51:2)
			End if 
			
			If (OB Get:C1224($o_param1;"usar_dias")=1)
				C_DATE:C307($d_fecha)
				$d_fecha:=Add to date:C393(vdACT_FechaPago;0;0;-OB Get:C1224($o_param1;"dias_descuento"))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>$d_fecha)
			End if 
			
			If ($t_accion="CalculaExentoDesdeCargos")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0)
			Else 
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21>0)
			End if 
			
			  //20170509 RCH Se buscan cargos asociados...
			CREATE SET:C116([ACT_Cargos:173];"$setC2")
			ARRAY LONGINT:C221($al_idsC;0)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsC)
			QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idsC)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-100)
			CREATE SET:C116([ACT_Cargos:173];"$setC3")
			UNION:C120("$setC2";"$setC3";"$setC2")
			INTERSECTION:C121("$setC1";"$setC2";"$setC1")  //Con esto me aseguro que los cargos relacionados están en la selección inicial.
			USE SET:C118("$setC1")
			SET_ClearSets ("$setC1";"$setC2";"$setC3")
			
			$r_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;vdACT_FechaPago))
			
			If ($t_accion="CalculaExentoDesdeCargos")
				OB SET:C1220($o_retorno;"monto_exento";$r_monto)
			Else 
				OB SET:C1220($o_retorno;"monto_afecto";$r_monto)
			End if 
			
		: ($t_accion="OnLoadVentanaPagos")
			C_BOOLEAN:C305($b_condicion)
			If (OB Is defined:C1231($o_param1))
				$o_configuracion:=$o_param1
			Else 
				$o_configuracion:=ACTdesc_OpcionesGenerales ("LeePreferencia")
			End if 
			$o_afecto:=OB Get:C1224($o_configuracion;"afecto")
			$o_exento:=OB Get:C1224($o_configuracion;"exento")
			
			$b_condicion:=(((OB Get:C1224($o_afecto;"permitir_modificar")=1) & (OB Get:C1224($o_afecto;"calcular_descuento")=1)) | (OB Get:C1224($o_afecto;"calcular_descuento")=0))
			OBJECT SET ENTERABLE:C238(vrACT_MontoDesctoAfecto;$b_condicion)
			OBJECT SET ENABLED:C1123(*;"btn_Afecto1";$b_condicion)
			
			$b_condicion:=(((OB Get:C1224($o_exento;"permitir_modificar")=1) & (OB Get:C1224($o_exento;"calcular_descuento")=1)) | (OB Get:C1224($o_exento;"calcular_descuento")=0))
			OBJECT SET ENTERABLE:C238(vrACT_MontoDesctoExento;$b_condicion)
			OBJECT SET ENABLED:C1123(*;"btn_Afecto2";$b_condicion)
			
	End case 
End if 

$0:=$o_retorno