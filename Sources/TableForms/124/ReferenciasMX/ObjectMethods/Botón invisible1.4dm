If (vtACT_referenciaBusqueda#"")
	  //20170120 RCH Esto estaba cambiando el número. Por ejemplo para el número 400701000001315064268 dejaba 4,007010000013e+20
	  //vtACT_referenciaBusqueda:=String(Num(vtACT_referenciaBusqueda)) 
	  //If (Length(vtACT_referenciaBusqueda)<16)
	  //vtACT_referenciaBusqueda:=ST_RigthChars (("0"*16)+vtACT_referenciaBusqueda;16)
	  //End if 
	$l_linea:=Num:C11(ACT_OpcionesReferenciasMX ("busca";->vtACT_referenciaBusqueda))
	If ($l_linea>0)
		LISTBOX SELECT ROW:C912(lb_referencias;1)
	End if 
Else 
	BEEP:C151
End if 