//%attributes = {}
  //ACTdc_ProrrogaCheques

$0:=True:C214

vdACT_FechaProrroga:=Date:C102(Substring:C12($1;1;Position:C15(";";$1)-1))
$IDDocC:=Num:C11(Substring:C12($1;Position:C15(";";$1)+1))

READ WRITE:C146([ACT_Documentos_en_Cartera:182])
READ WRITE:C146([ACT_Documentos_de_Pago:176])
QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=$IDDocC)
QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
If ([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12#vdACT_FechaProrroga)
	$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
	$lockedPagos:=Locked:C147([ACT_Documentos_de_Pago:176])
	If (Not:C34(($lockedCartera) | ($lockedPagos)))
		[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12:=vdACT_FechaProrroga
		[ACT_Documentos_de_Pago:176]Prorrogado:46:=True:C214
		[ACT_Documentos_de_Pago:176]Prorrogado_datos:47:=[ACT_Documentos_de_Pago:176]Prorrogado_datos:47+DTS_MakeFromDateTime +"-"+<>tUSR_CurrentUser+"-"+DTS_MakeFromDateTime (vdACT_FechaProrroga)+"\r"
		LOG_RegisterEvt ("Cheque prorrogado: Número de serie: "+[ACT_Documentos_de_Pago:176]NoSerie:12+". Banco: "+[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7+". Apoderado: "+KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Documentos_de_Pago:176]ID_Apoderado:2;->[Personas:7]Apellidos_y_nombres:30)+". Fecha prórroga: "+String:C10(vdACT_FechaProrroga)+".")
		  //SAVE RECORD([ACT_Documentos_de_Pago])
		ACTdp_fSave 
		ACTdc_EstadoCheque 
		READ ONLY:C145([ACT_Documentos_en_Cartera:182])
		REDUCE SELECTION:C351([ACT_Documentos_en_Cartera:182];0)
	Else 
		$0:=False:C215
	End if 
End if 