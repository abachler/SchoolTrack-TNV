//%attributes = {}
  // MPAcfg_Eje_AlGuardar()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/08/12, 17:42:27
  // ---------------------------------------------





  // CÓDIGO


C_LONGINT:C283($l_bitToSet;$l_Niveles)


  // CÓDIGO
If (Modified record:C314([MPA_DefinicionEjes:185]))
	[MPA_DefinicionDimensiones:188]DTS_Modificacion:18:=DTS_MakeFromDateTime 
	
	
	  // asignación del campo de ordenamiento utilizando los primeros 255 caracteres del nombre del eje
	  // (que puede almacenar hasta 2Gb, pero no es ordenable)
	[MPA_DefinicionEjes:185]AlphaSort:21:=Substring:C12([MPA_DefinicionEjes:185]Nombre:3;1;255)
	
	  // asignación del campo BitsNiveles según la etapa u otro modo (todas, específico por nivel)
	  // el bit correspondiente al nivel de aplicación es encendido u apagado según el caso
	Case of 
		: (([MPA_DefinicionEjes:185]DesdeGrado:4=-100) | ([MPA_DefinicionEjes:185]HastaGrado:5=-100))  // aplica en todas las etapas
			[MPA_DefinicionEjes:185]DesdeGrado:4:=-100
			[MPA_DefinicionEjes:185]HastaGrado:5:=-100
			[MPA_DefinicionEjes:185]Asignado_a_Etapa:19:=0
			$x_blobEtapas:=KRL_GetBlobFieldData (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionEjes:185]ID_Area:2;->[MPA_DefinicionAreas:186]xEtapas:10)
			BLOB_Blob2Vars (->$x_blobEtapas;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
			For ($iEtapas;1;Size of array:C274(alMPA_NivelDesde))
				For ($iNiveles;alMPA_NivelDesde{$iEtapas};alMPA_NivelHasta{$iEtapas})
					$l_bitToSet:=Find in array:C230(<>aNivNo;$iNiveles)
					[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $l_bitToSet
				End for 
			End for 
			
		: (([MPA_DefinicionEjes:185]DesdeGrado:4=999) | ([MPA_DefinicionEjes:185]HastaGrado:5=999))  // aplica en niveles especificos
			[MPA_DefinicionEjes:185]Asignado_a_Etapa:19:=0
			[MPA_DefinicionEjes:185]DesdeGrado:4:=999
			[MPA_DefinicionEjes:185]HastaGrado:5:=999
			
		Else   // aplica en los niveles asignados a la etapa
			[MPA_DefinicionEjes:185]Asignado_a_Etapa:19:=1
			[MPA_DefinicionEjes:185]BitsNiveles:20:=0
			For ($l_Niveles;[MPA_DefinicionEjes:185]DesdeGrado:4;[MPA_DefinicionEjes:185]HastaGrado:5)
				$l_bitToSet:=Find in array:C230(<>aNivNo;$l_Niveles)
				[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $l_bitToSet
			End for 
	End case 
	
	  // asigno el iusuario actual solo si no estoy dentro del trigger
	  // (que en cliente servidor no conoce el valor de la variable <>tUSR_CurrentUser)
	  // así este método puede ser llamado desde el formulario de propiedades o desde el trigger
	If (Trigger level:C398=0)
		[MPA_DefinicionEjes:185]ModificadoPor:8:=<>tUSR_CurrentUser
	End if 
	
End if 