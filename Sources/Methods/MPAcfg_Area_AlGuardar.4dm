//%attributes = {}
  // MPAcfg_Area_AlGuardar()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/07/12, 11:08:31
  // ---------------------------------------------





  // CÓDIGO
If ([MPA_DefinicionAreas:186]ID:1=0)
	[MPA_DefinicionAreas:186]ID:1:=SQ_SeqNumber (->[MPA_DefinicionAreas:186]ID:1)
End if 
[MPA_DefinicionAreas:186]DTS_Modificacion:2:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))



  // si el nivel de trigger es 0 este metodo no es llamado desde el trigger
  // se ejecuta el código que debe ejecutarse normalmente al guardar el registro desde el formulario
If (Trigger level:C398=0)
	READ ONLY:C145([xxSTR_Niveles:6])
	For ($i;Size of array:C274(atMPA_EtapasArea);1;-1)
		$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;alMPA_NivelDesde{$i})
		If ($recNum>=0)
			GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
			If (alMPA_NivelHasta{$i}=-100)
				alMPA_NivelHasta{$i}:=<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)}
			End if 
			
		Else 
			AT_Delete ($i;1;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta;->atMPA_NivelDesde;->atMPA_NivelHasta)
		End if 
	End for 
	BLOB_Variables2Blob (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	[MPA_DefinicionAreas:186]ModificadoPor:3:=<>tUSR_CurrentUser
End if 