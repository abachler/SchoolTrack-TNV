//%attributes = {}
  //MNU_TransportTrack

C_LONGINT:C283(<>TTrackProcessID)
If (LICENCIA_esModuloAutorizado (1;TransportTrack))
	If (USR_GetMethodAcces (Current method name:C684))
		$TT:=Process number:C372("TransportTrack")
		$state:=Process state:C330($TT)
		Case of 
			: ($state<=0)
				$proc:=New process:C317("BU_Configuracion";Pila_256K;"TransportTrack")
			: (($state=5) | ($state=1))
				RESUME PROCESS:C320($TT)
				SHOW PROCESS:C325($TT)
				BRING TO FRONT:C326($TT)
			: ($state=6)
				SHOW PROCESS:C325($TT)
				BRING TO FRONT:C326($TT)
			Else 
				BRING TO FRONT:C326($TT)
		End case 
	End if 
Else 
	CD_Dlog (0;__ ("Lo siento, su licencia no le permite ejecutar esta extensión."))
End if 