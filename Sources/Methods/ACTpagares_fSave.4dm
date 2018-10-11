//%attributes = {}
C_LONGINT:C283($0)
C_BOOLEAN:C305($vb_calcula)
C_TEXT:C284(vtACTpagares_idMov)

vtACTpagares_idMov:=""

If ([ACT_Pagares:184]Fecha_Protesto:20#!00-00-00!)
	Case of 
		: (Old:C35([ACT_Pagares:184]Fecha_Protesto:20)=!00-00-00!)
			$vt_evento:="Protesto de Pagaré."
			ACTcfg_OpcionesPagares ("Log";->$vt_evento)
			
		: (Old:C35([ACT_Pagares:184]Fecha_Protesto:20)#[ACT_Pagares:184]Fecha_Protesto:20)
			$vt_evento:="Cambio en fecha de protesto de Pagaré. Cambió de "+String:C10(Old:C35([ACT_Pagares:184]Fecha_Protesto:20))+" a "+String:C10([ACT_Pagares:184]Fecha_Protesto:20)+"."
			ACTcfg_OpcionesPagares ("Log";->$vt_evento)
			
	End case 
Else 
	Case of 
		: (Old:C35([ACT_Pagares:184]Fecha_Devolucion:14)#!00-00-00!)
			$vt_evento:="Cambio de estado de campo Devolución de Pagaré. Cambió de marcado a desmarcado."
			ACTcfg_OpcionesPagares ("Log";->$vt_evento)
			
	End case 
End if 

If ([ACT_Pagares:184]Fecha_Devolucion:14#!00-00-00!)
	Case of 
		: (Old:C35([ACT_Pagares:184]Fecha_Devolucion:14)=!00-00-00!)
			$vt_evento:="Devolución de Pagaré."
			ACTcfg_OpcionesPagares ("Log";->$vt_evento)
			
		: (Old:C35([ACT_Pagares:184]Fecha_Devolucion:14)#[ACT_Pagares:184]Fecha_Devolucion:14)
			$vt_evento:="Cambio en fecha de devolución de Pagaré. Cambió de "+String:C10(Old:C35([ACT_Pagares:184]Fecha_Devolucion:14))+" a "+String:C10([ACT_Pagares:184]Fecha_Devolucion:14)+"."
			ACTcfg_OpcionesPagares ("Log";->$vt_evento)
			
	End case 
Else 
	Case of 
		: (Old:C35([ACT_Pagares:184]Fecha_Protesto:20)#!00-00-00!)
			$vt_evento:="Cambio de estado de campo Protesto de Pagaré. Cambió de marcado a desmarcado."
			ACTcfg_OpcionesPagares ("Log";->$vt_evento)
			
	End case 
End if 

If ((Old:C35([ACT_Pagares:184]ID_Estado:6)#[ACT_Pagares:184]ID_Estado:6) | (Is new record:C668([ACT_Pagares:184])))
	[ACT_Pagares:184]Estado:24:=ACTcfg_OpcionesPagares ("ObtieneEstadoXID";->[ACT_Pagares:184]ID_Estado:6)
End if 

vtACTpagares_idMov:=ACTcfg_OpcionesMovimientos ("ValidaCambioEstadoPagares")

If (([ACT_Pagares:184]ID_Estado:6=-101) | (Old:C35([ACT_Pagares:184]ID_Estado:6)=-101))
	$vb_calcula:=True:C214
End if 

SAVE RECORD:C53([ACT_Pagares:184])

If ($vb_calcula)
	ACTpp_OpcionesCalculoMontos ("CalculaDesdeArreglosIdsApdoTerceros";->[ACT_Pagares:184]ID_Apdo:17;->[ACT_Pagares:184]ID_Tercero:22)
End if 

$0:=1