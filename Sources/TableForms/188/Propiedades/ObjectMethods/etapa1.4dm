C_TEXT:C284(vtMPA_NivelesEtapa)
COPY ARRAY:C226(atMPA_EtapasArea;$aEtapas)
For ($i;1;Size of array:C274($aEtapas))
	$el:=Find in array:C230(<>al_NumeroNivelesActivos;alMPA_NivelDesde{$i})
	If ($el>0)
		$desde:=<>at_NombreNivelesActivos{$el}
	Else 
		$desde:="?"
	End if 
	$el:=Find in array:C230(<>al_NumeroNivelesActivos;alMPA_NivelHasta{$i})
	If ($el>0)
		$hasta:=<>at_NombreNivelesActivos{$el}
	Else 
		$hasta:="?"
	End if 
	
	If ($desde#$hasta)
		$aEtapas{$i}:=$aEtapas{$i}+" ["+$desde+" a "+$hasta+"]"
	Else 
		$aEtapas{$i}:=$aEtapas{$i}+" ["+$desde+"]"
	End if 
	$aEtapas{$i}:=Replace string:C233($aEtapas{$i};"(";"")
	$aEtapas{$i}:=Replace string:C233($aEtapas{$i};")";"")
End for 
  //$result:=Pop up menu(AT_array2text (->$aEtapas;";")+";(-;Todas";0)
$result:=Pop up menu:C542(AT_array2text (->$aEtapas;";")+";(-;Todas;Asignación por nivel...";0)

If ($result>0)
	If (Is new record:C668([MPA_DefinicionDimensiones:188]))
		Case of 
			: ($result=(Size of array:C274(atMPA_EtapasArea)+3))
				vtMPA_EtapaObjeto:="Asignación por nivel"
				[MPA_DefinicionDimensiones:188]DesdeGrado:6:=999
				[MPA_DefinicionDimensiones:188]HastaGrado:7:=999
				  //For ($i;alMPA_NivelDesde{atMPA_EtapasArea};alMPA_NivelHasta{atMPA_EtapasArea})
				  //$l_bitToSet:=Find in array(<>al_NumeroNivelesActivos;$i)
				  //[MPA_DefinicionDimensiones]BitsNiveles:=[MPA_DefinicionDimensiones]BitsNiveles ?+ $l_bitToSet
				  //End for 
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;True:C214)
				
			: ($result>Size of array:C274(atMPA_EtapasArea))
				vtMPA_EtapaObjeto:="Todos los niveles"
				[MPA_DefinicionDimensiones:188]DesdeGrado:6:=-100
				[MPA_DefinicionDimensiones:188]HastaGrado:7:=-100
				[MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5:=0
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;False:C215)
				For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
					$l_bitToSet:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{$i})
					[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?+ $l_bitToSet
				End for 
				
			Else 
				[MPA_DefinicionDimensiones:188]DesdeGrado:6:=alMPA_NivelDesde{$result}
				[MPA_DefinicionDimensiones:188]HastaGrado:7:=alMPA_NivelHasta{$result}
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;False:C215)
		End case 
		
	Else 
		Case of 
			: ($result=(Size of array:C274(atMPA_EtapasArea)+3))
				vtMPA_EtapaObjeto:="Asignación por nivel"
				[MPA_DefinicionDimensiones:188]DesdeGrado:6:=999
				[MPA_DefinicionDimensiones:188]HastaGrado:7:=999
				  //For ($i;alMPA_NivelDesde{atMPA_EtapasArea};alMPA_NivelHasta{atMPA_EtapasArea})
				  //$l_bitToSet:=Find in array(<>aNivNo;$i)
				  //[MPA_DefinicionDimensiones]BitsNiveles:=[MPA_DefinicionDimensiones]BitsNiveles ?+ $l_bitToSet
				  //End for 
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;True:C214)
				
			: ($result>Size of array:C274(atMPA_EtapasArea))
				$l_recNumDimension:=Record number:C243([MPA_DefinicionDimensiones:188])
				vtMPA_EtapaObjeto:="Todos los niveles"
				OK:=MPAcfg_Dim_CambiaEtapa ($l_recNumDimension;-100;-100;"")
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;False:C215)
				
			Else 
				$l_recNumDimension:=Record number:C243([MPA_DefinicionDimensiones:188])
				If (([MPA_DefinicionDimensiones:188]DesdeGrado:6#alMPA_NivelDesde{$result}) | ([MPA_DefinicionDimensiones:188]HastaGrado:7#alMPA_NivelHasta{$result}))
					If ($result<=Size of array:C274(atMPA_EtapasArea))
						OK:=MPAcfg_Dim_CambiaEtapa ($l_recNumDimension;alMPA_NivelDesde{$result};alMPA_NivelHasta{$result};atMPA_EtapasArea{$result})
					End if 
				End if 
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;False:C215)
		End case 
	End if 
	
	READ ONLY:C145([xxSTR_Niveles:6])
	Case of 
		: (([MPA_DefinicionDimensiones:188]DesdeGrado:6=999) & ([MPA_DefinicionDimensiones:188]HastaGrado:7=999))
			vtMPA_EtapaObjeto:=__ ("Asignación por nivel")
			vtMPA_NivelesEtapa:=""
			
		: (([MPA_DefinicionDimensiones:188]DesdeGrado:6>-100) & ([MPA_DefinicionDimensiones:188]HastaGrado:7>-100))
			$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;[MPA_DefinicionDimensiones:188]DesdeGrado:6)
			If ($recNum>=0)
				GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
				vtMPA_NivelesEtapa:=[xxSTR_Niveles:6]Nivel:1
			End if 
			If ([MPA_DefinicionDimensiones:188]DesdeGrado:6#[MPA_DefinicionDimensiones:188]HastaGrado:7)
				$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;[MPA_DefinicionDimensiones:188]HastaGrado:7)
				If ($recNum>=0)
					GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
					vtMPA_NivelesEtapa:=vtMPA_NivelesEtapa+__ (" a ")+[xxSTR_Niveles:6]Nivel:1
				End if 
			End if 
			alMPA_NivelDesde{0}:=[MPA_DefinicionDimensiones:188]DesdeGrado:6
			alMPA_NivelHasta{0}:=[MPA_DefinicionDimensiones:188]HastaGrado:7
			ARRAY LONGINT:C221($DA_Return;0)
			AT_MultiArraySearch (True:C214;->$DA_Return;->alMPA_NivelDesde;->alMPA_NivelHasta)
			If (Size of array:C274($DA_Return)=1)
				vtMPA_EtapaObjeto:=atMPA_EtapasArea{$DA_Return{1}}
			End if 
		Else 
			vtMPA_EtapaObjeto:=__ ("Todas")
			vtMPA_NivelesEtapa:=""
	End case 
	
	
End if 