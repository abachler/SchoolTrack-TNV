If ([ACT_Pagares:184]Fecha_Protesto:20#!00-00-00!)
	Case of 
		: (Old:C35([ACT_Pagares:184]Fecha_Protesto:20)=!00-00-00!)
			$vt_evento:="Protesto de Pagaré."
			ACTcfg_OpcionesPagares ("Log";->$vt_evento)
			
		: (Old:C35([ACT_Pagares:184]Fecha_Protesto:20)#[ACT_Pagares:184]Fecha_Protesto:20)
			$vt_evento:="Cambio en fecha de protesto de Pagaré. Cambió de "+String:C10(Old:C35([ACT_Pagares:184]Fecha_Protesto:20))+" a "+String:C10([ACT_Pagares:184]Fecha_Protesto:20)+"."
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
End if 

If ([ACT_Pagares:184]Fecha_Protesto:20=!00-00-00!)
	Case of 
		: (Old:C35([ACT_Pagares:184]Fecha_Protesto:20)#!00-00-00!)
			$vt_evento:="Cambio de estado de campo Protesto de Pagaré. Cambió de marcado a desmarcado."
			ACTcfg_OpcionesPagares ("Log";->$vt_evento)
			
	End case 
End if 
If ([ACT_Pagares:184]Fecha_Devolucion:14=!00-00-00!)
	Case of 
		: (Old:C35([ACT_Pagares:184]Fecha_Devolucion:14)=!00-00-00!)
			$vt_evento:="Cambio de estado de campo Devolución de Pagaré. Cambió de marcado a desmarcado."
			ACTcfg_OpcionesPagares ("Log";->$vt_evento)
			
	End case 
End if 