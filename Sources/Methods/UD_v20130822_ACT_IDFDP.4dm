//%attributes = {}
  //UD_v20130822_ACT_IDFDP 

  //20130822 RCH HABIA UN PROBLEMA CON UNA BD PORQUE HABIAN PAGOS CON ID FDP 0 ASOCIADOS A LETRA.

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($l_id_FDP;$l_proc)
	C_TEXT:C284($t_glosa_FDP)
	
	READ WRITE:C146([ACT_Pagos:172])
	READ WRITE:C146([ACT_Documentos_de_Pago:176])
	READ WRITE:C146([ACT_Documentos_en_Cartera:182])
	
	ACTfdp_CargaFormasDePago 
	
	$l_id_FDP:=-8
	$t_glosa_FDP:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->$l_id_FDP)
	
	$l_proc:=IT_UThermometer (1;0;"Verificando ids de formas de pago Letra...")
	
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=0;*)
	QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]FormaDePago:7="Letra")
	
	APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30:=$l_id_FDP)
	APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]forma_de_pago_new:31:=$t_glosa_FDP)
	
	KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
	APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=$l_id_FDP)
	APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=$t_glosa_FDP)
	
	KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19:=$l_id_FDP)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]forma_de_pago_new:20:=$t_glosa_FDP)
	
	IT_UThermometer (-2;$l_proc)
	
	KRL_UnloadReadOnly (->[ACT_Pagos:172])
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
	KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
End if 