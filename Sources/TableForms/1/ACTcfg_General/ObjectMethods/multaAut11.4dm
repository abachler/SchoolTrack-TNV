If (cs_GenerarMultaDia1#cs_GenerarMultaDia1_2)
	C_LONGINT:C283($vl_records;$vl_resp)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
	READ ONLY:C145([ACT_Cargos:173])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"";*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($vl_records#0)
		  //20111013 RCH Ya no se eliminan los recargos...
		  //$vl_resp:=CD_Dlog (0;"Al cambiar esta opción los recargos ya generados no pagados serán eliminados dura"+"nte el próximo recálculo de recargos."+<>cr+<>cr+"¿Desea continuar?";"";"Si";"No")
		  //If ($vl_resp=1)
		PREF_Set (0;"ACT_EliminaRecargosAut";"1")
		  //Else 
		  //cs_GenerarMultaDia1:=cs_GenerarMultaDia1_2
		  //End if 
	End if 
Else 
	PREF_Set (0;"ACT_EliminaRecargosAut";"0")
End if 
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)