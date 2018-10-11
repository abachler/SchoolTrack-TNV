Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_TEXT:C284(t_antiguoValor)
		C_LONGINT:C283(l_antiguoValor;l_nuevoValor;$l_posicion)
		
		ARRAY TEXT:C222(atACT_formasDePagoReemp;0)
		ARRAY LONGINT:C221(alACT_FormasdePagoIDReemp;0)
		
		l_antiguoValor:=vlACT_idFormaDePago
		l_nuevoValor:=0
		atACT_formasDePagoReemp:=0
		t_antiguoValor:=""
		
		  //se obtienen los elementos de los arreglos desplegados en las formas de pago
		COPY ARRAY:C226(atACT_FormasdePago;atACT_formasDePagoReemp)
		COPY ARRAY:C226(alACT_FormasdePagoID;alACT_FormasdePagoIDReemp)
		
		
		t_antiguoValor:=KRL_GetTextFieldData (->[ACT_Formas_de_Pago:287]id:1;->l_antiguoValor;->[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9)
		
		  //se borran de los arreglos temporales el elemento que reemplazaremos
		$l_posicion:=Find in array:C230(alACT_FormasdePagoID;l_antiguoValor)
		If ($l_posicion#0)
			AT_Delete ($l_posicion;1;->atACT_formasDePagoReemp;->alACT_FormasdePagoIDReemp)
		End if 
		
		  //20130822 RCH se quitan las formas de pago que no pueden reemplazar
		ARRAY LONGINT:C221($alACT_fpdNoR;0)
		C_LONGINT:C283($l_indice;$l_posicion)
		ACTcfgfdp_OpcionesGenerales ("FormasDePagoNOReemplazantes";->$alACT_fpdNoR)
		For ($l_indice;1;Size of array:C274($alACT_fpdNoR))
			$l_posicion:=Find in array:C230(alACT_FormasdePagoIDReemp;$alACT_fpdNoR{$l_indice})
			If ($l_posicion#0)
				AT_Delete ($l_posicion;1;->atACT_formasDePagoReemp;->alACT_FormasdePagoIDReemp)
			End if 
		End for 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Unload:K2:2)
		ARRAY TEXT:C222(atACT_formasDePagoReemp;0)
		
End case 