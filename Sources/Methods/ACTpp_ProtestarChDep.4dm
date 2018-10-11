//%attributes = {}
  //ACTpp_ProtestarChDep

C_DATE:C307(vdACT_FechaProrroga;$FechaProrroga)

$line:=AL_GetLine (xALP_DocsDepositados)

READ WRITE:C146([ACT_Documentos_de_Pago:176])

QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=aACT_ApdosDDID{$line})

$r:=CD_Dlog (0;__ ("Ingrese la fecha de protesto");__ ("");__ ("Aceptar");__ ("Cancelar");__ ("");__ ("");String:C10(Current date:C33(*);7))
$FechaProtesto:=Date:C102(vt_UserEntry)
vdACT_FechaProtesto:=$FechaProtesto

If (($r=1) & (vdACT_FechaProtesto#!00-00-00!))
	
	If (Not:C34(Locked:C147([ACT_Documentos_de_Pago:176])))
		
		vdACT_FechaProtesto:=$FechaProtesto
		[ACT_Documentos_de_Pago:176]FechaProtesto:15:=vdACT_FechaProtesto
		  //[ACT_Documentos_de_Pago]Estado:="Protestado."
		  //[ACT_Documentos_de_Pago]id_estado:=-2
		[ACT_Documentos_de_Pago:176]id_estado:53:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
		[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
		[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
		[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
		
		  //SAVE RECORD([ACT_Documentos_de_Pago])
		ACTdp_fSave 
		
		ACTdc_CreaDocCarteraProt 
		
	Else 
		
		$Params:=ST_Concatenate (";";->vdACT_FechaProtesto;->[ACT_Documentos_de_Pago:176]ID:1)
		BM_CreateRequest ("ACT_ProtestaCheques";$Params)
		
	End if 
	
End if 

UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
READ ONLY:C145([ACT_Documentos_de_Pago:176])
READ ONLY:C145([ACT_Documentos_en_Cartera:182])

REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)
