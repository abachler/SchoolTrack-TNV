//%attributes = {}
  //ACTpp_ProtestarL

$line:=AL_GetLine (xALP_DocsenCartera)
READ WRITE:C146([ACT_Documentos_en_Cartera:182])
QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=aACT_ApdosDCarID{$line})
$r:=CD_Dlog (0;__ ("Ingrese la fecha de protesta");__ ("");__ ("Aceptar");__ ("Cancelar");__ ("");__ ("");String:C10(Current date:C33(*);7))
$FechaProtesto:=Date:C102(vt_UserEntry)
If (($r=1) & ($FechaProtesto#!00-00-00!))
	[ACT_Documentos_en_Cartera:182]L_Protestadoel:15:=$FechaProtesto
	  //[ACT_Documentos_en_Cartera]id_estado:=-2
	[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
	[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
	SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
	UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
	READ ONLY:C145([ACT_Documentos_en_Cartera:182])
End if 
REDUCE SELECTION:C351([ACT_Documentos_en_Cartera:182];0)