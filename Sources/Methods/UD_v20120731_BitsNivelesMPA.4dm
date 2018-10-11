//%attributes = {}


<>vb_ImportHistoricos_STX:=True:C214
ARRAY TEXT:C222(atMPA_EtapasArea;0)
ARRAY LONGINT:C221(alMPA_NivelDesde;0)
ARRAY LONGINT:C221(alMPA_NivelHasta;0)

ALL RECORDS:C47([MPA_DefinicionAreas:186])

ARRAY LONGINT:C221($aRecNumAreas;0)
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionAreas:186];$aRecNumAreas;"")
For ($iAreas;1;Size of array:C274($aRecNumAreas))
	GOTO RECORD:C242([MPA_DefinicionAreas:186];$aRecNumAreas{$iAreas})
	ARRAY TEXT:C222(atMPA_EtapasArea;0)
	ARRAY LONGINT:C221(alMPA_NivelDesde;0)
	ARRAY LONGINT:C221(alMPA_NivelHasta;0)
	BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	
	
	QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=[MPA_DefinicionAreas:186]ID:1)
	ARRAY LONGINT:C221($al_recNums;0)
	LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$al_recNums;"")
	For ($i;1;Size of array:C274($al_recNums))
		READ WRITE:C146([MPA_DefinicionEjes:185])
		GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_recNums{$i})
		Case of 
			: (([MPA_DefinicionEjes:185]DesdeGrado:4=-100) | ([MPA_DefinicionEjes:185]HastaGrado:5=-100))
				[MPA_DefinicionEjes:185]DesdeGrado:4:=-100
				[MPA_DefinicionEjes:185]HastaGrado:5:=-100
				[MPA_DefinicionEjes:185]BitsNiveles:20:=0
				For ($iEtapas;1;Size of array:C274(alMPA_NivelDesde))
					For ($iNiveles;alMPA_NivelDesde{$iEtapas};alMPA_NivelHasta{$iEtapas})
						$l_bitToSet:=Find in array:C230(<>aNivNo;$iNiveles)
						[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $l_bitToSet
					End for 
				End for 
				
			: (([MPA_DefinicionEjes:185]DesdeGrado:4=999) | ([MPA_DefinicionEjes:185]HastaGrado:5=999))
				[MPA_DefinicionEjes:185]DesdeGrado:4:=999
				[MPA_DefinicionEjes:185]HastaGrado:5:=999
				For ($iBits;1;Size of array:C274(<>aNivNo))
					$l_EtapaNivel:=0
					For ($iNiveles;1;Size of array:C274(alMPA_NivelDesde))
						If ((<>aNivNo{$iBits}>=alMPA_NivelDesde{$iNiveles}) & (<>aNivNo{$iBits}<=alMPA_NivelHasta{$iNiveles}))
							$l_EtapaNivel:=$iNiveles
							$iNiveles:=Size of array:C274(alMPA_NivelDesde)
						End if 
					End for 
					If ($l_EtapaNivel<=0)
						[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?- $iBits
					End if 
				End for 
			Else 
				[MPA_DefinicionEjes:185]BitsNiveles:20:=0
				For ($l_niveles;[MPA_DefinicionEjes:185]DesdeGrado:4;[MPA_DefinicionEjes:185]HastaGrado:5)
					$l_bitToSet:=Find in array:C230(<>aNivNo;$l_niveles)
					If ($l_bitToSet>0)
						[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $l_bitToSet
					End if 
				End for 
		End case 
		SAVE RECORD:C53([MPA_DefinicionEjes:185])
	End for 
	KRL_UnloadReadOnly (->[MPA_DefinicionEjes:185])
	
	
	QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=[MPA_DefinicionAreas:186]ID:1)
	ARRAY LONGINT:C221($al_recNums;0)
	LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$al_recNums;"")
	For ($i;1;Size of array:C274($al_recNums))
		READ WRITE:C146([MPA_DefinicionDimensiones:188])
		GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNums{$i})
		Case of 
			: (([MPA_DefinicionDimensiones:188]DesdeGrado:6=-100) | ([MPA_DefinicionDimensiones:188]HastaGrado:7=-100))
				[MPA_DefinicionDimensiones:188]DesdeGrado:6:=-100
				[MPA_DefinicionDimensiones:188]HastaGrado:7:=-100
				[MPA_DefinicionDimensiones:188]BitsNiveles:21:=0
				For ($iEtapas;1;Size of array:C274(alMPA_NivelDesde))
					For ($iNiveles;alMPA_NivelDesde{$iEtapas};alMPA_NivelHasta{$iEtapas})
						$l_bitToSet:=Find in array:C230(<>aNivNo;$iNiveles)
						[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?+ $l_bitToSet
					End for 
				End for 
				
			: (([MPA_DefinicionDimensiones:188]DesdeGrado:6=999) | ([MPA_DefinicionDimensiones:188]HastaGrado:7=999))
				[MPA_DefinicionDimensiones:188]DesdeGrado:6:=999
				[MPA_DefinicionDimensiones:188]HastaGrado:7:=999
				$l_bitsNivelesEje:=KRL_GetNumericFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionDimensiones:188]ID_Eje:3;->[MPA_DefinicionDimensiones:188]BitsNiveles:21)
				For ($iBits;1;24)
					If (([MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $iBits) & (Not:C34($l_bitsNivelesEje ?? $iBits)))
						[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?- $iBits
					End if 
				End for 
			Else 
				[MPA_DefinicionDimensiones:188]BitsNiveles:21:=0
				For ($l_niveles;[MPA_DefinicionDimensiones:188]DesdeGrado:6;[MPA_DefinicionDimensiones:188]HastaGrado:7)
					$l_bitToSet:=Find in array:C230(<>aNivNo;$l_niveles)
					If ($l_bitToSet>0)
						[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?+ $l_bitToSet
					End if 
				End for 
		End case 
		SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
	End for 
	KRL_UnloadReadOnly (->[MPA_DefinicionDimensiones:188])
	
	
	
	QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=[MPA_DefinicionAreas:186]ID:1)
	ARRAY LONGINT:C221($al_recNums;0)
	LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNums;"")
	For ($i;1;Size of array:C274($al_recNums))
		READ WRITE:C146([MPA_DefinicionCompetencias:187])
		GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNums{$i})
		Case of 
			: (([MPA_DefinicionCompetencias:187]DesdeGrado:5=-100) | ([MPA_DefinicionCompetencias:187]HastaGrado:13=-100))
				[MPA_DefinicionCompetencias:187]DesdeGrado:5:=-100
				[MPA_DefinicionCompetencias:187]HastaGrado:13:=-100
				[MPA_DefinicionCompetencias:187]BitNiveles:28:=0
				For ($iEtapas;1;Size of array:C274(alMPA_NivelDesde))
					For ($iNiveles;alMPA_NivelDesde{$iEtapas};alMPA_NivelHasta{$iEtapas})
						$l_bitToSet:=Find in array:C230(<>aNivNo;$iNiveles)
						[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_bitToSet
					End for 
				End for 
				
			: (([MPA_DefinicionCompetencias:187]DesdeGrado:5=999) | ([MPA_DefinicionCompetencias:187]HastaGrado:13=999))
				[MPA_DefinicionCompetencias:187]DesdeGrado:5:=999
				[MPA_DefinicionCompetencias:187]HastaGrado:13:=999
				
				Case of 
					: ([MPA_DefinicionCompetencias:187]ID_Dimension:23#0)
						$l_bitsNivelesDimension:=KRL_GetNumericFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]BitsNiveles:21)
						For ($iBits;1;24)
							If (([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $iBits) & (Not:C34($l_bitsNivelesDimension ?? $iBits)))
								[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?- $iBits
							End if 
						End for 
						
					: ([MPA_DefinicionCompetencias:187]ID_Eje:2#0)
						$l_bitsNivelesEje:=KRL_GetNumericFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]BitsNiveles:20)
						For ($iBits;1;24)
							If (([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $iBits) & (Not:C34($l_bitsNivelesEje ?? $iBits)))
								[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?- $iBits
							End if 
						End for 
						
					Else 
						For ($iBits;1;Size of array:C274(<>aNivNo))
							$l_EtapaNivel:=0
							For ($iNiveles;1;Size of array:C274(alMPA_NivelDesde))
								If ((<>aNivNo{$iBits}>=alMPA_NivelDesde{$iNiveles}) & (<>aNivNo{$iBits}<=alMPA_NivelHasta{$iNiveles}))
									$l_EtapaNivel:=$iNiveles
									$iNiveles:=Size of array:C274(alMPA_NivelDesde)
								End if 
							End for 
							If ($l_EtapaNivel<=0)
								[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?- $iBits
							End if 
						End for 
				End case 
				
				
			Else 
				[MPA_DefinicionCompetencias:187]BitNiveles:28:=0
				For ($l_niveles;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13)
					$l_bitToSet:=Find in array:C230(<>aNivNo;$l_Niveles)
					If ($l_bitToSet>0)
						[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_bitToSet
					End if 
				End for 
		End case 
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
	End for 
	KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])
End for 
<>vb_ImportHistoricos_STX:=False:C215






