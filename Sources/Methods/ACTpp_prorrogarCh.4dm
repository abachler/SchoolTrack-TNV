//%attributes = {}
  //ACTpp_prorrogarCh

C_LONGINT:C283($maxProrrogaDias)
C_DATE:C307(vdACT_FechaProrroga;$FechaProrroga;$maxProrrogaFecha)

$line:=AL_GetLine (xALP_DocsenCartera)

READ WRITE:C146([ACT_Documentos_en_Cartera:182])
READ WRITE:C146([ACT_Documentos_de_Pago:176])
QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=aACT_ApdosDCarID{$line})
QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
$lockedDPago:=Locked:C147([ACT_Documentos_de_Pago:176])
$FechaProrroga:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5-1
vdACT_FechaProrroga:=$FechaProrroga
$r:=1
While (($FechaProrroga<[ACT_Documentos_en_Cartera:182]Fecha_Doc:5) & ($r=1) & ($FechaProrroga#!00-00-00!))
	$r:=CD_Dlog (0;__ ("Ingrese la fecha de prorroga");__ ("");__ ("Aceptar");__ ("Cancelar");__ ("");__ ("");String:C10(Current date:C33(*);7))
	$FechaProrroga:=Date:C102(vt_UserEntry)
	vdACT_FechaProrroga:=$FechaProrroga
End while 

If (($r=1) & (vdACT_FechaProrroga#!00-00-00!))
	If (Not:C34(($lockedCartera) | ($lockedDPago)))
		If ([ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10>$FechaProrroga)
			[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12:=$FechaProrroga
			Case of 
				: ([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12=Current date:C33(*))
					[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19:=0
					[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
				: ([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12>Current date:C33(*))
					[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19:=-4
					[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
					[ACT_Documentos_en_Cartera:182]Estado:9:=[ACT_Documentos_en_Cartera:182]Estado:9+". "+__ ("Depositar en ")+String:C10([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12-Current date:C33(*))+" "+__ ("días")+"."
			End case 
			SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
			[ACT_Documentos_de_Pago:176]id_estado:53:=[ACT_Documentos_en_Cartera:182]id_estado:21
			[ACT_Documentos_de_Pago:176]Estado:14:=[ACT_Documentos_en_Cartera:182]Estado:9
			  //SAVE RECORD([ACT_Documentos_de_Pago])
			ACTdp_fSave 
		Else 
			$maxProrrogaDias:=[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10-[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12-1
			$maxProrrogaFecha:=[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12+$maxProrrogaDias
			  //$msg:="El cheque No "+[ACT_Documentos_en_Cartera]Numero_Doc+" por $"+String([ACT_Documentos_en_Cartera]Monto_Doc;"|Despliegue_ACT")+" no puede ser prorrogado para esa fecha dado que"+◊cr+"se alcanzaría la fecha de vencimiento. La prorroga máxima posible "+"es para el "+String($maxProrrogaFecha)+"."+◊cr+◊cr+"¿Desea prorrogar a esta fecha?"
			  //$msg:=$msg+"se alcanzaría la fecha de vencimiento. La prorroga máxima posible "+"es para el "+String($maxProrrogaFecha)+"."+◊cr+◊cr
			  //$msg:=$msg+"¿Desea prorrogar a esta fecha?"
			$format:="|Despliegue_ACT"
			$action:=CD_Dlog (0;__ ("El cheque No ")+[ACT_Documentos_en_Cartera:182]Numero_Doc:6+__ (" por $")+String:C10([ACT_Documentos_en_Cartera:182]Monto_Doc:7;$format)+__ (" no puede ser prorrogado para esa fecha dado que\rse alcanzaría la fecha de vencimiento. La prorroga máxima posible es para el ")+String:C10($maxProrrogaFecha)+__ (".\r\r¿Desea prorrogar a esta fecha?");__ ("");__ ("Si");__ ("No"))
			If ($action=1)
				[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12:=$maxProrrogaFecha
				vdACT_FechaProrroga:=$maxProrrogaFecha
				[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19:=-4
				[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
				[ACT_Documentos_en_Cartera:182]Estado:9:=[ACT_Documentos_en_Cartera:182]Estado:9+". "+__ ("Depositar en ")+String:C10([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12-Current date:C33(*))+" "+__ ("días")+"."
				SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
				[ACT_Documentos_de_Pago:176]id_estado:53:=[ACT_Documentos_en_Cartera:182]id_estado:21
				[ACT_Documentos_de_Pago:176]Estado:14:=[ACT_Documentos_en_Cartera:182]Estado:9
				  //SAVE RECORD([ACT_Documentos_de_Pago])
				ACTdp_fSave 
			End if 
		End if 
	Else 
		BM_CreateRequest ("ACT_ProrrogaCheques";String:C10(vdACT_FechaProrroga)+";"+String:C10([ACT_Documentos_en_Cartera:182]ID:1))
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)
REDUCE SELECTION:C351([ACT_Documentos_en_Cartera:182];0)