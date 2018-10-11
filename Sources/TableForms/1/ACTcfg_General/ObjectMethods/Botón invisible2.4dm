ARRAY LONGINT:C221($al_decimales;5)
$al_decimales{1}:=0
$al_decimales{2}:=1
$al_decimales{3}:=2
$al_decimales{4}:=3
$al_decimales{5}:=4
$choice:=IT_PopUpMenu (->$al_decimales;-><>vlACT_NoDecimalesDespl)
If (($choice>0) & ($al_decimales{$choice}#<>vlACT_NoDecimalesDespl))
	vl_decimales:=$al_decimales{$choice}
	READ WRITE:C146([Colegio:31])
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	[Colegio:31]Numero_Decimales:53:=vl_decimales
	SAVE RECORD:C53([Colegio:31])
	KRL_UnloadReadOnly (->[Colegio:31])
	LOG_RegisterEvt ("Cambio de número de decimales por defecto. Cambió de "+String:C10(<>vlACT_NoDecimalesDespl)+" a "+String:C10(vl_decimales))
	<>vlACT_NoDecimalesDespl:=vl_decimales
	
	  //20170630 RCH para forzar la recarga
	  //SYS_OpenLangageResource 
	  //SET DATABASE LOCALIZATION("es")
	  //SYS_SetFormatResources 
	  //$t_idioma:=LOC_ObtieneReferencia 
	  //SET DATABASE LOCALIZATION($t_idioma)
	LOC_VerificaFormatos   //20171226 RCH
	
	  //20170118 RCH Ticket 193688
	CD_Dlog (0;"Si se necesita visualizar en SchoolNet el número de decimales recién configurado, se debe ingresar a la opción SchoolNet/Opciones de Envío, para realizar un envío de toda la información de Avisos de Cobranza.")
	
End if 