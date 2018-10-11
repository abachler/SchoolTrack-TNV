C_LONGINT:C283($l_recs)
READ ONLY:C145([xxACT_Items:179])
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]AfectoDsctoIndividual:17=True:C214)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If (cbUsarDescuentosIndividual=0)
	$l_resp:=CD_Dlog (0;"Recuerde que esta configuración será aplicada solamente si la opción "+ST_Qte ("Aplicar descuentos individuales")+" está marcada."+"\r\r"+"¿Desea marcarla?";"";"Si";"No")
	If ($l_resp=1)
		cbUsarDescuentosIndividual:=1
		LOG_RegisterChangeConf (OBJECT Get title:C1068(cbUsarDescuentosIndividual);cbUsarDescuentosIndividual)
	End if 
End if 
If ($l_recs=0)
	CD_Dlog (0;"Recuerde que para que esta configuración sea aplicada deberá marcar la opción "+ST_Qte ("Afecto a descuento individual")+", en la configuración de los Ítems de Cargo.")
End if 
TRACE:C157
ACTcfg_OpcionesDescuentos ("InsertaLinea")