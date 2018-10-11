  //C_LONGINT($vl_col;$vl_line;$vl_inc)
  //C_POINTER($vy_var)
  //C_REAL($vr_descuento)

  //LISTBOX GET CELL POSITION(lb_listadoSet;$vl_col;$vl_line;$vy_var)
ARRAY LONGINT:C221($DA_Return;0)
lb_listadoSet{0}:=True:C214
AT_SearchArray (->lb_listadoSet;"=";->$DA_Return)

If (Size of array:C274($DA_Return)>0)
	$resp:=CD_Dlog (0;"Se quitará la relación de la boleta a "+String:C10(Size of array:C274($DA_Return))+" líneas, sin ninguna verificación adicional."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
Else 
	$resp:=0
End if 
If ($resp=1)
	  // actualiza ids boletas eliminadas
	
	For ($i;1;Size of array:C274($DA_Return))
		If (lb_listadoSet{$DA_Return{$i}})
			$vt_pref:=atACT_Text{$DA_Return{$i}}
			ACTdte_setPruebasOpcionesGen ("DesarmaBlob";->$vt_pref)
			vlACT_idBoleta:=0
			vbACT_editaCaso:=True:C214
			ACTdte_setPruebasOpcionesGen ("GuardaCaso")
			vbACT_editaCaso:=False:C215
		End if 
	End for 
	ACTdte_setPruebasOpcionesGen ("InitVars")
End if 
