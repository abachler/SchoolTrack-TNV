If (Form event:C388=On Clicked:K2:4)
	C_LONGINT:C283($i;$x)
	C_TEXT:C284(vt_msg)
	C_OBJECT:C1216($o_log)
	ARRAY TEXT:C222($at_nombrePropiedades;0)
	ARRAY OBJECT:C1221($ao_objetos;0)
	ARRAY TEXT:C222($at_nivNombre;0)
	ARRAY LONGINT:C221($al_noNiv;0)
	$o_log:=OB_Create 
	$o_log:=PREF_fGetObject (0;"LOG_PROMOCION_NIVEL";$o_log)
	$l_propiedades:=OB_GetChildNodes ($o_log;->$at_nombrePropiedades;->$ao_objetos)
	SORT ARRAY:C229($at_nombrePropiedades;$ao_objetos;<)
	
	For ($i;1;Size of array:C274($ao_objetos))
		OB GET ARRAY:C1229($ao_objetos{$i};"NoNiveles";$al_noNiv)
		OB GET ARRAY:C1229($ao_objetos{$i};"Niveles";$at_nivNombre)
		$t_usuario:=OB Get:C1224($ao_objetos{$i};"usuario")
		vt_msg:=vt_msg+$at_nombrePropiedades{$i}+", usuario "+$t_usuario+":\n"
		For ($x;1;Size of array:C274($at_nivNombre))
			vt_msg:=vt_msg+$at_nivNombre{$x}+" ("+String:C10($al_noNiv{$x})+")\n"
		End for 
	End for 
	
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"CMT_Console";-1;5;__ ("Log promociones anteriores"))
	DIALOG:C40([xxSTR_Constants:1];"CMT_Console")
	CLOSE WINDOW:C154
	vt_msg:=""
End if 