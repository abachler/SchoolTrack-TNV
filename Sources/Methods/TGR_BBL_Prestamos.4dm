//%attributes = {}
  // TGR_BBL_Prestamos()
  // Por: Alberto Bachler: 16/11/13, 19:29:50
  //  ---------------------------------------------
  // 
  //
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)


If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				If ([BBL_Prestamos:60]Número_de_Transacción:8=0)  //es importación alexandria
					[BBL_Prestamos:60]Número_de_Transacción:8:=SQ_SeqNumber (->[BBL_Prestamos:60]Número_de_Transacción:8)
					If ([BBL_Prestamos:60]Número_de_Item:11=0)
						RELATE ONE:C42([BBL_Prestamos:60]Número_de_registro:1)
						[BBL_Prestamos:60]Número_de_Item:11:=[BBL_Registros:66]Número_de_item:1
					End if 
					If (([BBL_Prestamos:60]Fecha_de_devolución:5#!00-00-00!) & ([BBL_Prestamos:60]Desde:3#!00-00-00!))
						[BBL_Prestamos:60]Duración:6:=[BBL_Prestamos:60]Fecha_de_devolución:5-[BBL_Prestamos:60]Desde:3+1
					End if 
				End if 
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If (([BBL_Prestamos:60]Días_de_atraso:15>0) & (Old:C35([BBL_Prestamos:60]Días_de_atraso:15)=0))
					READ WRITE:C146([BBL_Lectores:72])
					RELATE ONE:C42([BBL_Prestamos:60]Número_de_lector:2)
					[BBL_Lectores:72]Atrasos:24:=[BBL_Lectores:72]Atrasos:24+1
					SAVE RECORD:C53([BBL_Lectores:72])
					KRL_ReloadAsReadOnly (->[BBL_Lectores:72])
				End if 
				
		End case 
	End if 
	SN3_MarcarRegistros (SN3_DTi_Prestamos)
End if 




