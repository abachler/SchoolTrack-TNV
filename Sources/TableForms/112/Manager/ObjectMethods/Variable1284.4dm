$line:=AL_GetLine (xALP_PostHist)
If ($line>0)
	$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar este registro de postulación histórico? Recuerde que la eliminación es irreversible.");__ ("");__ ("Si");__ ("No"))
	If ($r=1)
		READ WRITE:C146([xxADT_PostulacionesHistoricas:112])
		QUERY:C277([xxADT_PostulacionesHistoricas:112];[xxADT_PostulacionesHistoricas:112]ID:4=alADT_IDPH{$line})
		If (Records in selection:C76([xxADT_PostulacionesHistoricas:112])=1)
			If (Not:C34(Locked:C147([xxADT_PostulacionesHistoricas:112])))
				$rut:=[xxADT_PostulacionesHistoricas:112]RUT:1
				DELETE RECORD:C58([xxADT_PostulacionesHistoricas:112])
				AL_UpdateArrays (xALP_PostHist;0)
				PST_LoadPostHist ($rut)
				AL_UpdateArrays (xALP_PostHist;-2)
				PST_InitVariablesPH 
			Else 
				CD_Dlog (0;__ ("El registro está en uso por otro usuario o proceso. Intente eliminarlo más tarde."))
			End if 
		End if 
	End if 
End if 