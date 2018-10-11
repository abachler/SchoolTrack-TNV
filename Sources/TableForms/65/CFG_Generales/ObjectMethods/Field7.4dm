C_BOOLEAN:C305(<>CreandoMARC)
If (Form event:C388=On Clicked:K2:4)
	If (Self:C308->)
		If (Application type:C494=4D Remote mode:K5:5)
			$r:=CD_Dlog (0;__ ("MediaTrack creará ahora los registros MARC en el servidor. Este proceso puede ser largo. ¿Desea proseguir?");__ ("");__ ("Proseguir");__ ("Cancelar"))
		Else 
			$r:=CD_Dlog (0;__ ("MediaTrack creará ahora los registros MARC. Este proceso puede ser largo. ¿Desea proseguir?");__ ("");__ ("Proseguir");__ ("Cancelar"))
		End if 
		If ($r=1)
			If (Not:C34(Semaphore:C143("MARC")))
				$creando:=True:C214
				$uther:=IT_UThermometer (1;0;__ ("Creando registros MARC..."))
				$p:=Execute on server:C373("dbuMT_RecreaRegistrosMARC";Pila_256K;"Creando registro MARC...")
				If (Application type:C494#4D Remote mode:K5:5)
					While ($creando)
						DELAY PROCESS:C323(Current process:C322;60)
						$creando:=<>CreandoMARC
					End while 
				Else 
					While ($creando)
						GET PROCESS VARIABLE:C371(-1;<>CreandoMARC;$creando)
						DELAY PROCESS:C323(Current process:C322;60)
					End while 
				End if 
				CLEAR SEMAPHORE:C144("MARC")
				IT_UThermometer (-2;$uther)
			Else 
				CD_Dlog (0;__ ("Otro usuario ya está operando sobre los registros MARC."))
			End if 
		Else 
			Self:C308->:=False:C215
		End if 
	Else 
		$r:=CD_Dlog (0;__ ("MediaTrack eliminará ahora los registros MARC. ¿Desea proseguir?");__ ("");__ ("Proseguir");__ ("Cancelar"))
		If ($r=1)
			If (Not:C34(Semaphore:C143("MARC")))
				$uther:=IT_UThermometer (1;0;__ ("Eliminado registros MARC..."))
				KRL_ClearTable (->[BBL_ItemMarcFields:205])
				FLUSH CACHE:C297
				IT_UThermometer (-2;$uther)
				CLEAR SEMAPHORE:C144("MARC")
			Else 
				CD_Dlog (0;__ ("Otro usuario ya está operando sobre los registros MARC."))
			End if 
		Else 
			Self:C308->:=True:C214
		End if 
	End if 
End if 

